include_guard()

#[[[ Determines if a string can be lexically cast to a float.
#
# For our purposes a float is any string whose only characters include a decimal
# point, and the numbers 0 through 9. Optionally the float may be prefixed with
# a minus sign.
#
# :param _cif_return: The name to use to store the result.
# :type _cif_return: desc
# :param _cif_str2check: The string we are checking for its floaty-ness
# :type _cif_str2check: str
# :returns: ``_cif_return`` will be set to ``TRUE`` if ``_cif_str2check`` is a
#           float and ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following is an example showcasing how one would check if the identifier
# ``x`` contained a float.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/detail_/float)
#    set(x 3.14)
#    _cpp_is_float(return ${x})
#    message("3.14 is a float: ${return}")  # prints TRUE
#]]
function(_cpp_is_float _cif_return _cif_str2check)
    string(REGEX MATCH "^-?[0-9]+.[0-9]+\$" _cif_match "${_cif_str2check}")
    if("${_cif_match}" STREQUAL "")
        set(${_cif_return} FALSE PARENT_SCOPE)
    else()
        set(${_cif_return} TRUE PARENT_SCOPE)
    endif()
endfunction()
