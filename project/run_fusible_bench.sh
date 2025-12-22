#!/bin/bash
# Fusible microbench runner (robust on macOS bash 3.2)
#
# What it does:
#   - Builds a tiny driver per microbench
#   - Builds a baseline (NoPass) binary
#   - Builds bench-only LLVM IR, runs your opt pass (Original / Fusion / Fusion+Shared)
#   - Compiles IR+driver to an executable (object-wise, more robust than mixing inputs)
#   - Runs timings for thread counts (2/4/8 by default)
#   - Prints + CSV logs:
#       * time
#       * fusion markers (from PASS_LOG + IR evidence)
#       * parallelization markers (from PASS_LOG + __kmpc_ evidence)
#
# Design goals:
#   - No `set -e` (never exits early)
#   - No `mapfile` (works on macOS bash 3.2)
#   - No noisy "0" lines from grep fallbacks
#
# Usage:
#   chmod +x ./run_fusible_bench.sh
#   ./run_fusible_bench.sh
#
# Environment knobs:
#   N_DEFAULT=1048576 REPS=10 RUNS=3 THREAD_COUNTS="2 4 8" ./run_fusible_bench.sh
#   PASS_ORIGINAL=... PASS_FUSION=... PASS_FUSION_SHARED=... ./run_fusible_bench.sh

set -u -o pipefail

LLVM_DIR="/opt/homebrew/opt/llvm/bin"
CLANG="${CLANG:-${LLVM_DIR}/clang}"
OPT="${OPT:-${LLVM_DIR}/opt}"

SDKROOT="${SDKROOT:-$(xcrun --show-sdk-path 2>/dev/null || true)}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FUSIBLE_DIR="${FUSIBLE_DIR:-${SCRIPT_DIR}/fusible_tests}"
OUT_BASE="${OUT_BASE:-${SCRIPT_DIR}/fusible_results}"

N_DEFAULT="${N_DEFAULT:-1048576}"        # 1M iterations by default
REPS="${REPS:-10}"                       # repetitions inside timed region
RUNS="${RUNS:-3}"                        # number of runs averaged
THREAD_COUNTS="${THREAD_COUNTS:-2 4 8}"  # thread counts to test

# Default pass locations (match your project layout)
PASS_ORIGINAL="${PASS_ORIGINAL:-${SCRIPT_DIR}/polybench_results/pass_original.dylib}"
PASS_FUSION="${PASS_FUSION:-${SCRIPT_DIR}/polybench_results/pass_fusion.dylib}"
PASS_FUSION_SHARED="${PASS_FUSION_SHARED:-${SCRIPT_DIR}/polybench_results/pass_fusion_shared.dylib}"

OMP_LIB_DIR="${OMP_LIB_DIR:-/opt/homebrew/opt/libomp/lib}"

die() { echo "Error: $*" >&2; exit 1; }
need_file() { [ -f "$1" ] || die "Missing file: $1"; }
need_dir()  { [ -d "$1" ] || die "Missing directory: $1"; }

ts_dir() { date +"%Y%m%d_%H%M%S"; }

# Average numeric CLI args, print N/A if none
avg_numbers() {
  python3 - "$@" <<'PY'
import sys
vals=[]
for x in sys.argv[1:]:
  if x=="N/A": continue
  try: vals.append(float(x))
  except: pass
if not vals:
  print("N/A")
else:
  print(f"{sum(vals)/len(vals):.6f}")
PY
}

# Run executable $runs times with OMP_NUM_THREADS=$th; expects program prints a single float line.
run_and_capture_time() {
  local exe="$1"
  local th="$2"
  local runs="$3"

  local times=()
  local i out
  for i in $(seq 1 "$runs"); do
    out="$(OMP_NUM_THREADS="$th" "$exe" 2>/dev/null || true)"
    if echo "$out" | grep -Eq '^[0-9]+\.[0-9]+$'; then
      times+=("$out")
    else
      echo "N/A"
      return 1
    fi
  done
  avg_numbers "${times[@]}"
  return 0
}

# Helper: safe grep -c that never prints stray output
grepc() {
  local pat="$1"
  local file="$2"
  local n
  n="$(grep -c "$pat" "$file" 2>/dev/null || true)"
  echo "${n:-0}"
}

echo "========================================"
echo "  Fusible Micro-bench Comparison"
echo "========================================"
echo ""

need_dir "$FUSIBLE_DIR"
need_file "$PASS_ORIGINAL"
need_file "$PASS_FUSION"
need_file "$PASS_FUSION_SHARED"

