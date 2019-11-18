include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Asserts that the first value is less than the second value.
#
# Compares two values and asserts that the first value is less than to the
# second argument. If the this is not the case an error is raised. Errors
# are only raised if CMakePP is in debug mode.
#
# :param _cal_n: The number that must be smaller than the other number.
# :type _cal_n: int
# :param _cal_m: The number that must be larger than the other number.
# :type _cal_m: int
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# Example Usage:
# ==============
#
# The following code snippet shows how to raise an error if 3 is not less than 3
#
# .. code-block:: cmake
#
#    include(cmakepp_core/asserts/less)
#    cpp_assert_less(3 4)
#]]
function(cpp_assert_less _cal_n _cal_m)
    cpp_enable_if_debug()
    cpp_assert_type(int "${_cal_n}" int "${_cal_m}")
    cpp_assert("${_cal_n};LESS;${_cal_m}" "${_cal_n} < ${_cal_m}.")
endfunction()
