#include <stddef.h>
#include <stdint.h>
#ifndef N
#define N 4096
#endif
void fuse18_uint32_bitops(uint32_t *__restrict__ a, uint32_t *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (uint32_t i=0;i<N;i++) a[i] = (i * 2654435761u) ^ (i >> 3);
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (uint32_t i=0;i<N;i++) b[i] = (i + 1013904223u) ^ (i << 5);
}