RESULTS_DIR="${OUT_BASE}/$(ts_dir)"
mkdir -p "$RESULTS_DIR"
echo "Results dir: $RESULTS_DIR"
echo ""

# Gather benchmarks
BENCH_FILES=()
while IFS= read -r f; do
  BENCH_FILES+=("$f")
done < <(find "$FUSIBLE_DIR" -maxdepth 1 -name "*.c" -type f | sort)

[ "${#BENCH_FILES[@]}" -gt 0 ] || die "No .c files in $FUSIBLE_DIR"

echo "Found ${#BENCH_FILES[@]} fusible benchmarks in $FUSIBLE_DIR"
echo ""
echo "Implementations enabled: 4"
echo "  - NoPass"
echo "  - OriginalPass"
echo "  - Fusion"
echo "  - Fusion+Shared"
echo ""

CSV="${RESULTS_DIR}/results.csv"
echo "benchmark,implementation,threads,time,parallelizable_loops,parallelized_loops,parallel_ir,omp_calls_out,fusion_applied_pairs,fusion_candidates,fusion_attempts,fusion_succeeded,fused_ir,br_i1_in,br_i1_out" > "$CSV"

if [ -n "$SDKROOT" ]; then
  SYSROOT_FLAGS=(-isysroot "$SDKROOT")
else
  SYSROOT_FLAGS=()
fi

