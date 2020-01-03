include_guard()
include(cmakepp_core/object/object)
include(cmakepp_core/utilities/return)

macro(_cpp_object_singleton _os_this)
    _cpp_object_ctor("${_os_this}" "obj")

    _cpp_object_add_fxn("${${_os_this}}" equal obj desc obj)
    function("${equal}" __oe_this __oe_result __oe_other)
        _cpp_object_equal("${__oe_this}" "${__oe_result}" "${__oe_other}")
        cpp_return("${__oe_result}")
    endfunction()

    _cpp_object_add_fxn("${${_os_this}}" serialize obj desc)
    function("${serialize}" __os_this __os_result)
        _cpp_object_serialize("${__os_this}" "${__os_result}")
        cpp_return("${__os_result}")
    endfunction()
endmacro()
