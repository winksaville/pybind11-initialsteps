#!/usr/bin/env bash

set -x

# Get from pybind11 for the -I parameters it needs
INCLUDES=`python3 -m pybind11 --includes`

# Get from python the extension needed for this platform
DOT_EXT=`python3-config --extension-suffix`


# Compile
g++ -O3 -Wall -shared -std=c++11 -fPIC -o example$DOT_EXT $INCLUDES example.cpp

# Run
python example.py
