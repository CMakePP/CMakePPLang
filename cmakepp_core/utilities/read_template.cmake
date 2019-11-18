include_guard()

function(cpp_read_template _crt_result _crt_file)
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

    set("${_crt_result}" "${_crt_contents}" PARENT_SCOPE)
endfunction()
