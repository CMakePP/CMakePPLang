include_guard()
include(cmakepp_lang/asserts/signature)

#[[[
# Determines if a provided path points to an existing directory.
#
# :param result: Name for variable which will hold the result.
# :type result: bool*
# :param dir: Path which may be pointing to an existing directory.
# :type dir: path
# :returns: ``_cde_result`` will be set to ``TRUE`` if ``_cde_dir`` is the
#           absolute path of a directory and ``FALSE`` otherwise. Of note if
#           ``_cde_dir`` is the absolute path to a file the result is also
#           ``FALSE``.
# :rtype: bool*
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_directory_exists`` will assert that it
# has been called with two arguments and that those arguments are of the correct
# types.
#]]
function(cpp_directory_exists _cde_result _cde_dir)
    cpp_assert_signature("${ARGV}" desc path)

    if(EXISTS "${_cde_dir}")
        if(IS_DIRECTORY "${_cde_dir}")
            set("${_cde_result}" TRUE PARENT_SCOPE)
        else()
            set("${_cde_result}" FALSE PARENT_SCOPE)
        endif()
    else()
        set("${_cde_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
