include_guard()

#[[[ Converts the input string into a uniform, filesystem-safe string.
#
# Strings in CMake are case-sensitive in some contexts and case-insensitive in
# others. This function encapsulates the logic for converting a string to a
# common case (currently lower case because most CMake conventions favor it) and
# also replacing potentially troublesome characters in the string. The resulting
# "sanitized" string is suitable for use as a key in a map, part of a variable's
# name, or a C/C++ function name.
#
# :param _ss_result: Name for variable which will hold the result.
# :type _ss_result: desc
# :param _ss_input: The string we are sanitizing.
# :type _ss_input: str
# :returns: ``_ss_result`` will be set to the sanitized string.
# :rtype: str
#]]
function(cpp_sanitize_string _ss_result _ss_input)
    string(MAKE_C_IDENTIFIER "${_ss_input}" "${_ss_result}")
    string(TOLOWER "${${_ss_result}}" "${_ss_result}")
    set("${_ss_result}" "${${_ss_result}}" PARENT_SCOPE)
endfunction()
