include_guard()
include(cmakepp_core/types/literals)

#[[[ Determines if a string is one of CMakePP's literal type names.
#
# This function will analyze the provided string and compare it against a list
# of known literal constants representing fundamental CMakePP types. If the
# provided string case-insensitively matches any of the known types then the
# string is a type.
#
# :param _cit_result: The name to use for the result.
# :type _cit_result: desc
# :param _cit_str2check: The string to analyze for its typey-ness.
# :type _cit_str2check: str
# :returns: ``_cit_result`` will be set to ``TRUE`` if ``_cit_str2check`` is a
#           known type and ``FALSE`` otherwise.
# :rtype: bool*
#]]
function(_cpp_is_type _cit_result _cit_str2check)
    string(TOLOWER "${_cit_str2check}" _cit_str2check)
    list(FIND CMAKEPP_TYPE_LITERALS "${_cit_str2check}" "${_cit_result}")
    if("${${_cit_result}}" EQUAL "-1")
        set(${_cit_result} FALSE PARENT_SCOPE)
    else()
        set(${_cit_result} TRUE PARENT_SCOPE)
    endif()
endfunction()
