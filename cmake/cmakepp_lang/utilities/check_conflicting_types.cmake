include_guard()

#[[[ Checks if the given name conflicts with any built-in CMakePPLang types.
#
# :param _cc_conflict: Return value for whether a conflict exists.
# :type _cc_conflict: bool*
# :param _cc_conflicting_type: Return value for the type that the name
#                              conflicts with.
# :type _cc_conflicting_type: desc*
# :param _cc_name: Name to check for conflicts with.
# :type _cc_name: desc
#
# :returns: Whether there was a conflict (TRUE) or not (FALSE) and the
#           conflicting type, or an empty string ("") if no conflicts
#           occured.
# :rtype: (bool, desc)
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with all three arguments and that
# the arguments have the correct types.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(cpp_check_conflicts _cc_conflict _cc_conflicting_type _cc_name)
    cpp_assert_signature("${ARGV}" desc desc desc)

    # This is a list of all of the "built-in" types for CMakePPLang
    set(
        _cc_cpp_types
        bool fxn path float genexpr int list str target desc type class map obj
    )

    # Check if each type matches the given type, which results in a conflict
    foreach(_cc_cpp_type ${_cc_cpp_types})
        if("${_cc_cpp_type}" STREQUAL "${_cc_name}")
            set("${_cc_conflict}" TRUE PARENT_SCOPE)
            set("${_cc_conflicting_type}" "${_cc_cpp_type}" PARENT_SCOPE)
            return()
        endif()
    endforeach()

    # No conflict was found
    set("${_cc_conflict}" FALSE PARENT_SCOPE)
    set("${_cc_conflicting_type}" "" PARENT_SCOPE)
endfunction()
