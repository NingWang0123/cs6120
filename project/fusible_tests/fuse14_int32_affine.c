#include <stddef.h>
#include <stdint.h>
#ifndef N
#define N 4096
#endif
void fuse14_int32_affine(int32_t *__restrict__ a, int32_t *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int32_t i=0;i<N;i++) a[i] = i * 3 + 7;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int32_t i=0;i<N;i++) b[i] = i * 5 - 11;
}
