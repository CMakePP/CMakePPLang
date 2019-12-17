include_guard()
include(cmakepp_core/algorithm/contains)
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/detail_/add_function)
include(cmakepp_core/object/detail_/get_state)
include(cmakepp_core/object/detail_/set_attr)

#[[[ Merges a base class's state into the current instance.
#
# This object merges the state of ``_com_rhs`` into ``_com_lhs`` assuming that
# ``_com_rhs`` is a base class of ``_com_lhs``. After the merge ``_com_lhs``'s
# attributes, bases, and member functions will be the union of ``_com_lhs`` and
# ``_com_rhs``. If ``_com_lhs`` and ``_com_rhs`` have common attributes the
# values of the common attributes will be set to those of ``_com_rhs``. Only
# unique bases will be kept, and only new member functions will be added.
#
# :param _com_lhs: The object we are merging into. Effectively the derived
#                  class.
# :type _com_lhs: obj
# :param _com_rhs: The object we are adding to ``_com_lhs``. Effectively the
#                  base class.
# :type _com_rhs: obj
#]]
function(_cpp_object_merge _com_lhs _com_rhs)
    cpp_assert_signature("${ARGV}" obj obj)

    _cpp_object_get_vtable("${_com_rhs}" _com_vtable)
    cpp_map(KEYS _com_fxns "${_com_vtable}")
    foreach(_com_fxn ${_com_fxns})
        cpp_map(GET _com_base "${_com_vtable}" "${_com_fxn}")
        _cpp_object_add_function("${_com_lhs}" "${_com_fxn}" "${_com_base}")
    endforeach()

    _cpp_object_get_attrs("${_com_rhs}" _com_attrs)
    cpp_map(KEYS _com_keys "${_com_attrs}")
    foreach(_com_attr ${_com_keys})
        cpp_map(GET _com_value "${_com_attrs}" "${_com_attr}")
        _cpp_object_set_attr("${_com_lhs}" "${_com_attr}" "${_com_value}")
    endforeach()

    _cpp_object_get_bases("${_com_rhs}" _com_bases)
    cpp_array(END _com_nbases "${_com_bases}")
    foreach(_com_i RANGE "${_com_nbases}")
        cpp_array(GET _com_base_i "${_com_bases}" "${_com_i}")
        _cpp_object_add_base("${_com_lhs}" "${_com_base_i}")
    endforeach()
endfunction()
