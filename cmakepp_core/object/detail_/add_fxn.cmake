include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Adds a vtable entry for the provided function.
#
# This function wraps the process of retreiving the vtable and adding an entry
# to it. If the entry already exists this function amounts to a no-op.
#
# :param _coaf_type: The object whose vtable is being updated.
# :type _coaf_type: obj
# param _coaf_name: The name of the function we are adding to the vtable
# :type _coaf_name: desc
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
#
# If CMakePP is run in debug mode this function will ensure that all provided
# arguments have the correct types and that no additional arguments have been
# provided. These error checks are only done if CMakePP is run in debug mode.
#]]
function(_cpp_object_add_fxn _coaf_type _coaf_name)
    cpp_assert_signature("${ARGV}" obj desc)

    # Get the vtable and determine if the function exists already
    _cpp_object_get_fxns(_coaf_fxns "${_coaf_type}")
    cpp_map(HAS_KEY _coaf_has_fxn "${_coaf_fxns}" "${_coaf_name}")


    if("${_coaf_has_fxn}")  # Already exists, early termination
        return()
    endif()

    cpp_map(CTOR _coaf_temp)
    cpp_map(SET "${_coaf_fxns}" "${_coaf_name}" "${_coaf_temp}")
endfunction()
