cmake_minimum_required(VERSION 3.20)
project(LoopParallelization LANGUAGES C CXX)

# Find LLVM
find_package(LLVM REQUIRED CONFIG HINTS /opt/homebrew/opt/llvm/lib/cmake/llvm)

message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM version: ${LLVM_PACKAGE_VERSION}")

# Include LLVM CMake modules
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)
include(HandleLLVMOptions)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Build the loop parallelization pass
add_library(LoopParallelizationPass MODULE
  src/LoopParallelizationPass.cpp
)

target_include_directories(LoopParallelizationPass PRIVATE ${LLVM_INCLUDE_DIRS})
target_compile_definitions(LoopParallelizationPass PRIVATE ${LLVM_DEFINITIONS})
set_target_properties(LoopParallelizationPass PROPERTIES PREFIX "")

if(APPLE)
  target_compile_options(LoopParallelizationPass PRIVATE -fPIC)
  set(CMAKE_SHARED_MODULE_SUFFIX ".dylib")
endif()

# Link with OpenMP (keg-only on macOS)
if(APPLE)
    set(OpenMP_C_FLAGS "-Xpreprocessor -fopenmp -I/opt/homebrew/opt/libomp/include")
    set(OpenMP_C_LIB_NAMES "omp")
    set(OpenMP_CXX_FLAGS "-Xpreprocessor -fopenmp -I/opt/homebrew/opt/libomp/include")
    set(OpenMP_CXX_LIB_NAMES "omp")
    set(OpenMP_omp_LIBRARY "/opt/homebrew/opt/libomp/lib/libomp.dylib")
endif()

find_package(OpenMP REQUIRED)
if(OpenMP_CXX_FOUND)
    target_link_libraries(LoopParallelizationPass PRIVATE OpenMP::OpenMP_CXX)
    message(STATUS "OpenMP found and linked")
endif()
