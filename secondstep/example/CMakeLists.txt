cmake_minimum_required(VERSION 3.13)
project(example VERSION 0.1.0 DESCRIPTION "Example cpython extension")

# Below we set RPATH for the example.xxx.so so that when it is loaded
# the arith library can be found. But, for this example.xxx.so to be found
# PYTHONPATH needs to be set! HOPEFULLY, we can solve this when we
# add setup.py.

# Set the install RPATH so after installing example can find the arth library
set(CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_PREFIX}/lib)

# Set the build RPATH so tests or while developing example can find the arth library
set(CMAKE_BUILD_RPATH ${CMAKE_BINARY_DIR}/arith)

# Add pybind11 so we can use the pybind11_add_module
add_subdirectory(pybind11)
pybind11_add_module(example src/example.cxx)

# Specify example has the arith library as a dependency
target_link_libraries(example PUBLIC arith)

# Specify where example can find arith library include while building
target_include_directories(example PRIVATE ${CMAKE_SOURCE_DIR}/arith/inc)

# Install exampe.*.so into the install library directory
install(TARGETS example
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
