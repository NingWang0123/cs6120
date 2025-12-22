#include <stddef.h>
#ifndef N
#define N 1024
#endif
typedef struct { float x; float y; } P;
void fuse04_struct_fields(P *__restrict__ p) {
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) p[i].x = (float)i;
#pragma clang loop vectorize(disable) interleave(disable) unroll(disable)
  for (int i=0;i<N;i++) p[i].y = (float)i * 3.0f;
}
