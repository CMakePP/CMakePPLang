include_guard()
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/return)

#[[[ Gets a list of all keys known to a map.
#
# This function can be used to get a list of keys which have been set for this
# map.
#
# :param _mk_this: The map whose keys are being retrieved.
# :type _mk_this: map
# :param _mk_keys: Name for the variable which will hold the keys.
# :type _mk_keys: desc
# :returns: ``_mk_keys`` will be set to the list of keys which have been set for
#           ``_mk_this``.
# :rtype: [desc]
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was called
# with exactly two arguments, and that those arguments have the correct types.
# If these assertions fail an error will be raised. These checks are only
# performed if CMakePP is run in debug mode.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(cpp_map_keys _mk_this _mk_keys)
    cpp_assert_signature("${ARGV}" map desc)

    cpp_get_global("${_mk_keys}" "${_mk_this}_keys")
    list(REMOVE_DUPLICATES "${_mk_keys}")
    cpp_return("${_mk_keys}")
endfunction()
