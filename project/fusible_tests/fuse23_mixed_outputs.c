#include <stddef.h>
#include <stdint.h>
#ifndef N
#define N 4096
#endif
void fuse23_mixed_outputs(float *__restrict__ a, int32_t *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = (float)i * 0.125f + 5.0f;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = i * 7 - 3;
}
