# Makefile for Loop Parallelization Pass

LLVM_CONFIG ?= llvm-config
CLANG ?= clang
OPT ?= opt

# LLVM flags
LLVM_CXXFLAGS := $(shell $(LLVM_CONFIG) --cxxflags)
LLVM_LDFLAGS := $(shell $(LLVM_CONFIG) --ldflags)
LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)

# OpenMP flags
OMP_FLAGS := -fopenmp

# Directories
SRC_DIR := src
BUILD_DIR := build
TEST_DIR := tests

# Targets
PASS_LIB := LoopParallelizationPass.dylib
PASS_OBJ := LoopParallelizationPass.o

.PHONY: all clean build test benchmark

all: build

build:
	@echo "Building with CMake..."
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && cmake .. && make
	@cp $(BUILD_DIR)/$(PASS_LIB) .
	@echo "Build complete: $(PASS_LIB)"

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@rm -f $(PASS_LIB)
	@rm -f *.ll *.bc *.o
	@rm -f test_* bench_*
	@echo "Clean complete"

# Test targets
test: build
	@echo "Running tests..."
	@./run_tests.sh

benchmark: build
	@echo "Running benchmarks..."
	@./run_benchmarks.sh

help:
	@echo "Available targets:"
	@echo "  all       - Build the pass (default)"
	@echo "  build     - Build the pass using CMake"
	@echo "  clean     - Remove all build artifacts"
	@echo "  test      - Run test cases"
	@echo "  benchmark - Run performance benchmarks"
	@echo "  help      - Show this help message"
