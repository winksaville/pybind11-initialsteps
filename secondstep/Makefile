# Get from pybind11 for the -I parameters it needs
INCLUDES=$(shell python3 -m pybind11 --includes)

# Get from python the extension needed for this platform
DOT_EXT=$(shell python3-config --extension-suffix)

.PHONY: help
help:
	@echo targets:
	@echo run: buildit and then run example.py
	@echo buildit: Build example.$(DOT_EXT)
	@echo clean: Clean artificats

.PHONY: run
run: buildit
	python example.py

.PHONY: buildit
buildit: example$(DOT_EXT)

example$(DOT_EXT): build/add.obj build/example.obj
	g++ -shared -fPIC -o $@ $^

build:
	mkdir -p build

build/example.obj: src/example.cxx inc/add.hxx | build
	g++ -O3 -Wall -std=c++11 -fPIC -I inc $(INCLUDES) -o $@ -c $<

build/add.obj: src/add.cxx inc/add.hxx | build
	g++ -O3 -Wall -std=c++11 -fPIC -I inc -o $@ -c $<

.PHONY: clean
clean:
	rm -rf example$(DOT_EXT) build
