include_guard()
include(cmakepp_core/array/detail_/length)
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/map)

#[[[ Adds one or more values onto the end of the array.
#
# This function allows you to add additional values onto an already existing
# array.
#
# :param _caa_array: The array we are adding values to.
# :type _caa_array: array
# :param *args: A variadic list of values to append onto the array.
#
#]]
function(_cpp_array_append _caa_array)
    cpp_assert_type(array "${_caa_array}")
    _cpp_array_length(_caa_n "${_caa_array}")
    get_property(_caa_state GLOBAL PROPERTY "${_caa_array}")
    foreach(_caa_elem_i ${ARGN})
        cpp_map(SET "${_caa_state}" "elem_${_caa_n}" "${_caa_elem_i}")
        math(EXPR _caa_n "${_caa_n} + 1")
    endforeach()
endfunction()
