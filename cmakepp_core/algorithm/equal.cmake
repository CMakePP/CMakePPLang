include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/types/get_type)
include(cmakepp_core/utilities/return)

#[[[ Compares two values for equivalency.
#
# This function can be used to compare any two CMakePP objects for equality. For
# native CMake types, like booleans and integers, equality is defined as being
# the same string. ``cpp_equal`` will also compare objects like CMakePP maps or
# instances of user-defined classes to ensure they have the same state. If two
# objects have different types they are defined to be unequal.
#
# :param _ce_result: The name to use for variable holding the result.
# :type _ce_result: desc
# :param _ce_lhs: One of the two values involved in the comparison.
# :type _ce_lhs: str
# :param _ce_rhs: The other value involved in the comparison
# :type _ce_rhs: str
# :returns: ``_ce_result`` will be set to ``TRUE`` if ``_ce_lhs`` compares equal
#           to ``_ce_rhs`` and ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following code snippet uses ``cpp_equal`` to determine if two integers
# are equal.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/utilities/equal)
#    cpp_equal(result 1 3)
#    message("1 == 3? : ${result}")  # Will print FALSE
#]]
function(cpp_equal _ce_result _ce_lhs _ce_rhs)
    cpp_assert_signature("${ARGV}" desc str str)

    cpp_get_type(_ce_lhs_t "${_ce_lhs}")
    cpp_get_type(_ce_rhs_t "${_ce_rhs}")

    if(NOT "${_ce_lhs_t}" STREQUAL "${_ce_rhs_t}")
        set(${_ce_result} FALSE)
    elseif("${_ce_lhs_t}" STREQUAL "array")
        cpp_array(ARE_EQUAL "${_ce_result}" "${_ce_lhs}" "${_ce_rhs}")
    elseif("${_ce_lhs_t}" STREQUAL "map")
        cpp_map(ARE_EQUAL "${_ce_result}" "${_ce_lhs}" "${_ce_rhs}")
    else() # works for bool, desc, float, int, list, target names, and types
        if("${_ce_lhs}" STREQUAL "${_ce_rhs}")
            set(${_ce_result} TRUE)
        else()
            set(${_ce_result} FALSE)
        endif()
    endif()
    cpp_return("${_ce_result}")
endfunction()
