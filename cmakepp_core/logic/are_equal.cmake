include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/types/get_type)
include(cmakepp_core/utilities/return)

#[[[ Compares two values for equivalency.
#
# We need to compare values a lot. For native CMake types this usually amounts
# to boilerplate code like:
#
# .. code-block:: cmake
#
#    if("${value1}" STREQUAL "${vALUE2}")
#        set(are_equal TRUE)
#    else()
#        set(are_equal FALSE)
#    endif()
#
# This is somewhat unsightly, furthermore it obscures what we are trying to do.
# The ``cpp_are_equal`` function wraps this boilerplate making it easier to
# compare two values. As an added bonus, this function also works properly with
# native CMakePP types like maps.
#
# :param _cae_result: The name to use for variable holding the result.
# :type _cae_result: desc
# :param _cae_lhs: One of the two values involved in the comparison.
# :type _cae_lhs: str
# :param _cae_rhs: The other value involved in the comparison
# :type _cae_rhs: str
# :returns: ``_cae_result`` will be set to ``TRUE`` if ``_cae_lhs`` compares
#           equal to ``_cae_rhs`` and ``FALSE`` otherwise.
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
    cpp_assert_signature("${ARGV}" desc str str)

    cpp_get_type(_cae_lhs_t "${_cae_lhs}")
    cpp_get_type(_cae_rhs_t "${_cae_rhs}")

    if(NOT "${_cae_lhs_t}" STREQUAL "${_cae_rhs_t}")
        set(${_cae_result} FALSE)
    elseif("${_cae_lhs_t}" STREQUAL "array")
        cpp_array(ARE_EQUAL "${_cae_result}" "${_cae_lhs}" "${_cae_rhs}")
    elseif("${_cae_lhs_t}" STREQUAL "map")
        cpp_map(ARE_EQUAL "${_cae_result}" "${_cae_lhs}" "${_cae_rhs}")
    else() # works for bool, desc, float, int, list, target names, and types
        if("${_cae_lhs}" STREQUAL "${_cae_rhs}")
            set(${_cae_result} TRUE)
        else()
            set(${_cae_result} FALSE)
        endif()
    endif()
    cpp_return("${_cae_result}")
endfunction()
