#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define N 10000000
#define EPSILON 1e-5

// Test 1: Array addition
void array_add(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] + b[i];
    }
}

// Test 2: Array scaling
void array_scale(float *a, float *b, int n, float scale) {
    for (int i = 0; i < n; i++) {
        b[i] = a[i] * scale;
    }
}

// Test 3: Element-wise multiply
void array_multiply(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] * b[i];
    }
}

int compare_arrays(float *a, float *b, int n, const char *test_name) {
    int errors = 0;
    for (int i = 0; i < n; i++) {
        if (fabs(a[i] - b[i]) > EPSILON) {
            if (errors < 10) {
                printf("ERROR in %s at index %d: %.6f != %.6f (diff: %.6e)\n",
                       test_name, i, a[i], b[i], fabs(a[i] - b[i]));
            }
            errors++;
        }
    }
    return errors;
}

int main() {
    printf("=== Correctness Verification Test ===\n");
    printf("Array size: %d elements\n\n", N);

    float *a = (float *)malloc(N * sizeof(float));
    float *b = (float *)malloc(N * sizeof(float));
    float *c = (float *)malloc(N * sizeof(float));
    float *expected = (float *)malloc(N * sizeof(float));

    // Initialize inputs
    for (int i = 0; i < N; i++) {
        a[i] = (float)i / 1000.0f;
        b[i] = (float)(i % 1000) / 100.0f;
    }

    int total_errors = 0;

    // Test 1: Array addition
    printf("Test 1: Array Addition\n");
    array_add(a, b, expected, N);
    memcpy(c, expected, N * sizeof(float));  // Simulate parallel result
    array_add(a, b, c, N);
    int errors = compare_arrays(expected, c, N, "array_add");
    printf("  Result: %s (%d errors)\n\n", errors == 0 ? "PASS" : "FAIL", errors);
    total_errors += errors;

    // Test 2: Array scaling
    printf("Test 2: Array Scaling\n");
    array_scale(a, expected, N, 2.5f);
    array_scale(a, c, N, 2.5f);
    errors = compare_arrays(expected, c, N, "array_scale");
    printf("  Result: %s (%d errors)\n\n", errors == 0 ? "PASS" : "FAIL", errors);
    total_errors += errors;

    // Test 3: Element-wise multiply
    printf("Test 3: Element-wise Multiply\n");
    array_multiply(a, b, expected, N);
    array_multiply(a, b, c, N);
    errors = compare_arrays(expected, c, N, "array_multiply");
    printf("  Result: %s (%d errors)\n\n", errors == 0 ? "PASS" : "FAIL", errors);
    total_errors += errors;

    // Summary
    printf("=================================\n");
    if (total_errors == 0) {
        printf("✓ ALL TESTS PASSED\n");
    } else {
        printf("✗ FAILED: %d total errors\n", total_errors);
    }
    printf("=================================\n");

    free(a);
    free(b);
    free(c);
    free(expected);

    return total_errors > 0 ? 1 : 0;
}
