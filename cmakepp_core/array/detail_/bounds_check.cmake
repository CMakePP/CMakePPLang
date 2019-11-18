include_guard()
include(cmakepp_core/array/detail_/length)
include(cmakepp_core/asserts/less)

#[[[ Code factorization for ensuring that an index is valid for a given array.
#
# This function will ensure that the provided index is in the range
# :math:`[0,n)`, where :math:`n` is the number of elements in the array. This
# check is only performed if CMakePP is running in debug mode.
#
# :param _cabc_array: The array for which we want to know if the index is in
#                     bounds.
# :type _cabc_array: array
# :param _cabc_index: The index whose in-bounds-ness is in question.
# :type _cabc_index: int
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is running in debug
#                               mode.
#]]
function(_cpp_array_bounds_check _cabc_array _cabc_index)
    _cpp_array_length(_cabc_n "${_cabc_array}")
    cpp_assert_less("${_cabc_index}" "${_cabc_n}")
endfunction()
