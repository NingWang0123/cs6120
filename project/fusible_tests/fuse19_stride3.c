#include <stddef.h>
#ifndef N
#define N 4096
#endif
void fuse19_stride3(float *__restrict__ a, float *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[3*i] = (float)i * 2.0f;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[3*i] = (float)i + 1.0f;
}
