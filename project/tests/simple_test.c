#include <stdio.h>

#define N 1000

// Very simple parallelizable loop
void simple_loop(float *a, float *b, float *c) {
    for (int i = 0; i < N; i++) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    float a[N], b[N], c[N];

    // Initialize
    for (int i = 0; i < N; i++) {
        a[i] = (float)i;
        b[i] = (float)i * 2.0f;
    }

    // Call function
    simple_loop(a, b, c);

    // Print some results
    printf("c[0] = %f\n", c[0]);
    printf("c[%d] = %f\n", N/2, c[N/2]);
    printf("c[%d] = %f\n", N-1, c[N-1]);

    return 0;
}
