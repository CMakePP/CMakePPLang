include_guard()
include(cmakepp_core/object/object)

function(cpp_overload_ctor _oc_this _oc_fxn)

    cpp_object(CTOR "${_oc_this}")
    cpp_object(_SET_TYPE "${${_oc_this}}" overload)

    # Record the function's human-readable name
    string(TOLOWER "${_oc_fxn}" _oc_fxn)
    cpp_object(SET_ATTR "${${_oc_this}}" name "${_oc_fxn}")

    # Record the types to the function
    set(_oc_args ${ARGN})
    string(TOLOWER "${_oc_args}" _oc_args)
    cpp_object(SET_ATTR "${${_oc_this}}" args "${_oc_args}")

    # Record the mangled name of the function
    set(_oc_mangled_name "_cpp_${_oc_fxn}_")
    foreach(_oc_arg_i ${_oc_args})
        string(APPEND _oc_mangled_name "${_oc_arg_i}_")
    endforeach()
    cpp_object(SET_ATTR "${${_oc_this}}" symbol "${_oc_mangled_name}")

    cpp_return("${_oc_this}")
endfunction()
