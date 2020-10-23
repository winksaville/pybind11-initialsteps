cmake_minimum_required(VERSION 3.13)
project(arith VERSION 0.2.0 DESCRIPTION "second step")

if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX
	"~/opt/arith" CACHE PATH "~/opt/arith install prefix" FORCE)
endif (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

add_library(arith SHARED src/add.cxx)

set_target_properties(arith PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    PUBLIC_HEADER inc/libarith.hxx)

target_include_directories(arith PRIVATE inc)

install(TARGETS arith
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

