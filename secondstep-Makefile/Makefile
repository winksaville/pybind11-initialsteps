# RPATHs for finding dynamic libraries,
RPATHS?=/home/wink/opt/lib:/home/wink/lib

# Get from pybind11 for the -I parameters it needs
INCLUDES=$(shell python3 -m pybind11 --includes)

# Get from python the extension needed for this platform
DOT_EXT=$(shell python3-config --extension-suffix)

.PHONY: help
help:
	@echo targets:
	@echo "run:     build and run example.py,"
	@echo "           optional param: RPATHS=xxx where xxx is path to libraries"
	@echo "           default RPATHS=$(RPATHS)"
	@echo "buildit: Build example$(DOT_EXT)"
	@echo "clean:   Clean artificats"

.PHONY: run
run: buildit
	python useexample.py


.PHONY: buildit
buildit: example$(DOT_EXT)

example$(DOT_EXT): build/example.obj build/libadd.so
	g++ -shared -fPIC -o $@ $< -L./build -ladd -Wl,-rpath=$(RPATHS)

build:
	mkdir -p build

build/example.obj: example.cxx inc/add.hxx | build
	g++ -O3 -Wall -std=c++11 -fPIC -I inc $(INCLUDES) -o $@ -c $<

build/add.obj: src/add.cxx inc/add.hxx | build
	g++ -O3 -Wall -std=c++11 -fPIC -I inc -o $@ -c $<

build/libadd.so: build/add.obj
	g++ -shared -fPIC -o $@ $^

.PHONY: clean
clean:
	rm -rf example$(DOT_EXT) build
