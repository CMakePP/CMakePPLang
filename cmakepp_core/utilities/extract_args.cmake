include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/array/array)
include(cmakepp_core/logic/contains)

#[[[ Code factorization for grabbing part of a line, splitting it into a CMake
#    list, and then appending it onto a CMakePP array.
#
# :param _cear_result: Name to use for the variable to hold the result.
# :type _cear_result: desc
# :param _cear_regex: The regex to match.
# :type _cear_regex: desc
# :param _cear_line: The line we are regex-ing.
# :type _cear_regex: desc
#]]
function(_cpp_extract_args_regex _cear_result _cear_regex _cear_line)
    string(REGEX MATCH ${_cear_regex} _cear_args "${_cear_line}")
    string(REPLACE " " ";" _cear_list "${CMAKE_MATCH_1}")
    cpp_array(APPEND "${_cear_result}" ${_cear_list})
endfunction()

#[[[ Extracts the arguments to a function into a CMakePP Array.
#
# In CMake the arguments to a function always appear between "(" and ")"
# characters. This function will grab the strings (if any) which lie between
# the parentheses. This function takes into account that the arguments may span
# multiple lines, *i.e.*, that "(" and ")" may not be on the same line. At the
# moment, however, it does not support nested "(" and will raise an error if
# one is found (the only valid means of nesting "(" in CMake is for the nested
# ones to be escaped).
#
# :param _cea_result: The name to use for the variable holding the result.
# :type _cea_result: desc
# :param _cea_input: An array with the strings to examine.
# :type _cea_input: array
# :returns: ``_cea_result`` will be set to an array whose elements are the
#           extracted arguments.
# :rtype: array*
#]]
function(cpp_extract_args _cea_result _cea_input)
    cpp_assert_type(desc "${_cea_result}" array "${_cea_input}")
    cpp_array(END _cea_n "${_cea_input}")
    cpp_array(CTOR "${_cea_result}")

    set(_cea_found_lhs FALSE)
    foreach(_cea_i RANGE ${_cea_n})
        cpp_array(GET _cea_line_i "${_cea_input}" ${_cea_i})

        cpp_contains(_cea_found "\\(" "${_cea_line_i}")
        message("${_cea_line_i}")
        if(_cea_found)
            message(
                FATAL_ERROR
                "cpp_extract_args does not support parsing strings with \("
            )
        endif()

        # Part of regex common to all scenarios
        set(_cea_regex [[(.*)]])

        if(NOT "${_cea_found_lhs}")
            cpp_contains(_cea_found_lhs "(" "${_cea_line_i}")
            if(NOT "${_cea_found_lhs}") # Still haven't found "("
                continue()
            endif()
            # For this line we also need to find the "(" character too
            set(_cea_regex "\\(${_cea_regex}")
        endif()

        cpp_contains(_cea_found ")" "${_cea_line_i}")
        if(_cea_found)
            # For this line we also need to find the ")" character
            set(_cea_regex "${_cea_regex}\\)")
            _cpp_extract_args_regex(
                "${${_cea_result}}" "${_cea_regex}" "${_cea_line_i}"
            )
            # and we're done
            cpp_return("${_cea_result}")
        else()
            _cpp_extract_args_regex(
                "${${_cea_result}}" "${_cea_regex}" "${_cea_line_i}"
            )
        endif()
    endforeach()

    if(${_cea_found_lhs})
        message(FATAL_ERROR "Never found the matching ')'")
    else()
        message(FATAL_ERROR "Did not find anything of the form (...)")
    endif()
endfunction()
