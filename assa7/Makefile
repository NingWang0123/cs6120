# ==== Config ================================================================
LLVM_PREFIX ?= $(shell brew --prefix llvm 2>/dev/null)
LLVM_CONFIG ?= $(LLVM_PREFIX)/bin/llvm-config
CLANG      ?= $(LLVM_PREFIX)/bin/clang
OPT        ?= $(LLVM_PREFIX)/bin/opt
CXX        ?= $(LLVM_PREFIX)/bin/clang++

# Disable Homebrew clang default config that may point to a bad SDK
export CLANG_NO_DEFAULT_CONFIG := 1

# Current macOS SDK
SDK := $(shell xcrun --sdk macosx --show-sdk-path 2>/dev/null)

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  SHLIB_EXT := dylib
  SOFLAGS   := -dynamiclib -Wl,-undefined,dynamic_lookup
else
  SHLIB_EXT := so
  SOFLAGS   := -shared
endif

# Sources (add/remove as you like)
LOGGER_SRC := src/FloatDivLogger.cpp
OPT_SRC    := src/FloatDivOptPass.cpp

# Targets (built only if source exists)
LOGGER_SO := FloatDivLogger.$(SHLIB_EXT)
OPT_SO    := FloatDivOpt.$(SHLIB_EXT)

# llvm-config flags
LLVM_CXXFLAGS := $(shell $(LLVM_CONFIG) --cxxflags)
# For pass plugins, we usually do not need to link LLVM libs explicitly
LLVM_LDFLAGS  :=

# Common flags
CXXFLAGS += -std=c++17 -fPIC -fno-exceptions -fno-rtti $(LLVM_CXXFLAGS) -O2
# Use the correct sysroot on all C++ compilations
ifneq ($(SDK),)
  CXXFLAGS += -isysroot $(SDK)
  LDFLAGS  += -isysroot $(SDK)
endif
LDFLAGS  += $(SOFLAGS) $(LLVM_LDFLAGS)

# ==== Rules ================================================================
.PHONY: all clean test run test-opt run-opt

# Build whichever plugins have sources
ALL_PLUGINS :=
ifneq ($(wildcard $(LOGGER_SRC)),)
  ALL_PLUGINS += $(LOGGER_SO)
endif
ifneq ($(wildcard $(OPT_SRC)),)
  ALL_PLUGINS += $(OPT_SO)
endif

all: $(ALL_PLUGINS)
	@echo "Built: $(ALL_PLUGINS)"

# Pattern: build a plugin from one .cpp
%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(LOGGER_SO): $(LOGGER_SRC:.cpp=.o)
	$(CXX) $(LDFLAGS) -o $@ $^

$(OPT_SO): $(OPT_SRC:.cpp=.o)
	$(CXX) $(LDFLAGS) -o $@ $^

clean:
	rm -f src/*.o $(LOGGER_SO) $(OPT_SO) before.ll after.ll after_opt.ll test_app

distclean: clean
	rm -f test.c

# --- Quick demo helpers -----------------------------------------------------
test.c:
	@[ -f $@ ] || { \
	  printf '%s\n' '#include <stdio.h>' \
	    'int main(){ float a=10.0f,b=2.0f,c=(a+b)/b; printf("c=%.2f\\n",c); return 0; }' > $@; \
	  echo "Generated $@ (demo)."; \
	}

before.ll: test.c
	$(CLANG) -O0 -g -S -emit-llvm $(if $(SDK),-isysroot $(SDK),) $< -o $@

after.ll: before.ll $(LOGGER_SO)
	$(OPT) -load-pass-plugin ./$(LOGGER_SO) -passes="float-div-log" $< -S -o $@



test: $(LOGGER_SO) after.ll
	@echo '--- instrumentation diff (first 120 lines) ---'
	@diff -u before.ll after.ll | sed -n '1,120p' || true

run: after.ll
	$(CLANG) -O0 $(if $(SDK),-isysroot $(SDK),) after.ll -o test_app
	./test_app

# Optional: exercise the optimization pass instead of logger
after_opt.ll: before.ll $(OPT_SO)
	$(OPT) -load-pass-plugin ./$(OPT_SO) -passes="float-div-opt" $< -S -o $@

test-opt: $(OPT_SO) after_opt.ll
	@echo '--- opt diff (first 120 lines) ---'
	@diff -u before.ll after_opt.ll | sed -n '1,120p' || true

run-opt: after_opt.ll
	$(CLANG) -O0 $(if $(SDK),-isysroot $(SDK),) after_opt.ll -o test_app
	./test_app

