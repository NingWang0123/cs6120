#include <stddef.h>
#ifndef N
#define N 4096
#endif
void fuse13_two_out_one_in(float *__restrict__ a,
                           float *__restrict__ b,
                           const float *__restrict__ c) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = c[i] * 2.0f + (float)i;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = c[i] * 0.5f - (float)i;
}
