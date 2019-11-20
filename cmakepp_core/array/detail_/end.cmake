include_guard()
include(cmakepp_core/array/detail_/length)
include(cmakepp_core/asserts/type)
include(cmakepp_core/utilities/return)

#[[ Returns the ending index assuming an inclusive iteration range.
#
# Iteration over a CMakePP array is most naturally done with CMake's ``foreach``
# directive; however, ``foreach(y RANGE x)`` command iterates over all integers
# from 0 to ``x`` inclusively. This means that ``x`` needs to be the length of
# our array minus 1. This function computes the length of the array and
# subtracts 1 from it, thus providing an input suitable for CMake's ``foreach``
# command.
#
# :param _cae_result: The name for the variable to hold the result.
# :type _cae_result: desc
# :param _cae_array: The array we want the last index of.
# :type _cae_array: array
# :returns: ``_cae_result`` will be set to the length of ``_cae_array`` minus
#           one.
# :rtype: int*
#]]
function(_cpp_array_end _cae_result _cae_array)
    cpp_assert_type(desc "${_cae_result}" array "${_cae_array}")
    _cpp_array_length("${_cae_result}" "${_cae_array}")
    math(EXPR "${_cae_result}" "${${_cae_result}} - 1")
    cpp_return("${_cae_result}")
endfunction()
