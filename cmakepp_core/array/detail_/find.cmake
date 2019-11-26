include_guard()
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Determines if a value occurrs in an array.
#
# This function can be used to determine if a given value is an element in the
# array. If the value does appear the first index at which it appears is
# returned. If the value does not appear, then ``NOTFOUND`` is returned.
#
# :param _caf_result: A name for the variable which will hold the result.
# :type _caf_result: desc
# :param _caf_array: The array we are searching for the value in.
# :type _caf_array: array
# :param _caf_value: The value we are looking for.
# :type _caf_value: str
# :returns: ``_caf_result`` will be set to the first index at which
#           ``_caf_value`` appears (if ``_caf_value`` is in ``_caf_array``).
#           Otherwise, ``_caf_result`` will be set to ``NOTFOUND``.
# :rtype: bool* or int*
#]]
function(_cpp_array_find _caf_result _caf_array _caf_value)
    cpp_assert_signature("${ARGV}" desc array str)
    get_property(_caf_state GLOBAL PROPERTY "${_caf_array}")
    cpp_map(KEYS _caf_keys "${_caf_state}")
    foreach(_caf_key_i ${_caf_keys})
        cpp_map(GET _caf_value_i "${_caf_state}" "${_caf_key_i}")
        cpp_equal(_caf_is_value "${_caf_value_i}" "${_caf_value}")
        if(_caf_is_value)
            set("${_caf_result}" "${_caf_key_i}" PARENT_SCOPE)
            return()
        endif()
    endforeach()
    set("${_caf_result}" NOTFOUND PARENT_SCOPE)
endfunction()

