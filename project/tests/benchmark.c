#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

#define N 50000000

double get_wall_time() {
    struct timeval time;
    gettimeofday(&time, NULL);
    return (double)time.tv_sec + (double)time.tv_usec * 1e-6;
}

// Test 1: Simple array operations
void test_array_ops(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] * 2.0f + b[i] * 3.0f;
    }
}

// Test 2: Array scaling and offset
void test_scale_offset(float *input, float *output, int n, float scale, float offset) {
    for (int i = 0; i < n; i++) {
        output[i] = input[i] * scale + offset;
    }
}

// Test 3: Element-wise operations
void test_elementwise(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = (a[i] + b[i]) * (a[i] - b[i]);
    }
}

int main(int argc, char **argv) {
    printf("Running benchmarks with N=%d\n", N);

    float *a = (float *)malloc(N * sizeof(float));
    float *b = (float *)malloc(N * sizeof(float));
    float *c = (float *)malloc(N * sizeof(float));

    // Initialize
    for (int i = 0; i < N; i++) {
        a[i] = (float)i / N;
        b[i] = (float)(N - i) / N;
    }

    // Test 1: Array operations
    double start = get_wall_time();
    test_array_ops(a, b, c, N);
    double end = get_wall_time();
    printf("Array ops: %.6f seconds\n", end - start);

    // Test 2: Scale and offset
    start = get_wall_time();
    test_scale_offset(a, c, N, 2.5f, 1.0f);
    end = get_wall_time();
    printf("Scale offset: %.6f seconds\n", end - start);

    // Test 3: Element-wise operations
    start = get_wall_time();
    test_elementwise(a, b, c, N);
    end = get_wall_time();
    printf("Elementwise: %.6f seconds\n", end - start);

    // Verification
    printf("Sample results: c[0]=%.4f, c[%d]=%.4f, c[%d]=%.4f\n",
           c[0], N/2, c[N/2], N-1, c[N-1]);

    free(a);
    free(b);
    free(c);

    return 0;
}
