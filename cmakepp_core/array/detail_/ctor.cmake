include_guard()
include(cmakepp_core/array/detail_/append)
include(cmakepp_core/map/map)

#[[[ Creates a new array instance.
#
# This constructor will create a new array instance. If no arguments aside from
# the name of the return, are provided, then this ctor will create an empty
# array. Optionally, users may provide the initial elements of the array as
# variadic arguments.
#
# :param _cac_name: The name to use for the resulting variable.
# :type _cac_name: desc
# :param *args: The initial elements of the array
# :type *args: str
# :returns: ``_cac_name`` will be set to the newly created array instance.
# :rtype: array*
#]]
function(_cpp_array_ctor _cac_name)
    cpp_unique_id("${_cac_name}")
    cpp_map(CTOR _cac_state)
    set_property(GLOBAL PROPERTY "${${_cac_name}}" "${_cac_state}")
    set_property(GLOBAL PROPERTY "${${_cac_name}}_type" "array")
    _cpp_array_append("${${_cac_name}}" ${ARGN})
    cpp_return("${_cac_name}")
endfunction()
