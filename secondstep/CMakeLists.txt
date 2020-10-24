cmake_minimum_required(VERSION 3.13)
project(secondstep VERSION 0.3.0 DESCRIPTION "second step")

include(CMakePrintHelpers)

## Get all properties that cmake supports
execute_process(COMMAND cmake --help-property-list OUTPUT_VARIABLE CMAKE_PROPERTY_LIST)
## Convert command output into a CMake list
STRING(REGEX REPLACE ";" "\\\\;" CMAKE_PROPERTY_LIST "${CMAKE_PROPERTY_LIST}")
STRING(REGEX REPLACE "\n" ";" CMAKE_PROPERTY_LIST "${CMAKE_PROPERTY_LIST}")

list(REMOVE_DUPLICATES CMAKE_PROPERTY_LIST)

## Print a targets properties
function(print_target_properties tgt)
    if(NOT TARGET ${tgt})
      message("There is no target named '${tgt}'")
      return()
    endif()

    foreach (prop ${CMAKE_PROPERTY_LIST})
	#cmake_print_variables(prop)
	#string(REPLACE "<CONFIG>" "${CMAKE_BUILD_TYPE}" prop ${prop})
	#cmake_print_variables(prop)
	if (NOT "${prop}" MATCHES "LOCATION.*")
            get_target_property(propval ${tgt} ${prop})
            if (propval)
                get_target_property(propval ${tgt} ${prop})
                message ("${tgt} ${prop} = ${propval}")
            endif()
	endif()
    endforeach(prop)
endfunction(print_target_properties)

add_subdirectory(libarith)
add_subdirectory(example-cpython-extension)
#add_subdirectory(useexample)
