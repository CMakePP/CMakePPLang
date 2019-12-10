include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/array/detail_/end)
include(cmakepp_core/array/detail_/get)
include(cmakepp_core/utilities/return)

#[[[ Returns the last element in the array.
#
# This a convenience function for retrieving the last element in an array. The
# array must have at least one element in it or else this function will raise an
# error.
#
# :param _cab_result: Name for variable which will hold the result.
# :type _cab_result: desc
# :param _cab_array: The array we are getting the last element of.
# :type _cab_array: array
# :returns: ``_cab_result`` will be set to the last element in the array.
# :rtype: str*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# This function always ensures that the array is non-empty. Additionally, if
# CMakePP is in debug mode this function will ensure that the arguments to the
# function are correct and that no additional arguments are performed. Error
# checks for the signature are only performed in debug mode.
#]]
function(_cpp_array_back _cab_result _cab_array)
    cpp_assert_signature("${ARGV}" desc array)

    # Get the index of the last element of the array, ensuring it's >= 0
    _cpp_array_end(_cab_end "${_cab_array}")
    if("${_cab_end}" STREQUAL "-1")
        cpp_assert(FALSE "Array is non-empty")
    endif()

    # Use the index of the last element to actually get the value
    _cpp_array_get("${_cab_result}" "${_cab_array}" "${_cab_end}")
    cpp_return("${_cab_result}")
endfunction()
