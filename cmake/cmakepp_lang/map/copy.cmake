include_guard()
include(cmakepp_lang/algorithm/copy)
include(cmakepp_lang/asserts/signature)

#[[[
# Makes a deep copy of a Map instance.
#
# This function will deep copy (recursively) the contents of a map into a new
# Map instance. The resulting instance will not alias the original map in any
# way.
#
# :param _mc_this: The Map instance being copied.
# :type _mc_this: map
# :param _mc_other: The name of the variable which will hold the deep copy.
# :type _mc_other: desc
# :returns: ``_mc_other`` will be set to a deep copy of ``_mc_this``.
# :rtype: map
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_map_copy`` will ensure that the caller
# has provided only two arguments and that those arguments are of the correct
# types. This error check is only performed if CMakePP is being run in debug
# mode.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(cpp_map_copy _mc_this _mc_other)
    cpp_assert_signature("${ARGV}" map desc)

    # Start a local buffer to avoid recursive calls overwriting our progress
    cpp_map_ctor("_mc_temp")

    # Get and loop over the keys
    cpp_map_keys("${_mc_this}" _mc_keys)
    foreach(_mc_key_i IN LISTS _mc_keys)

        # Get the i-th value from this map, copy it, and put it into the copy
        cpp_map_get("${_mc_this}" _mc_value_i "${_mc_key_i}")
        cpp_copy(_mc_value_copy "${_mc_value_i}")
        cpp_map_set("${_mc_temp}" "${_mc_key_i}" "${_mc_value_copy}")
    endforeach()

    # Done copying this map so return the buffer as the copy
    set("${_mc_other}" "${_mc_temp}" PARENT_SCOPE)
endfunction()
