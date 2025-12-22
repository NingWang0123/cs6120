#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#ifndef N
#define N 1048576
#endif

#ifndef REPS
#define REPS 10
#endif

// Declare without prototype to avoid type-matching issues across float/double/int.
// We will call it through a function-pointer cast.
extern void fuse_should_fuse();

static double now_sec(void) {
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  return (double)ts.tv_sec + 1e-9 * (double)ts.tv_nsec;
}

static void *xaligned_alloc(size_t alignment, size_t size) {
  void *p = NULL;
  if (posix_memalign(&p, alignment, size) != 0) return NULL;
  return p;
}

int main(void) {
  // Over-allocate per element so this works for float/double/int/uint32/etc.
  // If a benchmark uses structs, keep those out (we skip non-2-arg signatures above).
  const size_t bytes = (size_t)N * 32;

  uint8_t *a = (uint8_t*)xaligned_alloc(64, bytes);
  uint8_t *b = (uint8_t*)xaligned_alloc(64, bytes);
  if (!a || !b) {
    fprintf(stderr, "alloc failed\n");
    return 2;
  }

  // Touch memory to fault in pages
  for (size_t i = 0; i < bytes; i += 64) {
    a[i] = (uint8_t)i;
    b[i] = (uint8_t)(i ^ 0x5a);
  }

  // Warmup
  ((void(*)(void*,void*))fuse_should_fuse)((void*)a, (void*)b);

  double t0 = now_sec();
  for (int r = 0; r < REPS; r++) {
    ((void(*)(void*,void*))fuse_should_fuse)((void*)a, (void*)b);
  }
  double t1 = now_sec();

  // Print seconds only (easy parse)
  printf("%.6f\n", (t1 - t0));
  free(a);
  free(b);
  return 0;
}
