include_guard()
include(cmakepp_core/array/array)

#[[[ Code factorization for grabbing part of a line, splitting it into a CMake
#    list, and then appending it onto a CMakePP array.
#]]
function(_cpp_extract_args_regex _cear_result _cear_regex _cear_line)
    string(REGEX MATCH ${_cear_regex} _cear_args "${_cear_line}")
    string(REPLACE " " ";" _cear_list "${CMAKE_MATCH_1}")
    cpp_array(APPEND "${_cear_result}" ${_cear_list})
endfunction()

function(cpp_extract_args _cea_result _cea_input)
    cpp_array(LENGTH _cea_n "${_cea_input}")
    math(EXPR _cea_n "${_cea_n} - 1")
    cpp_array(CTOR "${_cea_result}")

    set(_cea_found_lhs FALSE)
    foreach(_cea_i RANGE ${_cea_n})
        cpp_array(GET _cea_line_i "${_cea_input}" ${_cea_i})
        if(NOT "${_cea_found_lhs}")
            string(FIND "${_cea_line_i}" "(" _cea_found)
            if(NOT "${_cea_found}" STREQUAL -1)
                set(_cea_found_lhs TRUE)
            else()
                continue()
            endif()

            string(FIND "${_cea_line_i}" ")" _cea_found)

            if(NOT "${_cea_found}" STREQUAL -1)
                _cpp_extract_args_regex(
                    "${${_cea_result}}" [[\((.*)\)]] "${_cea_line_i}"
                )
                cpp_return("${_cea_result}")
            else()
                _cpp_extract_args_regex(
                    "${${_cea_result}}" [[\((.*)]] "${_cea_line_i}"
                )
            endif()
        else()
            string(FIND "${_cea_line_i}" ")" _cea_found)
            if(NOT "${_cea_found}" STREQUAL -1)
                _cpp_extract_args_regex(
                    "${${_cea_result}}" [[(.*)\)]] "${_cea_line_i}"
                )
                cpp_return("${_cea_result}")
            else()
                _cpp_extract_args_regex(
                    "${${_cea_result}}" [[(.*)]] "${_cea_line_i}"
                )
            endif()
        endif()
    endforeach()

    if(${_cea_found_lhs})
        message(FATAL_ERROR "Never found the matching ')'")
    else()
        message(FATAL_ERROR "Did not find anything of the form (...)")
    endif()
endfunction()
