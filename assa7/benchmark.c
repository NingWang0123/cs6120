#include <stdio.h>
#include <time.h>
#include <stdint.h>

// ---- 1) Many constant denominators ----
static inline float compute_constants(float x) {
    float y = 0.0f;
    y += x / 2.0f;
    y += x / 3.0f;
    y += x / 5.0f;
    y += (x + 1.0f) / 4.0f;
    y += (x - 7.0f) / 8.0f;
    return y;
}

// ---- 2) Same variable denominator reused within a basic block ----
static inline float reuse_same_den(float a, float b, float d) {
    float s1 = a / d;
    float s2 = b / d;
    float s3 = (a + b) / d;
    float s4 = (a - b) / d;
    return s1 + s2 + s3 + s4;
}

// ---- 3) Loop body divides by the same denominator multiple times ----
float loop_div_sum(const float* arr, int n, float den) {
    float acc = 0.0f;
    for (int i = 0; i < n; i++) {
        float num = arr[i] + (float)i * 0.5f;
        acc += num / den;
        acc += (num + 1.0f) / den;
    }
    return acc;
}

// ---- 4) Branches; each side reuses the same (non-const) denominator ----
float branchy(float a, float b, float c) {
    float den = c + 0.25f;
    float r = 0.0f;
    if (a > b) {
        float t1 = a / den;
        float t2 = (a + b) / den;
        r = t1 + t2;
    } else {
        float t1 = b / den;
        float t2 = (b - a) / den;
        r = t1 - t2;
    }
    return r;
}

int main(void) {
    const int ITERATIONS = 10000000;  // 10 million iterations

    float a = 10.0f, b = 2.0f, c = 1.5f;
    float arr[8];
    for (int i = 0; i < 8; i++) arr[i] = 0.25f * i + 1.0f;

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    volatile float result = 0.0f;  // volatile to prevent optimization away

    for (int iter = 0; iter < ITERATIONS; iter++) {
        float r1 = compute_constants(a);
        float r2 = reuse_same_den(a, b, c);
        float r3 = loop_div_sum(arr, 8, b + 3.0f);
        float r4 = branchy(a, b, c);
        result += r1 + r2 + r3 + r4;
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    double elapsed = (end.tv_sec - start.tv_sec) +
                     (end.tv_nsec - start.tv_nsec) / 1e9;

    printf("Result: %.6f\n", result);
    printf("Elapsed time: %.6f seconds\n", elapsed);

    return 0;
}
