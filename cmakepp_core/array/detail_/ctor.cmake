include_guard()
include(cmakepp_core/array/detail_/append)
include(cmakepp_core/map/map)

#[[[ Encapsulates the logic name mangling for array identifiers.
#
# This function will take a seed string and mangle it into an identifier that
# is unique to this particular array instance.
#
# :param _cam_this_ptr: The value to use as a seed for the identifier.
# :type _cam_this_ptr: desc
# :returns: ``_cam_this_ptr``'s value will be overridden with the properly
#           mangled type.
# :rtype: array*
#]]
function(_cpp_array_mangle _cam_this_ptr)
    set(${_cam_this_ptr} "__cpp_array_${${_cam_this_ptr}}" PARENT_SCOPE)
endfunction()

#[[[ Creates a new array instance.
#
# This constructor will create a new array instance. The resulting instance will
# have no elements in it.
#
# :param _cac_name: The name to use for the resulting variable.
# :type _cac_name: desc
# :returns: ``_cac_name`` will be set to the newly created array instance.
# :rtype: array*
#]]
function(_cpp_array_ctor _cac_name)
    string(RANDOM ${_cac_name})
    _cpp_array_mangle(${_cac_name})
    cpp_map(CTOR _cac_state)
    set_property(GLOBAL PROPERTY "${${_cac_name}}" "${_cac_state}")
    _cpp_array_append("${${_cac_name}}" ${ARGN})
    cpp_return("${_cac_name}")
endfunction()
