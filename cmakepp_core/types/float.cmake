include_guard()
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/return)
include(cmakepp_core/types/string)

#[[[ Determines if a string can be leixically cast to a float.
#
# For our purposes a float is any string whose only characters include a
# (single) decimal point, ".", the numbers 0 through 9, and optionally is
# prefixed with a ``-`` sign. In particular, this means that strings like
# ``" 0.2"`` are not recognized as floats by this function.
#
# :param _cif_return: An identifier to store the result.
# :type _cif_return: identifier
# :param _cif_str2check: The string we are checking for its floaty-ness
# :type _cif_str2check: str
# :returns: ``TRUE`` if ``_cif_str2check`` is a float and ``FALSE`` otherwise.
#           The result is returned via ``_cif_return``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following is an example showcasing how one would check if the identifier
# ``x`` contained a float.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/float)
#    set(x 3.14)
#    cpp_is_float(return ${x})
#    message("3.14 is a float: ${return}")  # prints TRUE
#]]
function(cpp_is_float _cif_return _cif_str2check)
    string(REGEX MATCH "^-?[0-9]+.[0-9]+\$" _cif_match "${_cif_str2check}")
    cpp_is_not_empty(${_cif_return} "${_cif_match}")
    cpp_return(${_cif_return})
endfunction()

#[[[ Determines if a string can not be leixically cast to a float.
#
# For our purposes a float is any string whose only characters include a
# (single) decimal point, ".", the numbers 0 through 9, and optionally is
# prefixed with a ``-`` sign. In particular, this means that strings like
# ``" 0.2"`` are not recognized as floats by this function.
#
# :param _cinf_return: An identifier to store the result.
# :type _cinf_return: identifier
# :param _cinf_str2check: The string we are checking for its floaty-ness
# :type _cinf_str2check: str
# :returns: ``FALSE`` if ``_cinf_str2check`` is a float and ``TRUE`` otherwise.
#           The result is returned via ``_cinf_return``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following is an example showcasing how one would check if the identifier
# ``x`` did not contain a float.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/float)
#    set(x 3.14)
#    cpp_is_not_float(return ${x})
#    message("3.14 is a float: ${return}")  # prints FALSE
#]]
function(cpp_is_not_float _cinf_return _cinf_str2check)
    cpp_is_float(${_cinf_return} "${_cinf_str2check}")
    cpp_negate(${_cinf_return} "${${_cinf_return}}")
    cpp_return(${_cinf_return})
endfunction()

#[[[ Asserts that the provided argument is a float.
#
# This function is meant to be used for type-checking when CMakePP is run in
# debug mode. If CMakePP is in debug mode and the argument provided to this
# function is not a float, this function will raise an error.
#
# :param _caf_val2check: String to lexically cast to a float
# :type _caf_val2check: str
#
# Example Usage:
# ==============
#
# This example shows how to assert that the contents of a variable is a float.
# This is typically done as a means of error-checking inside a function where
# the value of the variable is not so clear.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/float)
#    set(a_float 3.14)
#    cpp_assert_float(${a_float})
#]]
function(cpp_assert_float _caf_val2check)
    cpp_enable_if_debug()
    cpp_is_float(_caf_return "${_caf_val2check}")
    cpp_assert("${_caf_return}" "'${_caf_val2check}' is a float")
endfunction()
