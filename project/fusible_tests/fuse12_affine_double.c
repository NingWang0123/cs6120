#include <stddef.h>
#ifndef N
#define N 4096
#endif
void fuse12_affine_double(double *__restrict__ a, double *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = (double)i * 1.125 + 7.0;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = (double)i * 0.625 - 1.0;
}
