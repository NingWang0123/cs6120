#include <stddef.h>
#ifndef N
#define N 1024
#endif
void fuse08_int_arrays(int *__restrict__ a, int *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) a[i] = i * 2;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) b[i] = i + 7;
}
