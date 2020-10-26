# Initial steps for using pybind11

Clone the pybind11-initial steps repo:
```
git clone --recursive git@github.com:winksaville/pybind11-initialsteps
cd pybind11-initialsteps/
```

If you forget `--resusive` or `--recurse-submodules` you can use `submodule update`
to update after cloning, see [git-tools-submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules):
for additional information.
```
git clone git@github.com:winksaville/pybind11-initialsteps
cd pybind11-initialsteps
git submodule update --init --recursive
```

## First step

Navigate into the firststep directory:
```
$ cd firststep
```

### The source code for a simple C++ module
A very simple c++ file that uses pybind11 to create a python extension
that makes the add method usable by python code:
```
$ cat example.cpp
#include <pybind11/pybind11.h>

namespace py = pybind11;

int add(int i, int j) {
    return i + j;
}

PYBIND11_MODULE(example, m) {
    m.doc() = "pybind11 example plugin"; // optional module docstring

    m.def("add", &add, "A function which adds two numbers");
}
```

### The python file that uses example.add to add 2 + 5
```
$ cat example.py
import example

print(f"result={example.add(2, 5)}")
```

### The bash script that compiles the extension and runs the python example:
```
$ cat build-run.sh 
#!/usr/bin/env bash

set -x

# Get from pybind11 for the -I parameters it needs
INCLUDES=`python3 -m pybind11 --includes`

# Get from python the extension needed for this platform
DOT_EXT=`python3-config --extension-suffix`


# Compile
g++ -O3 -Wall -shared -std=c++11 -fPIC -o example$DOT_EXT $INCLUDES example.cpp

# Run
python example.py```
## Install, build and run
```

### Install pybind11
Note: with later steps it's not necessary to install pybind11
so you might consider just looking at the code.
```
pip install pybind11
```

### Run
```
$ ./build-run.sh 
++ python3 -m pybind11 --includes
+ INCLUDES='-I/opt/miniconda3/envs/x/include/python3.8 -I/opt/miniconda3/envs/x/lib/python3.8/site-packages/pybind11/include'
++ python3-config --extension-suffix
+ DOT_EXT=.cpython-38-x86_64-linux-gnu.so
+ g++ -O3 -Wall -shared -std=c++11 -fPIC -o example.cpython-38-x86_64-linux-gnu.so -I/opt/miniconda3/envs/x/include/python3.8 -I/opt/miniconda3/envs/x/lib/python3.8/site-packages/pybind11/include example.cpp
+ python example.py
result=7
```

## Second step

A more realistic example where a C library
is going to be converted to a python extension
using cmake.

Navigate into the second directory from pybind11-initialsteps:
```
$ cd secondstep
```

### TODO: Add details for each of the files

```
wink@3900x:~/prgs/python/projects/pybind11-initialsteps (main)
$ tree -L 3 secondstep
secondstep
├── arith
│   ├── CMakeLists.txt
│   ├── inc
│   │   └── arith.hxx
│   └── src
│       └── add.cxx
├── CMakeLists.txt
├── example
│   ├── CMakeLists.txt
│   ├── pybind11
│   └── src
│       └── example.cxx
└── useexample.py
```

### Commands to prepare, build, install and run
```
wink@3900x:~/prgs/python/projects/pybind11-initialsteps/secondstep (main)
cmake -S . -B build -G Ninja -DCMAKE_INSTALL_PREFIX=~/opt/secondstep
cmake --build build
cmake --install build
export PYTHONPATH="$HOME/opt/secondstep/lib"
./useexample.py
```

### The resultsComple 
```
wink@3900x:~/prgs/python/projects/pybind11-initialsteps/secondstep (main)
$ cmake -S . -B build -G Ninja -DCMAKE_INSTALL_PREFIX=~/opt/secondstep
-- The C compiler identification is GNU 10.2.0
-- The CXX compiler identification is GNU 10.2.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- pybind11 v2.6.1 dev1
-- Found PythonInterp: /usr/bin/python3.8 (found version "3.8.6") 
-- Found PythonLibs: /usr/lib/libpython3.8.so
-- Performing Test HAS_FLTO
-- Performing Test HAS_FLTO - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /home/wink/prgs/python/projects/pybind11-initialsteps/secondstep/build
wink@3900x:~/prgs/python/projects/pybind11-initialsteps/secondstep (main)
$ cmake --build build
[5/5] Linking CXX shared module example/example.cpython-38-x86_64-linux-gnu.so
wink@3900x:~/prgs/python/projects/pybind11-initialsteps/secondstep (main)
$ cmake --install build
-- Install configuration: ""
-- Installing: /home/wink/opt/secondstep/lib/libarith.so.0.2.0
-- Up-to-date: /home/wink/opt/secondstep/lib/libarith.so.1
-- Up-to-date: /home/wink/opt/secondstep/lib/libarith.so
-- Installing: /home/wink/opt/secondstep/include/arith.hxx
-- Installing: /home/wink/opt/secondstep/lib/example.cpython-38-x86_64-linux-gnu.so
-- Set runtime path of "/home/wink/opt/secondstep/lib/example.cpython-38-x86_64-linux-gnu.so" to "/home/wink/opt/secondstep/lib"
wink@3900x:~/prgs/python/projects/pybind11-initialsteps/secondstep (main)
$ export PYTHONPATH="$HOME/opt/secondstep/lib"
wink@3900x:~/prgs/python/projects/pybind11-initialsteps/secondstep (main)
$ ./useexample.py 
result=7
```
