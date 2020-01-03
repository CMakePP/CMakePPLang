include_guard()
include(cmakepp_core/serialization/serialization)

function(_cpp_object_serialize _os_this _os_result)

    cpp_get_global(_os_state "${_os_this}__state")
    set(_os_temp "{ \"${_os_this}\" :")
    _cpp_serialize_map(_os_buffer "${_os_state}")
    string(APPEND _os_temp " ${_os_buffer} }")
    set("${_os_result}" "${_os_temp}" PARENT_SCOPE)
endfunction()

function(_cpp_object_print _op_this)
    _cpp_object_serialize("${_op_this}" _op_result)
    message("${_op_result}")
endfunction()
