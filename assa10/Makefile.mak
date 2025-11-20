PY?=python3
PROG?=grad_desc.bril    
ARGS_A?=x=42
ARGS_B?=x=500
BUILD?=build

TRACER?=tracer_dynamic.py
INJECT?=inject.py
SPEC?=spec.py
HELPER?=tracer_helpers.py

TRACE_OUT=${BUILD}/trace.json
STITCHED_OUT=${BUILD}/stitched.json

PROG_PATH_CMD=case "${PROG}" in *.bril) echo "${BUILD}/prog.json";; *) echo "${PROG}";; esac

.PHONY: all trace inject run-baseline-A run-baseline-B run-stitched-A run-stitched-B \
        eval clean show-config run-pipe prep

all: eval

${BUILD}:
	@mkdir -p ${BUILD}

show-config:
	@echo "PROG=${PROG}"
	@echo "ARGS_A=${ARGS_A}"
	@echo "ARGS_B=${ARGS_B}"
	@echo "BUILD=${BUILD}"


prep: ${BUILD}
	@set -e; \
	if [ "${PROG##*.}" = "bril" ]; then \
	  command -v bril2json >/dev/null 2>&1 || { echo "Error: bril2json not found"; exit 1; }; \
	  echo "[prep] Converting ${PROG} -> ${BUILD}/prog.json"; \
	  bril2json < "${PROG}" > "${BUILD}/prog.json"; \
	else \
	  :; \
	fi


${TRACE_OUT}: ${TRACER} ${HELPER} ${BUILD} prep
	@set -e; \
	PROG_JSON=`${PROG_PATH_CMD}`; \
	if [ "${PROG##*.}" = "bril" ]; then \
	  command -v bril2json >/dev/null 2>&1 || { echo "Error: bril2json not found"; exit 1; }; \
	  echo "[trace] Converting ${PROG} -> $$PROG_JSON"; \
	  bril2json < "${PROG}" > "$$PROG_JSON"; \
	fi; \
	echo "[trace] Running ${TRACER} on $$PROG_JSON"; \
	${PY} ${TRACER} "$$PROG_JSON" ${ARGS_A} > "${TRACE_OUT}"

trace: ${TRACE_OUT}


${STITCHED_OUT}: ${INJECT} ${HELPER} ${TRACE_OUT} | ${BUILD}
	@set -e; \
	PROG_JSON=`${PROG_PATH_CMD}`; \
	if [ "${PROG##*.}" = "bril" ]; then \
	  command -v bril2json >/dev/null 2>&1 || { echo "Error: bril2json not found"; exit 1; }; \
	  [ -f "$$PROG_JSON" ] || { echo "[inject] Converting ${PROG} -> $$PROG_JSON"; bril2json < "${PROG}" > "$$PROG_JSON"; }; \
	fi; \
	echo "[inject] Injecting trace into $$PROG_JSON"; \
	${PY} ${INJECT} "$$PROG_JSON" "${TRACE_OUT}" > "${STITCHED_OUT}"

inject: ${STITCHED_OUT}

run-baseline-A: prep
	@set -e; \
	PROG_JSON=`${PROG_PATH_CMD}`; \
	echo "[run] Baseline A"; \
	${PY} ${SPEC} "$$PROG_JSON" ${ARGS_A}

run-baseline-B: prep
	@set -e; \
	PROG_JSON=`${PROG_PATH_CMD}`; \
	echo "[run] Baseline B"; \
	${PY} ${SPEC} "$$PROG_JSON" ${ARGS_B}

run-stitched-A: ${STITCHED_OUT}
	@echo "[run] Traced A"
	@${PY} ${SPEC} "${STITCHED_OUT}" ${ARGS_A}

run-stitched-B: ${STITCHED_OUT}
	@echo "[run] Traced B"
	@${PY} ${SPEC} "${STITCHED_OUT}" ${ARGS_B}


eval: ${STITCHED_OUT}
	@set -e; \
	PROG_JSON=`${PROG_PATH_CMD}`; \
	echo "== Baseline A ==";  ${PY} ${SPEC} "$$PROG_JSON" ${ARGS_A}; \
	echo "== Baseline B ==";  ${PY} ${SPEC} "$$PROG_JSON" ${ARGS_B}; \
	echo "== Traced A ==";    ${PY} ${SPEC} "${STITCHED_OUT}" ${ARGS_A}; \
	echo "== Traced B ==";    ${PY} ${SPEC} "${STITCHED_OUT}" ${ARGS_B}

run-pipe:
	@command -v bril2json >/dev/null 2>&1 || { echo "bril2json missing"; exit 1; }
	@echo "[pipe] bril2json < ${PROG} | ${PY} ${SPEC} /dev/stdin ${ARGS_A}"
	@bril2json < "${PROG}" | ${PY} ${SPEC} /dev/stdin ${ARGS_A}

clean:
	@rm -rf ${BUILD}
