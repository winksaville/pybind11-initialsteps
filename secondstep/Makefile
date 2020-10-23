# RPATHs for finding dynamic libraries,
RPATH?=$(HOME)/opt/arith

# Get from pybind11 for the -I parameters it needs
INCLUDES=$(shell python3 -m pybind11 --includes)

# Get from python the extension needed for this platform
DOT_EXT=$(shell python3-config --extension-suffix)

.PHONY: help
help:
	@echo targets:
	@echo "run:     build and run example.py,"
	@echo "           optional param: RPATH=xxx where xxx is path to libraries"
	@echo "           default RPATH=$(RPATH)"
	@echo "buildit: Build example$(DOT_EXT)"
	@echo "clean:   Clean artificats"

.PHONY: run
run: buildit
	python useexample.py


.PHONY: buildit
buildit: example$(DOT_EXT)

example$(DOT_EXT): build/example.obj $(RPATH)/lib/libarith.so
	g++ -shared -fPIC -o $@ $< -L$(RPATH)/lib -larith -Wl,-rpath=$(RPATH)/lib

build:
	mkdir -p build

build/example.obj: example.cxx | build
	g++ -O3 -Wall -std=c++11 -fPIC -I $(RPATH)/include $(INCLUDES) -o $@ -c $<

.PHONY: libarith
libarith:
	(cd libarith && cmake -S . -B build && cmake --build build && cmake --install build)


$(RPATH)/lib/libarith.so: libarith

.PHONY: clean
clean:
	rm -rf example$(DOT_EXT) build libarith/build
