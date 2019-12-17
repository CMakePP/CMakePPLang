include_guard()
include(cmakepp_core/object/object)

function(cpp_class_ctor _cc_this)

    # Make the base object which will store the state
    cpp_object(CTOR "${_cc_this}")

    # Avoid calling _cpp_object_set_type because "class" is not of type "class"
    # until we have set the type.
    cpp_object(SET_ATTR "${${_cc_this}}" _cpp_type class)

    # Add the base classes to the object
    set(_cc_bases "obj")
    foreach(_cc_base_i ${ARGN})
        cpp_object(GET_ATTR "${${_cc_base_i}}" _cc_base_i_bases "bases")
        string(TOLOWER "${_cc_base_i}" _cc_base_i)
        list(APPEND _cc_bases ${_cc_base_i_bases} "${_cc_base_i}")
    endforeach()
    list(REMOVE_DUPLICATES _cc_bases)
    cpp_object(SET_ATTR "${${_cc_this}}" bases "${_cc_bases}")

    set("${_cc_this}" "${${_cc_this}}" PARENT_SCOPE)
endfunction()
