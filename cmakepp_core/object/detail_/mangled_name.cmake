include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/detail_/get_state)

#[[[ Encapsulates the process of mangling the member function's name.
#
# The final mangled symbol is the result of mangling the class's name with the
# function name and then that symbol with the types of the overloadl. This
# function encapsulates the first step of mangling which is unique to class
# members.
#
# :param _cogmn_object: The object whose member function is being mangled.
# :type _cogmn_object: obj
# :param _cogmn_result: Name for the identifier which will hold the mangled name
# :type _cogmn_result: desc
# :param _cogmn_fxn: The name of the function we are mangling.
# :type _cogmn_fxn: desc
# :returns: ``_cogmn_result`` will be set to the mangled name for the function.
# :rtype: desc*
#
#]]
function(_cpp_object_get_mangled_name _cogmn_object _cogmn_result _cogmn_fxn)
    cpp_assert_signature("${ARGV}" obj desc desc)

    _cpp_object_get_vtable("${_cogmn_object}" _cogmn_vtable)
    cpp_map(GET _cogmn_base "${_cogmn_vtable}" "${_cogmn_fxn}")
    set("${_cogmn_result}" "${_cogmn_base}_${_cogmn_fxn}" PARENT_SCOPE)
endfunction()
