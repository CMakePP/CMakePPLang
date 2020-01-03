include_guard()
include(cmakepp_core/object/object)
include(cmakepp_core/vtable/vtable)

#[[[ Constructs a new Class instance.
#
# Objects of Class type describe user-defined types. This function creates a new
# class instance which describes the user-defined type ``_cc_this``. The class
# will directly inherit from the list of provided base classes.
#
# :param _cc_this: Name of the user-defined type being created.
# :type _cc_this: desc
# :param *args: Base classes the user-defined type inherits from.
# :returns: ``_cc_this`` will be set to the newly created Class instance
# :rtype: class
#]]
function(cpp_class_ctor _cc_this)

    # Make the base object which will store the state
    cpp_object(CTOR "${_cc_this}")

    # Set the type of the Class instance
    cpp_object(SET_ATTR "${${_cc_this}}" _cpp_type class)

    # Record the type of the class described by this Class instance
    string(TOLOWER "${_cc_this}" _cc_lc_this)
    cpp_object(SET_ATTR "${${_cc_this}}" type "${_cc_this}")

    # Initialize the remaining state of this instance
    set(_cc_bases "obj")
    set(_cc_direct_bases)
    cpp_vtable(CTOR _cc_vtable)

    # Update bases and vtables from the base classes
    foreach(_cc_base_i ${ARGN})
        string(TOLOWER "${_cc_base_i}" _cc_base_lc_i)

        # Get the base classes of base class i
        cpp_object(GET_ATTR "${${_cc_base_i}}" _cc_base_i_bases "bases")

        # Add them to the list of all base classes
        list(APPEND _cc_bases ${_cc_base_i_bases} "${_cc_base_lc_i}")

        # Add base class i to the list of direct bases
        list(APPEND _cc_direct_bases "${_cc_base_lc_i}")

        # Get base class i's vtable and add it to this class's vtable
        cpp_object(GET_ATTR "${${_cc_base_i}}" _cc_base_i_vtable "fxns")
        cpp_vtable(ADD_SUBVTABLE "${_cc_vtable}" "${_cc_base_i_vtable}")
    endforeach()

    # Generally speaking above results in duplicates in our list of all bases
    list(REMOVE_DUPLICATES _cc_bases)

    # Set the attributes
    cpp_object(SET_ATTR "${${_cc_this}}" bases "${_cc_bases}")
    cpp_object(SET_ATTR "${${_cc_this}}" fxns "${_cc_vtable}")

    if(${ARGC} EQUAL 1)
        set(_cc_direct_bases obj)
    endif()
    cpp_object(SET_ATTR "${${_cc_this}}" direct_bases "${_cc_direct_bases}")


    set("${_cc_this}" "${${_cc_this}}" PARENT_SCOPE)
endfunction()
