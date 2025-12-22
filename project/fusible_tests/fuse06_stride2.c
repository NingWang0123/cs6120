#include <stddef.h>
#ifndef N
#define N 1024
#endif
void fuse06_stride2(float *__restrict__ a, float *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[2*i] = (float)i;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[2*i] = (float)i + 5.0f;
}
