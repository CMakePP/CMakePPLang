include_guard()
include(cmakepp_core/array/detail_/bounds_check)
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Retrieves the value of the array's element with the specified index.
#
# :param _cag_result: The name to use for the variable holding the result.
# :type _cag_result: desc
# :param _cag_array: The array we are getting the variable from.
# :type _cag_array: array
# :param _cag_index: The offset of the element we want the value of.
# :type _cag_index: int
# :returns: ``_cag_result`` will be set to the value of the requested element.
# :rtype: str*
#]]
function(_cpp_array_get _cag_result _cag_array _cag_index)
    cpp_assert_type(
        desc "${_cag_result}" array "${_cag_array}" int "${_cag_index}"
    )
    get_property(_cag_state GLOBAL PROPERTY "${_cag_array}")
    _cpp_array_bounds_check("${_cag_array}" "${_cag_index}")
    cpp_map(GET "${_cag_result}" "${_cag_state}" "${_cag_index}")
    cpp_return("${_cag_result}")
endfunction()
