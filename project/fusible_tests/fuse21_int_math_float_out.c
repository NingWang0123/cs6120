#include <stddef.h>
#include <stdint.h>
#ifndef N
#define N 4096
#endif
void fuse21_int_math_float_out(float *__restrict__ a, float *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) { uint32_t x = (uint32_t)i * 1103515245u + 12345u; a[i] = (float)(x & 1023u); }
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) { uint32_t y = (uint32_t)i * 1664525u + 1013904223u; b[i] = (float)((y >> 8) & 1023u); }
}
