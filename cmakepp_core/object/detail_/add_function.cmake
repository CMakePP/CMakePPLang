include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/detail_/get_state)

#[[[ Adds a member function to the class.
#
# :param _coaf_class: The class we are adding a member function to.
# :type _coaf_class: obj
# :param _coaf_fxn: The name of the member function we are adding.
# :type _coaf_fxn: desc
# :param _coaf_base: The name of the class which first implemented this member
#                    function.
# :type _coaf_base: desc
#
#]]
function(_cpp_object_add_function _coaf_class _coaf_fxn _coaf_base)
    cpp_assert_signature("${ARGV}" obj desc desc)

    # Get vtable and determine if the class has an overload for member yet
    _cpp_object_get_vtable("${_coaf_class}" _coaf_vtable)
    cpp_map(HAS_KEY _coaf_exists "${_coaf_vtable}" "${_coaf_fxn}")
    if("${_coaf_exists}")
        return()
    endif()

    cpp_map(SET "${_coaf_vtable}" "${_coaf_fxn}" "${_coaf_base}")
endfunction()
