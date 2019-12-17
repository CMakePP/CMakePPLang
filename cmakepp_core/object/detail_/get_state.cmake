include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/get_global)
include(cmakepp_core/utilities/return)

#[[[ Code factorization for getting a piece of the object's state.
#
# :param _cogs_object: The object whose state is being retrieved.
# :type _cogs_object: obj
# :param _cogs_result: Name for variable which will hold the result.
# :type _cogs_result: desc
# :param _cogs_property: The piece of state we are retrieving. Should be one of:
#                        "vtable", "attrs", "bases", or "type".
# :type _cogs_property: desc
# :returns: ``_cogs_result`` will be set to the value of the requested piece of
#           state.
# :rtype: map* for "vtable" and "attrs", array* for "bases", and desc* for
#         "type".
#]]
function(_cpp_object_get_state _cogs_object _cogs_result _cogs_property)
    cpp_assert_signature("${ARGV}" obj desc desc)

    cpp_get_global(_cogs_state "${_cogs_object}")
    cpp_map(GET "${_cogs_result}" "${_cogs_state}" "${_cogs_property}")
    cpp_return("${_cogs_result}")
endfunction()

#[[[ Retrieves the vtable of the object.
#
# :param _cogv_object: The object whose vtable is being retrieved.
# :type _cogv_object: obj
# :param _cogv_result: Name for variable which will hold the vtable.
# :type _cogv_result: desc
# :returns: ``_cogv_result`` will be set to the vtable for the object.
# :rtype: map*
#]]
macro(_cpp_object_get_vtable _cogv_object _cogv_result)
    _cpp_object_get_state("${_cogv_object}" "${_cogv_result}" vtable)
endmacro()


#[[[ Retrieves the attributes of the object.
#
# :param _coga_object: The object whose attributes we want.
# :type _coga_object: obj
# :param _coga_result: Name for variable which will hold the attributes.
# :type _coga_result: desc
# :returns: ``_coga_result`` will be set to the object's attributes.
# :rtype: map*
#]]
macro(_cpp_object_get_attrs _coga_object _coga_result)
    _cpp_object_get_state("${_coga_object}" "${_coga_result}" attrs)
endmacro()

#[[[ Retrieves the classes this object inherits from.
#
# :param _cogb_object: The object whose base classes have been requested.
# :type _cogb_object: obj
# :param _cogb_result: Name for identifier which will hold the base class names
# :type _cogb_result: desc
# :returns: ``_cogb_result`` will be set to an array containing the names of the
#           classes the object derives from.
# :rtype: array*
#]]
macro(_cpp_object_get_bases _cogb_object _cogb_result)
    cpp_get_global("${_cogt_result}" "${_cogb_object}_bases")
endmacro()

#[[[ Retrieves the type of the object.
#
# :param _cogt_object: The object whose type we want.
# :type _cogt_object: obj
# :param _cogt_result: Name for identifier which will hold the type
# :type _cogt_result: desc
# :returns: ``_cogt_result`` will be set to the type of the object.
# :rtype: desc*
#
#]]
macro(_cpp_object_get_type _cogt_object _cogt_result)
    cpp_get_global("${_cogt_result}" "${_cogt_object}_type")
endmacro()