idx=0
for bench_path in "${BENCH_FILES[@]}"; do
  idx=$((idx + 1))
  bench_file="$(basename "$bench_path")"
  bench_name="${bench_file%.c}"

  echo "[$idx/${#BENCH_FILES[@]}] $bench_name"

  BENCH_OUT="${RESULTS_DIR}/${bench_name}"
  mkdir -p "$BENCH_OUT"

  # Detect "void bench_name(...)" and require exactly 2 args (one comma).
  # This matches most of your fusible microbenches; if you later want >2 args, we can extend.
  sig_line="$(grep -nE "^[[:space:]]*(static[[:space:]]+)?void[[:space:]]+${bench_name}[[:space:]]*\\(" "$bench_path" | head -n 1 || true)"
  if [ -z "$sig_line" ]; then
    echo "  SKIP: cannot find function definition void ${bench_name}(...)"
    echo ""
    continue
  fi
  sig_text="$(echo "$sig_line" | sed -E "s/.*void[[:space:]]+${bench_name}[[:space:]]*\\((.*)\\).*/\\1/")"
  comma_count="$(echo "$sig_text" | awk -F"," '{print NF-1}')"
  if [ "$comma_count" -ne 1 ]; then
    echo "  SKIP: signature not 2-arg: ($sig_text)"
    echo ""
    continue
  fi

  # ------------------------------------------------------------------
  # Generate driver
  # ------------------------------------------------------------------
  DRIVER_C="${BENCH_OUT}/driver.c"
  cat > "$DRIVER_C" <<EOF
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#ifndef N
#define N ${N_DEFAULT}
#endif
#ifndef REPS
#define REPS ${REPS}
#endif

// We'll call the bench as (void*, void*). Your microbenches use pointer args.
// (This avoids having to parse the exact types.)
extern void ${bench_name}(void*, void*);

static double now_sec(void) {
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  return (double)ts.tv_sec + 1e-9 * (double)ts.tv_nsec;
}

static void *xaligned_alloc(size_t alignment, size_t size) {
  void *p = NULL;
  if (posix_memalign(&p, alignment, size) != 0) return NULL;
  return p;
}

int main(void) {
  const size_t bytes = (size_t)N * 32;
  uint8_t *a = (uint8_t*)xaligned_alloc(64, bytes);
  uint8_t *b = (uint8_t*)xaligned_alloc(64, bytes);
  if (!a || !b) return 2;

  for (size_t i = 0; i < bytes; i += 64) { a[i]=(uint8_t)i; b[i]=(uint8_t)(i^0x5a); }

  // warmup
  ${bench_name}((void*)a,(void*)b);

  double t0 = now_sec();
  for (int r=0; r<REPS; r++) {
    ${bench_name}((void*)a,(void*)b);
  }
  double t1 = now_sec();

  printf("%.6f\\n", (t1 - t0));
  free(a); free(b);
  return 0;
}
EOF

  # ------------------------------------------------------------------
  # NoPass baseline build+run (serial baseline, threads=1)
  # ------------------------------------------------------------------
  NOPASS_EXE="${BENCH_OUT}/${bench_name}_NoPass.exe"
  NOPASS_BUILD_LOG="${BENCH_OUT}/NoPass.build.log"

  if "$CLANG" "${SYSROOT_FLAGS[@]}" -O2 -DN="${N_DEFAULT}" -DREPS="${REPS}" \
      -fno-vectorize -fno-slp-vectorize -fno-unroll-loops -fno-inline \
      "$DRIVER_C" "$bench_path" -o "$NOPASS_EXE" \
      >"$NOPASS_BUILD_LOG" 2>&1; then
    t="$(run_and_capture_time "$NOPASS_EXE" 1 "$RUNS" || echo "N/A")"
    echo "  NoPass: time=${t}"
    echo "${bench_name},NoPass,1,${t},0,0,0,0,0,0,0,0,0,0,0" >> "$CSV"
  else
    echo "  NoPass: build failed (see $(basename "$NOPASS_BUILD_LOG"))"
    echo "${bench_name},NoPass,1,N/A,0,0,0,0,0,0,0,0,0,0,0" >> "$CSV"
  fi

  # ------------------------------------------------------------------
  # Build bench-only IR once (pass runs on this)
  # ------------------------------------------------------------------
  BENCH_LL="${BENCH_OUT}/${bench_name}.ll"
  IR_LOG="${BENCH_OUT}/bench_ir.build.log"

  if ! "$CLANG" "${SYSROOT_FLAGS[@]}" -O1 -S -emit-llvm -DN="${N_DEFAULT}" \
        -fno-vectorize -fno-slp-vectorize -fno-unroll-loops -fno-inline \
        "$bench_path" -o "$BENCH_LL" >"$IR_LOG" 2>&1; then
    echo "  IR compile failed (see $(basename "$IR_LOG"))"
    # N/A rows for pass impls
    for impl in "OriginalPass" "Fusion" "Fusion+Shared"; do
      for th in $THREAD_COUNTS; do
        echo "${bench_name},${impl},${th},N/A,0,0,0,0,0,0,0,0,0,0,0" >> "$CSV"
      done
    done
    echo ""
    continue
  fi

  # For IR evidence (fusion)
  br_i1_in="$(grepc "br i1" "$BENCH_LL")"

  # ------------------------------------------------------------------
  # Pass implementations
  # ------------------------------------------------------------------
  for impl in "OriginalPass" "Fusion" "Fusion+Shared"; do
    case "$impl" in
      "OriginalPass") PASS_FILE="$PASS_ORIGINAL"; ENABLE_FUSION="false" ;;
      "Fusion")       PASS_FILE="$PASS_FUSION"; ENABLE_FUSION="true" ;;
      "Fusion+Shared")PASS_FILE="$PASS_FUSION_SHARED"; ENABLE_FUSION="true" ;;
    esac

    PASS_LOG="${BENCH_OUT}/${bench_name}_${impl}.pass.log"
    OUT_LL="${BENCH_OUT}/${bench_name}_${impl}.out.ll"

    # Run opt (never fail the whole runner)
    "$OPT" -load-pass-plugin="$PASS_FILE" \
      -passes="loop-simplify,loop-parallelize" \
      -enable-loop-parallel=true \
      -enable-loop-fusion="$ENABLE_FUSION" \
      "$BENCH_LL" -S -o "$OUT_LL" \
      2> "$PASS_LOG" || true

    # If OUT_LL missing/empty, mark build/run as failed for this impl
    if [ ! -s "$OUT_LL" ]; then
      echo "  ${impl}: opt failed (empty out.ll)  fused_log=0/0 fused_ir=0  parallel_log=0 parallel_ir=0"
      for th in $THREAD_COUNTS; do
        echo "${bench_name},${impl},${th},N/A,0,0,0,0,0,0,0,0,0,${br_i1_in},0" >> "$CSV"
      done
      continue
    fi

    # -------------------------
    # Robust per-impl log parsing
    # -------------------------
    parallelizable_loops="$(grepc "Found parallelizable loop" "$PASS_LOG")"
    parallelized_loops="$(grepc "Successfully parallelized loop" "$PASS_LOG")"
    fusion_applied_pairs="$(grep -c '^[[:space:]]*FUSION_APPLIED ' "$PASS_LOG" 2>/dev/null || true)"
    fusion_applied_pairs="${fusion_applied_pairs:-0}"

    fusion_summary_line="$(grep -m1 'LOOP_FUSION_SUMMARY' "$PASS_LOG" 2>/dev/null || true)"
    fusion_candidates="$(printf "%s" "$fusion_summary_line" | sed -n 's/.*candidates=\([0-9][0-9]*\).*/\1/p')"
    fusion_attempts="$(printf "%s" "$fusion_summary_line" | sed -n 's/.*attempts=\([0-9][0-9]*\).*/\1/p')"
    fusion_succeeded="$(printf "%s" "$fusion_summary_line" | sed -n 's/.*succeeded=\([0-9][0-9]*\).*/\1/p')"
    fusion_candidates="${fusion_candidates:-0}"
    fusion_attempts="${fusion_attempts:-0}"
    fusion_succeeded="${fusion_succeeded:-0}"

    # If summary parsing failed but we do see FUSION_APPLIED, fall back.
    if [ "$fusion_candidates" -eq 0 ] && [ "$fusion_applied_pairs" -gt 0 ]; then
      fusion_candidates="$fusion_applied_pairs"
      fusion_attempts="$fusion_applied_pairs"
      fusion_succeeded="$fusion_applied_pairs"
    fi

    # -------------------------
    # IR-based proof signals
    # -------------------------
    br_i1_out="$(grepc "br i1" "$OUT_LL")"
    omp_calls_out="$(grepc "__kmpc_" "$OUT_LL")"

    fused_ir=0
    if [ "$br_i1_in" -gt 0 ] && [ "$br_i1_out" -gt 0 ] && [ "$br_i1_out" -lt "$br_i1_in" ]; then
      fused_ir=1
    fi

    parallel_ir=0
    if [ "$omp_calls_out" -gt 0 ]; then
      parallel_ir=1
    fi

    # -------------------------
    # Compile: OUT_LL -> bench.o ; driver.c -> driver.o ; link -> exe
    # -------------------------
    BENCH_O="${BENCH_OUT}/${bench_name}_${impl}.bench.o"
    DRIVER_O="${BENCH_OUT}/${bench_name}_${impl}.driver.o"
    EXE="${BENCH_OUT}/${bench_name}_${impl}.exe"
    BUILD_LOG="${BENCH_OUT}/${bench_name}_${impl}.build.log"

    ok_build=1
    {
      "$CLANG" "${SYSROOT_FLAGS[@]}" -O2 -c "$OUT_LL" -o "$BENCH_O"
      "$CLANG" "${SYSROOT_FLAGS[@]}" -O2 -DN="${N_DEFAULT}" -DREPS="${REPS}" -c "$DRIVER_C" -o "$DRIVER_O"
      "$CLANG" "${SYSROOT_FLAGS[@]}" -O2 "$BENCH_O" "$DRIVER_O" -o "$EXE" \
        -fopenmp -L"$OMP_LIB_DIR" -lm
    } >"$BUILD_LOG" 2>&1 || ok_build=0

    if [ "$ok_build" -eq 0 ] || [ ! -f "$EXE" ]; then
      echo "  ${impl}: build failed (see $(basename "$BUILD_LOG"))  fused_log=${fusion_succeeded}/${fusion_candidates} fused_ir=${fused_ir}  parallel_log=${parallelized_loops} parallel_ir=${parallel_ir}"
      for th in $THREAD_COUNTS; do
        echo "${bench_name},${impl},${th},N/A,${parallelizable_loops},${parallelized_loops},${parallel_ir},${omp_calls_out},${fusion_applied_pairs},${fusion_candidates},${fusion_attempts},${fusion_succeeded},${fused_ir},${br_i1_in},${br_i1_out}" >> "$CSV"
      done
      continue
    fi

    # -------------------------
    # Run timings for each thread count
    # -------------------------
    for th in $THREAD_COUNTS; do
      t="$(run_and_capture_time "$EXE" "$th" "$RUNS" || echo "N/A")"
      echo "${bench_name},${impl},${th},${t},${parallelizable_loops},${parallelized_loops},${parallel_ir},${omp_calls_out},${fusion_applied_pairs},${fusion_candidates},${fusion_attempts},${fusion_succeeded},${fused_ir},${br_i1_in},${br_i1_out}" >> "$CSV"
      echo "  ${impl} (t=${th}): time=${t}  fused_log=${fusion_succeeded}/${fusion_candidates} fused_ir=${fused_ir} (br_i1 ${br_i1_in}->${br_i1_out})  parallel_log=${parallelized_loops} parallel_ir=${parallel_ir} (__kmpc_=${omp_calls_out})"
    done
  done

  echo ""
done

echo "Done. Wrote:"
echo "  - $CSV"
echo "  - per-benchmark artifacts under $RESULTS_DIR/<bench>/"
