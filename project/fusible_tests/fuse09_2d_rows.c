#include <stddef.h>
#ifndef N
#define N 256
#endif
void fuse09_2d_rows(float *__restrict__ A, float *__restrict__ B) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) {
    A[i] = (float)i;
  }
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) {
    B[i] = (float)i + 1.0f;
  }
}
