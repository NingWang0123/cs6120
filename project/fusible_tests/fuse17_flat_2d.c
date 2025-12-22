#include <stddef.h>
#ifndef ROWS
#define ROWS 128
#endif
#ifndef COLS
#define COLS 128
#endif
#define N (ROWS*COLS)
void fuse17_flat_2d(float *__restrict__ a, float *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int t=0;t<N;t++) a[t] = (float)(t % COLS) + (float)(t / COLS);
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int t=0;t<N;t++) b[t] = (float)(t % COLS) - (float)(t / COLS);
}
