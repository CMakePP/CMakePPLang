include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Determines if a provided path points to an existing file.
#
# :param _cfe_result: Name for variable which will hold the result.
# :type _cfe_result: desc
# :param _cfe_file: Potential path pointing to a file.
# :type _cfe_file: path
# :returns: ``_cfe_result`` will be set to ``TRUE`` if ``_cfe_file`` is the
#           absolute path of a file and ``FALSE`` otherwise. Of note if
#           ``_cfe_file`` is the absolute path to a directory the result is also
#           ``FALSE``.
# :rtype: bool*
#
#]]
function(cpp_file_exists _cfe_result _cfe_file)
    cpp_assert_signature("${ARGV}" desc path)

    if(EXISTS "${_cfe_file}")
        if(IS_DIRECTORY "${_cfe_file}")
            set("${_cfe_result}" FALSE PARENT_SCOPE)
        else()
            set("${_cfe_result}" TRUE PARENT_SCOPE)
        endif()
    else()
        set("${_cfe_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
