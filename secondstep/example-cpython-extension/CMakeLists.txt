cmake_minimum_required(VERSION 3.13)
project(example-cpyton-extension VERSION 0.1.0 DESCRIPTION "Example cpython extension")

#cmake_print_variables(CMAKE_SOURCE_DIR CMAKE_INSTALL_PREFIX CMAKE_CURRENT_BINARY_DIR)

add_subdirectory(pybind11)
pybind11_add_module(example src/example.cxx)

# The example library depends on libarith aka arith
target_link_libraries(example PUBLIC arith)

# Specify where example can find libarth include
target_include_directories(example PRIVATE ${CMAKE_SOURCE_DIR}/libarith/inc)

# Specify where example can find libarth when building (Added to RPATH)
target_link_directories(example PRIVATE ${CMAKE_BINARY_DIR}/libarith)

# Specify where example can find libarth when installed (Added to RPATH)
target_link_directories(example PUBLIC ${CMAKE_INSTALL_PREFIX}/lib)

install(TARGETS example
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

#print_target_properties(example)
#cmake_print_properties(TARGETS example PROPERTIES INCLUDE_DIRECTORIES LINK_LIBRARIES)
