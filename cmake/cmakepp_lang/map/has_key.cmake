include_guard()
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/map/keys)
include(cmakepp_lang/utilities/sanitize_string)

#[[[
# Determines if a map has the specified key.
#
# This function is used to determine if a particular key has been set for this
# map.
#
# :param this: The map for which we want to know if it has the specified
#                   key.
# :type this: map
# :param result: Name to use for the variable which will hold the result.
# :type result: desc
# :param key: The key we want to know if the map has.
# :type key: str
# :returns: ``_mhk_result`` will be set to ``TRUE`` if ``_mhk_key`` has been
#           set for this map and ``FALSE`` otherwise.
# :rtype: bool
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
function(cpp_map_has_key _mhk_this _mhk_result _mhk_key)
    cpp_assert_signature("${ARGV}" map desc str)

    cpp_map_keys("${_mhk_this}" _mhk_keys)
    cpp_sanitize_string(_mhk_key "${_mhk_key}")
    list(FIND _mhk_keys "${_mhk_key}" _mhk_index)
    if("${_mhk_index}" GREATER -1)
        set("${_mhk_result}" TRUE PARENT_SCOPE)
    else()
        set("${_mhk_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
