include_guard()
include(cmakepp_lang/algorithm/copy)
include(cmakepp_lang/asserts/signature)

#[[[
# Adds the key-value pairs from one dictionary to another.
#
# This function adds all the key-value pairs from _m_this into
# _m_other. If a key is present in both dictionary, the value from _m_other
# will overwrite the value in _m_this.
#
# :param this: The map that will have the key-value pairs added to it.
# :type this: map
# :param other: The map whose key-value pairs will be added to _m_this.
# :type other: map
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was called
# with exactly two arguments, and that those arguments have the correct types.
# If these assertions fail an error will be raised. These checks are only
# performed if CMakePP is run in debug mode.
#]]
function(cpp_map_merge _m_this _m_other)
    cpp_assert_signature("${ARGV}" map map)

    # Add all key-value pairs from _m_other to _m_this
    cpp_map(KEYS "${_m_other}" _m_other_keys)
    foreach(_m_other_key_i ${_m_other_keys})
        cpp_map(GET "${_m_other}" _m_other_value_i "${_m_other_key_i}")
        cpp_map(SET "${_m_this}" "${_m_other_key_i}" "${_m_other_value_i}")
    endforeach()
endfunction()
