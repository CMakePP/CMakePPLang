include_guard()
include(cmakepp_core/array/detail_/ctor)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Creates a new CMakePP array which is a deep copy of an existing array.
#
# This function will make a deep copy of an already existing array and the
# elements in that array.
#
# :param _cac_result: The name to use for the variable holding the result
# :type _cac_result: desc
# :param _cac_array2copy: The array instance we are copying.
# :type _cac_array2copy: array
# :returns: ``_cac_result`` will be set to the newly created deep copy.
# :rtype: array*
#]]
function(_cpp_array_copy _cac_result _cac_array2copy)
    cpp_assert_signature("${ARGV}" desc array)

    _cpp_array_ctor("${_cac_result}")
    get_property(_cac_map GLOBAL PROPERTY "${_cac_array2copy}")
    cpp_map(COPY _cac_copy "${_cac_map}")
    set_property(GLOBAL PROPERTY "${${_cac_result}}" "${_cac_copy}")
    cpp_return("${_cac_result}")
endfunction()
