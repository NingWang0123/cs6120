#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 512

// Matrix multiplication - outer loops are parallelizable
void matrix_multiply(float *A, float *B, float *C, int n) {
    // Initialize result to zero
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            C[i * n + j] = 0.0f;
        }
    }

    // Multiply
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                C[i * n + j] += A[i * n + k] * B[k * n + j];
            }
        }
    }
}

int main() {
    float *A = (float *)malloc(N * N * sizeof(float));
    float *B = (float *)malloc(N * N * sizeof(float));
    float *C = (float *)malloc(N * N * sizeof(float));

    // Initialize matrices
    for (int i = 0; i < N * N; i++) {
        A[i] = (float)(rand() % 100) / 10.0f;
        B[i] = (float)(rand() % 100) / 10.0f;
    }

    clock_t start = clock();
    matrix_multiply(A, B, C, N);
    clock_t end = clock();

    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Time: %f seconds\n", time_spent);

    // Simple verification (check a few elements)
    printf("Sample result C[0][0] = %f\n", C[0]);
    printf("Sample result C[%d][%d] = %f\n", N/2, N/2, C[(N/2) * N + N/2]);

    free(A);
    free(B);
    free(C);

    return 0;
}
