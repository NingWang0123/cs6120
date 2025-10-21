cmake_minimum_required(VERSION 3.20)
project(FloatDivLogger LANGUAGES C CXX)


find_package(LLVM REQUIRED CONFIG HINTS /opt/homebrew/opt/llvm/lib/cmake/llvm)

message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM version: ${LLVM_PACKAGE_VERSION}")


list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)
include(HandleLLVMOptions)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(FloatDivLogger MODULE
  src/FloatDivLogger.cpp
)

target_include_directories(FloatDivLogger PRIVATE ${LLVM_INCLUDE_DIRS})
target_compile_definitions(FloatDivLogger PRIVATE ${LLVM_DEFINITIONS})
set_target_properties(FloatDivLogger PROPERTIES PREFIX "")

if(APPLE)
  # If you want to be explicit about using Homebrew’s toolchain:
  # set(CMAKE_OSX_SYSROOT "$ENV{SDKROOT}")  # or use xcrun below in the shell
  target_compile_options(FloatDivLogger PRIVATE -fPIC)
endif()

if(APPLE)
  set(CMAKE_SHARED_MODULE_SUFFIX ".dylib")
endif()