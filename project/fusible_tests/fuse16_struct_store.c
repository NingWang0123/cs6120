#include <stddef.h>
#include <stdint.h>
#ifndef N
#define N 4096
#endif
typedef struct { float x; float y; int32_t tag; } S;
void fuse16_struct_store(S *__restrict__ a, S *__restrict__ b) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) { a[i].x = (float)i; a[i].y = (float)i*2.0f; a[i].tag = i; }
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) { b[i].x = (float)i*3.0f; b[i].y = (float)i*4.0f; b[i].tag = i^12345; }
}
