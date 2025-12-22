#include <stddef.h>
#ifndef N
#define N 1024
#endif
void fuse01_independent_constN(float *__restrict__ a, float *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = (float)i * 2.0f;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = (float)i + 1.0f;
}
