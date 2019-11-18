include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Computes the length of an array.
#
# This function will determine how many elements are in the provided array.
#
# :param _cal_n: The name for the variable which will hold the result.
# :type _cal_n: desc
# :param _cal_array: The array we want the length of.
# :type _cal_array: array
# :returns: ``_cal_n`` will be set to the length of the array.
# :rtype: int*
#]]
function(_cpp_array_length _cal_n _cal_array)
    cpp_assert_type(desc "${_cal_n}" array "${_cal_array}")
    get_property(_cal_state GLOBAL PROPERTY "${_cal_array}")
    cpp_map(KEYS _cal_keys "${_cal_state}")
    list(LENGTH _cal_keys "${_cal_n}")
    cpp_return("${_cal_n}")
endfunction()
