include_guard()

#[[[ Decodes special characters to protect them during function passes.
#
# This function decodes special characters that need to be escaped in a CMake
# string to protect them while being passed as function parameters through 
# multiple functions. It is assumed that this will be called on the arguments
# immediately before the function is finalized and written to a file.
# 
# This is necessary because of the way CMake removes the forward slashes 
# escaping the characters as they are passed through as a function parameter, 
# so users do not have to account for the various function calls being
# performed in the background when an object method is called.
#
# :param _ces_argn: The argument list. This should have at least one string in
#                   it, otherwise this function will have nothing to encode.
# :type _ces_argn: list
# :param _ces_return_argn: Return variable for the encoded argument list.
# :type _ces_return_argn: list
# :returns: The list of arguments with special characters encoded.
# :rtype: list
#
# Example Usage:
# ==============
#
# This function is intended to be called near the top of a function call chain
# where arguments will be passed through multiple levels of function calls.
# This ensures that the escaped special characters are not altered in the
# string unintentionally and the special characters do not have their escape
# slashes removed, which could cause unintended consequences.
#
# The special characters need to be decoded again upon reaching their destination.
#
# .. code-block::
#
#    include(cmakepp_lang/asserts/signature)
#    function(my_fxn a_str a_bool)
#        cpp_encode_special_chars(${ARGN})
#    endfunction()
#
# The only argument to this function should always be ``"${ARGN}``.
#]]
function(cpp_decode_special_chars _ces_argn _ces_return_argn)
    # message("---- cpp_decode_special_chars _ces_argn: ${_ces_argn}") # DEBUG

    string(ASCII 7 _quote_replace)

    foreach(_arg ${_ces_argn})
        # message("       Parsing arg: ${_arg}") # DEBUG
        # Make sure that the special char is actually escaped
        string(REPLACE "${_quote_replace}" "\\\"" _decoded_arg ${_arg})

        list(APPEND _decoded_args ${_decoded_arg})
        # message("       Decoded to: ${_decoded_arg}") # DEBUG
    endforeach()

    set("${_ces_return_argn}" "${_decoded_args}" PARENT_SCOPE)
endfunction()
