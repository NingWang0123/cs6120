#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#ifndef N
#define N 1048576
#endif

// include the benchmark code directly
#include "/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_tests/fuse01_independent_constN.c"

static double now_sec(void) {
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  return (double)ts.tv_sec + 1e-9 * (double)ts.tv_nsec;
}

int main(void) {
  // allocate two float buffers (your microbenches are written that way)
  float *a = (float*)aligned_alloc(64, (size_t)N * sizeof(float));
  float *b = (float*)aligned_alloc(64, (size_t)N * sizeof(float));
  if (!a || !b) return 2;

  // warmup
#if 0
  fuse01_independent_constN(a, b, (int)N);
#else
  fuse01_independent_constN(a, b);
#endif

  double t0 = now_sec();

  // run enough work so timing isn't too tiny
  for (int rep = 0; rep < 10; rep++) {
#if 0
    fuse01_independent_constN(a, b, (int)N);
#else
    fuse01_independent_constN(a, b);
#endif
  }

  double t1 = now_sec();
  printf("%.6f\n", (t1 - t0));

  free(a);
  free(b);
  return 0;
}
