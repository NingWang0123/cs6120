#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 10000000

// Simple parallelizable loop - array addition
void array_add(int *a, int *b, int *c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    int *a = (int *)malloc(N * sizeof(int));
    int *b = (int *)malloc(N * sizeof(int));
    int *c = (int *)malloc(N * sizeof(int));

    // Initialize arrays
    for (int i = 0; i < N; i++) {
        a[i] = i;
        b[i] = i * 2;
    }

    clock_t start = clock();
    array_add(a, b, c, N);
    clock_t end = clock();

    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Time: %f seconds\n", time_spent);

    // Verify result
    int errors = 0;
    for (int i = 0; i < N && errors < 10; i++) {
        if (c[i] != a[i] + b[i]) {
            printf("Error at index %d: %d != %d\n", i, c[i], a[i] + b[i]);
            errors++;
        }
    }

    if (errors == 0) {
        printf("Verification passed!\n");
    }

    free(a);
    free(b);
    free(c);

    return 0;
}
