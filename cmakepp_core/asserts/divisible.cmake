include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Asserts that the first argument is evenly divisible by the second.
#
# This function is used to assert that the first positional argument is evenly
# divisible by the second argument. The assertion is only performed if CMakePP
# is run in debug mode.
#
# :param _cad_n: The dividend (*i.e.*, the numerator of the fraction)
# :type _cad_n: int
# :param _cad_m: The divisor (*i.e.*, the denomenator of the fraction)
# :type _cad_m: int
# :var CMAKEPP_CORE_DEBUG_MODE: used to determine if CMakePP is in debug mode.
#
# Example Usage:
# ==============
#
# The following snippet shows how to determine if 4 is evenly divisible by 2:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/asserts/divisible)
#    cpp_assert_divisible(4 2)
#
#]]
function(cpp_assert_divisible _cad_n _cad_m)
    cpp_enable_if_debug()
    cpp_assert_type(int "${_cad_n}" int "${_cad_m}")

    math(EXPR _cad_not_divisible "${_cad_n} % ${_cad_m}")
    if(_cad_not_divisible)
       cpp_assert(FALSE "${_cad_n} % ${_cad_m} == 0")
    endif()
endfunction()
