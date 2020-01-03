include_guard()
include(cmakepp_core/object/object)
include(cmakepp_core/overload/overload)
include(cmakepp_core/utilities/return)
include(cmakepp_core/vtable/vtable)

#[[[ Adds a member function to the current class.
#
# This function encapsulates the process of adding a member function to a class.
# The function is added to the current class overriding any member function with
# the same signature (*i.e.*, all class member functions are virtual).
#
# :param _cam_this: The class instance getting the new member function.
# :type _cam_this: class
# :param _cam_name: The name of the function we are adding to the class.
# :type _cam_name: desc
# :param *args: The types of the positional arguments to the function.
# :returns: ``_cam_name`` will be set to the mangled name to use for defining
#           the overload.
# :rtype: desc
#]]
function(cpp_class_add_member _cam_this _cam_name)
    cpp_object(GET_ATTR "${_cam_this}" _cam_vtable "fxns")
    set(_cam_types ${ARGN})
    string(TOLOWER "${_cam_types}" _cam_types)
    cpp_vtable(ADD_FXN "${_cam_vtable}" "${_cam_name}" _cam_types)
    cpp_vtable(GET_FXN "${_cam_vtable}" _cam_result "${_cam_name}" _cam_types)

    cpp_function_get_overload("${_cam_result}" _cam_result _cam_types)
    cpp_overload(SYMBOL "${_cam_result}" "${_cam_name}")
    cpp_return("${_cam_name}")
endfunction()

#[[[ Wrapper defining the public API for declaring a member function.
#
# Instead of having to declare a function something like
# ``cpp_class_add_member(self, fxn_name, args...)``, this wrapper allows it to
# be declared like ``cpp_add_member(fxn_name, self, args...)``. The second
# syntax is expected to be more natural to the user, as it parallels Python's
# syntax and does not reveal the fact that we are actually calling a member
# function of the Class class. This function also handles the slightly special
# dispatch for declaring a constructor (there's no ``this``/``self`` object as
# input, only output).
#
# :param _m_name: The name of the member function being declared.
# :type _m_name: desc
# :param _m_this: The type getting the member function.
# :type _m_this: class
# :param *args: The types of the positional arguments to the function.
# :returns: ``_m_name`` will be set to the mangled name of the overload which
#           should be implemented.
# :rtype: desc
#
#]]
function(cpp_member _m_name _m_this)
    string(TOLOWER "${_m_name}" _m_lc_name)
    string(TOLOWER "${_m_this}" _m_lc_this)
    set(_m_mn "${_m_lc_name}")
    if("${_m_lc_name}" STREQUAL "ctor")
        cpp_class_add_member(
            "${_cpp_${_m_lc_this}_helper}" "${_m_mn}" desc ${ARGN}
        )
    else()
        cpp_class_add_member(
            "${_cpp_${_m_lc_this}_helper}" "${_m_mn}" "${_m_this}" ${ARGN}
        )
    endif()
    set("${_m_name}" "${${_m_mn}}" PARENT_SCOPE)
endfunction()
