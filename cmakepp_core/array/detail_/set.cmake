include_guard()
include(cmakepp_core/array/detail_/bounds_check)

#[[[ Allows changing the value of an element in the array.
#
# This function can be used to change the value of the element at the specified
# position. This function will ensure that the index is in bounds if CMakePP is
# run in debug mode.
#
# :param _cas_array: The array in which we are changing the value.
# :type _cas_array: array
# :param _cas_index: The offset of the index we want to change the value of.
# :type _cas_index: int
# :param _cas_value: The new value for the element.
# :type _cas_value: str
#]]
function(_cpp_array_set _cas_array _cas_index _cas_value)
    cpp_assert_type(array "${_cas_array}" int "${_cas_index}")
    _cpp_array_bounds_check("${_cas_array}" "${_cas_index}")
    get_property(_cas_state GLOBAL PROPERTY "${_cas_array}")
    cpp_map(SET "${_cas_state}" "elem_${_cas_index}" "${_cas_value}")
endfunction()
