include_guard()
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/utilities/return)

#[[[
# Generates a unique identifier.
#
# This function will create a unique identifier which can be used, for example,
# as the "this" pointer for an object. The uniqueness of the identifier relies
# on mangling the time (with second resolution) and a random string. Thus the
# result should be unique so long as the same random string is not generated
# during the same second. No check for uniqueness is currently present although
# one could be added.
#
# :param id: The name for the variable which will hold the result.
# :type id: desc
# :returns: ``_ui_id`` will be set to the generated unique id.
# :rtype: desc
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_unique_id`` will ensure that it was
# passed only one argument and that that argument is of type ``desc``.
#]]
function(cpp_unique_id _ui_id)
    cpp_assert_signature("${ARGV}" desc)

    # Get seconds since UNIX epoch (requires CMake version >= 3.6)
    string(TIMESTAMP _ui_time "%s")

    # Prepend a random prefix onto the time
    string(RANDOM _ui_prefix)
    string(TOLOWER "cpp_${_ui_prefix}_${_ui_time}" "${_ui_id}")

    cpp_return("${_ui_id}")
endfunction()
