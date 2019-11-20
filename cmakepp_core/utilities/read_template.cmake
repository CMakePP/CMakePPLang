include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/type)

#[[[ Reads the contents of a file into a CMakePP array.
#
# This function encapsulates the logic required to read a file, more-or-less,
# verbatim into a CMakePP array so that each line of the file is an element in
# the array. In particular, such an endeavor requires careful escaping of
# special characters, the logic for which is encapsulated in this function.
#
# :param _crt_result: The name to use for the variable holding the result.
# :type _crt_result: desc
# :param _crt_file: The file to read in and split into lines.
# :type _crt_file: path
# :returns: ``_crt_result`` will be set to an array containing the lines in the
#           file.
# :rtype: array*
#]]
function(cpp_read_template _crt_result _crt_file)
    cpp_assert_type(desc "${_crt_result}" path "${_crt_file}")
    file(READ "${_crt_file}" _crt_contents)

    # Protect semicolons
    string(REGEX REPLACE ";" "\\\\;" _crt_contents "${_crt_contents}")

    # Do not expand variables
    string(REGEX REPLACE "\\$" "\\\\$" _crt_contents "${_crt_contents}")

    # We need to protect escaped endline characters so that they don't become ;
    set(_crt_n "_crt_end_line_char_crt_")
    string(REGEX REPLACE "\\\\n" "${_crt_n}" _crt_contents "${_crt_contents}")

    # Now we can change endlines to list separators safely
    string(REGEX REPLACE "\n" ";" _crt_contents "${_crt_contents}")

    # Need to restore the escaped newlines
    string(REGEX REPLACE "${_crt_n}" "\\\\n" _crt_contents "${_crt_contents}")

    cpp_array(CTOR "${_crt_result}")
    foreach(_crt_line_i IN LISTS _crt_contents)
        string(REGEX REPLACE ";" "\\\\\\\;" _crt_line_i "${_crt_line_i}")
        string(REGEX REPLACE "\\$" "\\\\$" _crt_line_i "${_crt_line_i}")
        string(REGEX REPLACE "\\\\n" "\\\\\\\\n" _crt_line_i "${_crt_line_i}")
        _cpp_array_append("${${_crt_result}}" "${_crt_line_i}")
    endforeach()

    cpp_return("${_crt_result}")
endfunction()
