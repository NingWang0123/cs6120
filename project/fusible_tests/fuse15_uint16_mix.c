#include <stddef.h>
#include <stdint.h>
#ifndef N
#define N 4096
#endif
void fuse15_uint16_mix(uint16_t *__restrict__ a, uint16_t *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = (uint16_t)((i * 17) ^ (i >> 1));
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = (uint16_t)((i * 9)  + (i & 255));
}
