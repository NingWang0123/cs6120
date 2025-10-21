#include <stdio.h>
#include <math.h>

static inline float ratiof(float x, float y) { return x / y; }
static inline double ratiod(double x, double y) { return x / y; }

float loop_div(const float *a, const float *b, int n) {
  float acc = 0.0f;
  for (int i = 1; i < n; ++i) {
    // two divides: (a[i] / b[i]) and acc / (float)i
    acc += a[i] / b[i];
    acc = acc / (float)i;
  }
  return acc;
}

double chained(double x, double y, double z) {
  // (x + y) / z  and  x / (y + 1.0)
  return (x + y) / z + x / (y + 1.0);
}

int main() {
  float a = 10.0f, b = 2.0f;
  float c = (a + b) / b;          // fdiv #1
  float d = ratiof(a, b);         // fdiv #2 (inlined)
  double e = ratiod(42.0, 7.0);   // fdiv #3 (double)
  float arrA[5] = {1,2,3,4,5};
  float arrB[5] = {5,4,3,2,1};
  float acc = loop_div(arrA, arrB, 5); // fdivs in a loop (several)
  double g = chained(3.0, 2.0, 5.0);   // two more fdivs

  printf("c=%.2f d=%.2f e=%.2f acc=%.2f g=%.3f\n", c, d, (float)e, acc, g);
  return 0;
}
