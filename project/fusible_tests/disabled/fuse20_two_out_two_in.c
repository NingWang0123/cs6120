#include <stddef.h>
#ifndef N
#define N 4096
#endif
void fuse20_two_out_two_in(float *__restrict__ a,
                           float *__restrict__ b,
                           const float *__restrict__ c,
                           const float *__restrict__ d) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = c[i] * 1.1f + (float)i;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = d[i] * 0.9f - (float)i;
}
