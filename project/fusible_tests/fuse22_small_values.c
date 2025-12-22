#include <stddef.h>
#ifndef N
#define N 4096
#endif
void fuse22_small_values(float *__restrict__ a, float *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = (float)((i & 1) ? 3 : 7) + (float)(i >> 5);
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = (float)((i & 3) * 0.25f) + (float)(i >> 6);
}
