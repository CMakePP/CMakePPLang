include_guard()

#[[[ Determines if a string is the name of a target.
#
# CMake maintains an internal list of targets and allows us to query whether a
# particular identifier is a target via CMake's native ``if`` statement. This
# function simply wraps a call to ``if(TARGET ...)``.
#
# :param _cit_return: Name to use for the resulting identifier.
# :type _cit_return: desc
# :param _cit_str2check: The string whose targety-ness is in question
# :type _cit_str2check: str
# :returns: ``_cit_return`` will be set to ``TRUE`` if ``_cit_str2check`` is a
#           target and ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following is an example showcasing how one would check if the identifier
# ``my_target`` is a target:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/detail_/target)
#    add_library(my_target STATIC IMPORTED)
#    _cpp_is_target(return ${my_target})
#    message("my_target is a target: ${return}")  # prints TRUE
#]]
function(_cpp_is_target _cit_return _cit_str2check)
    if(TARGET "${_cit_str2check}")
        set("${_cit_return}" TRUE PARENT_SCOPE)
    else()
        set("${_cit_return}" FALSE PARENT_SCOPE)
    endif()
endfunction()
