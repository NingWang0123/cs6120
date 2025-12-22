// Auto-generated driver for fuse11_affine_float
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#ifndef N_DEFAULT
#define N_DEFAULT 4000000
#endif

#ifndef REPS
#define REPS 5
#endif

static double now_sec(void) {
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}

// include the kernel implementation
#include "../fusible_tests/fuse11_affine_float.c"

int main(int argc, char **argv) {
  int n = (argc > 1) ? atoi(argv[1]) : N_DEFAULT;
  if (n <= 0) n = N_DEFAULT;

  // 64-byte aligned allocations
  void *pa = NULL, *pb = NULL;
  if (posix_memalign(&pa, 64, (size_t)n * sizeof(float)) != 0) return 2;
  if (posix_memalign(&pb, 64, (size_t)n * sizeof(float)) != 0) return 3;

  float *a = (float*)pa;
  float *b = (float*)pb;

  // init
  for (int i = 0; i < n; i++) { a[i] = 0.0f; b[i] = 0.0f; }

  // warmup
  fuse11_affine_float(a, b);

  double t0 = now_sec();
  for (int r = 0; r < REPS; r++) {
    fuse11_affine_float(a, b);
  }
  double t1 = now_sec();

  // prevent dead-code elimination
  volatile float sink = a[n-1] + b[n-1];
  if (sink == 123456.0f) fprintf(stderr, "sink=%f\n", (double)sink);

  // print average time per kernel call
  printf("%.6f\n", (t1 - t0) / (double)REPS);

  free(a);
  free(b);
  return 0;
}
