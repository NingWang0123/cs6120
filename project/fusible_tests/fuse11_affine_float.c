#include <stddef.h>
#ifndef N
#define N 4096
#endif
void fuse11_affine_float(float *__restrict__ a, float *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = (float)i * 1.25f + 3.0f;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = (float)i * 0.75f - 2.0f;
}
