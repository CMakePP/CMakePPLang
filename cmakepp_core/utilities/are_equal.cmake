include_guard()

#[[[ Compares two values for equivalency.
#
# We need to compare values a lot. Without this function that requires us to
# write an if/else block each time. This function is code-factorization for that
# if/else block.
#
# :param _cae_result: The name to use for the resulting variable.
# :type _cae_result: desc
# :param _cae_lhs: One of the two values involved in the comparison.
# :type _cae_lhs: str
# :param _cae_rhs: The other value involved in the comparison
# :type _cae_rhs: str
# :returns: ``_cae_result`` will be set to ``TRUE`` if ``_cae_lhs`` compares
#           equal to ``_cae_rhs`` using CMake's ``STREQUAL`` operation and
#           ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following code snippet uses ``cpp_are_equal`` to determine if two integers
# are equal.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/utilities/are_equal)
#    cpp_are_equal(result 1 3)
#    message("1 == 3? : ${result}")  # Will print FALSE
#]]
function(cpp_are_equal _cae_result _cae_lhs _cae_rhs)
    if("${_cae_lhs}" STREQUAL "${_cae_rhs}")
        set(${_cae_result} TRUE PARENT_SCOPE)
    else()
        set(${_cae_result} FALSE PARENT_SCOPE)
    endif()
endfunction()
