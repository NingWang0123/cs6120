#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100000000

// NOT parallelizable due to reduction - demonstrates loop-carried dependency
int sum_array(int *arr, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += arr[i];
    }
    return sum;
}

// Parallelizable - independent computation
void compute_squares(int *input, int *output, int n) {
    for (int i = 0; i < n; i++) {
        output[i] = input[i] * input[i];
    }
}

int main() {
    int *arr = (int *)malloc(N * sizeof(int));
    int *squares = (int *)malloc(N * sizeof(int));

    // Initialize array
    for (int i = 0; i < N; i++) {
        arr[i] = i % 1000;
    }

    clock_t start = clock();
    compute_squares(arr, squares, N);
    clock_t end = clock();

    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Compute squares time: %f seconds\n", time_spent);

    start = clock();
    long long sum = sum_array(arr, N);
    end = clock();

    time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Sum time: %f seconds\n", time_spent);
    printf("Sum: %lld\n", sum);

    // Verify a few squares
    int errors = 0;
    for (int i = 0; i < 100 && errors < 5; i++) {
        if (squares[i] != arr[i] * arr[i]) {
            printf("Error at index %d\n", i);
            errors++;
        }
    }

    if (errors == 0) {
        printf("Verification passed!\n");
    }

    free(arr);
    free(squares);

    return 0;
}
