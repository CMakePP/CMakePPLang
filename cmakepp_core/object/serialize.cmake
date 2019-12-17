include_guard()
include(cmakepp_core/serialization/serialization)

function(cpp_object_serialize _os_this _os_result)

    cpp_get_global(_os_type "${_os_this}__cpp_type")
    set(_os_buffer "{ \"this\" : \"${_os_this}\", ")
    string(APPEND _os_buffer "\"attrs\" : { ")

    cpp_object_get_attrs("${_os_this}" _os_attrs)
    foreach(_os_attr_i ${_os_attrs})
        cpp_object_get_attr("${_os_this}" _os_value "${_os_attr_i}")
        cpp_type_of(_os_type "${_os_value}")
        cpp_serialize(_os_serial_value "${_os_value}")
        string(APPEND _os_buffer "\"${_os_attr_i}\" : ${_os_serial_value}, ")
    endforeach()

    set("${_os_result}" "${_os_buffer}} }" PARENT_SCOPE)
endfunction()
