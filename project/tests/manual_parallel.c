#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <sys/time.h>

#define N 50000000

double get_wall_time() {
    struct timeval time;
    gettimeofday(&time, NULL);
    return (double)time.tv_sec + (double)time.tv_usec * 1e-6;
}

// Serial version
void array_ops_serial(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] * 2.0f + b[i] * 3.0f;
    }
}

// Parallel version with OpenMP
void array_ops_parallel(float *a, float *b, float *c, int n) {
    #pragma omp parallel for
    for (int i = 0; i < n; i++) {
        c[i] = a[i] * 2.0f + b[i] * 3.0f;
    }
}

int main(int argc, char **argv) {
    int use_parallel = (argc > 1) ? atoi(argv[1]) : 0;

    printf("Allocating arrays of size %d...\n", N);
    float *a = (float *)malloc(N * sizeof(float));
    float *b = (float *)malloc(N * sizeof(float));
    float *c = (float *)malloc(N * sizeof(float));

    // Initialize
    printf("Initializing...\n");
    for (int i = 0; i < N; i++) {
        a[i] = (float)i / N;
        b[i] = (float)(N - i) / N;
    }

    if (use_parallel) {
        printf("Running PARALLEL version");
        printf(" with %d threads\n", omp_get_max_threads());

        double start = get_wall_time();
        array_ops_parallel(a, b, c, N);
        double end = get_wall_time();

        printf("Parallel time: %.6f seconds\n", end - start);
    } else {
        printf("Running SERIAL version\n");

        double start = get_wall_time();
        array_ops_serial(a, b, c, N);
        double end = get_wall_time();

        printf("Serial time: %.6f seconds\n", end - start);
    }

    // Verification
    printf("Sample results: c[0]=%.4f, c[%d]=%.4f\n", c[0], N/2, c[N/2]);

    free(a);
    free(b);
    free(c);

    return 0;
}
