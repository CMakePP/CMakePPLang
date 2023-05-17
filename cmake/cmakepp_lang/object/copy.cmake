include_guard()
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/map/copy)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/return)
include(cmakepp_lang/utilities/unique_id)

#[[[
# Deep copies an Object instance.
#
# This function is the default copy implementation for all user-defined objects.
# It can be overridden in the base class if desired. The default implementation
# simply deep copies recursively the entirety of the Object's state.
#
# :param this: The Object instance which is being copied.
# :type this: obj
# :param other: Name for the variable which will hold the copy.
# :type other: desc
# :returns: ``_oc_other`` will be set to a deep copy of ``_oc_this``.
# :rtype: obj
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if CMakePP is run in debug mode)
# this function will ensure that it was called with the correct number and types
# of arguments.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(_cpp_object_copy _oc_this _oc_other)
    cpp_assert_signature("${ARGV}" obj desc)

    # Get the state and type of the object we're copying
    cpp_get_global(_oc_this_state "${_oc_this}__state")
    cpp_get_global(_oc_this_type "${_oc_this}__type")

    # Deep copy the state and associate the copy with a new ID
    cpp_map_copy("${_oc_this_state}" _oc_other_state)
    cpp_unique_id("${_oc_other}")
    cpp_set_global("${${_oc_other}}__state" "${_oc_other_state}")

    # Set the type of the copy and return
    cpp_set_global("${${_oc_other}}__type" "${_oc_this_type}")
    cpp_return("${_oc_other}")
endfunction()

