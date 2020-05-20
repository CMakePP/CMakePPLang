include_guard()
include(cmakepp_core/algorithm/copy)
include(cmakepp_core/asserts/signature)

#[[[ Adds the key-value pairs from one dictionary to another.
#
# This function is to add all the key-value pairs from one dictionary into
# another.
#
# :param _u_this: The map that will have the key-value pairs added to it.
# :type _u_this: map
# :param _u_other: The map whose key-value pairs will be added to _u_this.
# :type _u_other: map
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was called
# with exactly two arguments, and that those arguments have the correct types.
# If these assertions fail an error will be raised. These checks are only
# performed if CMakePP is run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_map_update _u_this _u_other)
    cpp_assert_signature("${ARGV}" map map)

    # Add all key-value pairs from _u_other to _u_this
    cpp_map(KEYS "${_u_other}" _u_other_keys)
    foreach(_u_other_key_i ${_u_other_keys})
        cpp_map(GET "${_u_other}" _u_other_value_i "${_u_other_key_i}")
        cpp_map(SET "${_u_this}" "${_u_other_key_i}" "${_u_other_value_i}")
    endforeach()
endfunction()
