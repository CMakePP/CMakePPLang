include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Asserts that the first value is greater than or equal to the second value.
#
# Compares two values and asserts that the first value is less than or equal to
# the second argument. If the this is not the case an error is raised. Errors
# are only raised if CMakePP is in debug mode.
#
# :param _cagte_n: The number that must be larger or equal to the other number.
# :type _cagte_n: int
# :param _cagte_m: The number that must be smaller than or equal to the other
#                  number.
# :type _cagte_m: int
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# Example Usage:
# ==============
#
# The following code snippet shows how to raise an error if 4 is not greater
# than or equal to 3.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/asserts/greater_than_equal)
#    cpp_assert_greater_than_equal(4 3
#]]
function(cpp_assert_greater_than_equal _cagte_n _cagte_m)
    cpp_enable_if_debug()
    cpp_assert_type(int "${_cagte_n}" int "${_cagte_m}")
    cpp_assert(
        "${_cagte_n};GREATER_EQUAL;${_cagte_m}" "${_cagte_n} >= ${_cagte_m}."
    )
endfunction()
