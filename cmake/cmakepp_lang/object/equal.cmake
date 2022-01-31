include_guard()
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/map/map)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/return)

#[[[ Compares two objects for equality.
#
# This function is the default equality comparison for all user-defined classes.
# It can be overridden by the derived class if a different implementation is
# needed. The default implementation ensures that the objects have the same
# most-derived type and that their states compare equal (their states are stored
# in maps and we simply compare the maps).
#
# :param _oe_this: One of the two Object instances being compared.
# :type _oe_this: obj
# :param _oe_result: Name for variable which will hold the comparison's result.
# :type _oe_result: desc
# :param _oe_other: The other Object instance being compared.
# :type _oe_other: obj
# :returns: ``_oe_result`` will be set to ``TRUE`` if the instances are equal
#           and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode (and only then) this function will
# ensure that the caller has provided exactly three arguments and that the
# arguments are of the correct types. If this is not the case an error will be
# raised.
#
# :var cmakepp_lang_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype cmakepp_lang_DEBUG_MODE: bool
#]]
function(_cpp_object_equal _oe_this _oe_result _oe_other)
    cpp_assert_signature("${ARGV}" obj desc obj)

    cpp_get_global(_oe_this_type "${_oe_this}__type")
    cpp_get_global(_oe_other_type "${_oe_other}__type")

    if(NOT "${_oe_this_type}" STREQUAL "${_oe_other_type}")
        set("${_oe_result}" FALSE PARENT_SCOPE)
        return()
    endif()

    cpp_get_global(_oe_this_state "${_oe_this}__state")
    cpp_get_global(_oe_other_state "${_oe_other}__state")
    cpp_map(EQUAL "${_oe_this_state}" "${_oe_result}" "${_oe_other_state}")
    cpp_return("${_oe_result}")
endfunction()
