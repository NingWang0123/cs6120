#include <stddef.h>
#ifndef N
#define N 1024
#endif
void fuse07_two_outputs(float *__restrict__ a, float *__restrict__ b, float c0, float c1) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = c0 + (float)i;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = c1 - (float)i;
}
