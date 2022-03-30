include_guard()

#[[[ Encodes special characters to protect them during function passes.
#
# This function encodes special characters that need to be escaped in a CMake
# string to protect them while being passed as function parameters through 
# multiple functions. It is assumed that this will be called on the arguments
# immediately after they are passed into the first function in a series of 
# function calls, protecting the special characters until they are decoded at
# their destination.
# 
# This is neescsary because of the way CMake removes the forward slashes 
# escaping the characters as they are passed through as a function parameter, 
# so users do not have to account for the various function calls being
# performed in the background when an object method is called.
#
# :param _esc_argn: The argument list. This should have at least one string in
#                   it, otherwise this function will have nothing to encode.
# :type _esc_argn: list
# :param _esc_return_argn: Return variable for the encoded argument list.
# :type _esc_return_argn: list
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
# slashes removed, which could cause unintended consequenesc.
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
# The only argument to this function should always be ``"${ARGn}``.
#]]
function(cpp_encode_special_chars _esc_argn _esc_return_argn)
    # message("---- cpp_encode_special_chars _esc_argn: ${_esc_argn}") # DEBUG

    string(ASCII 7 _quote_replace)

    foreach(_arg ${_esc_argn})
        # message("       Parsing arg: ${_arg}") # DEBUG
        string(REPLACE "\"" "${_quote_replace}" _encoded_arg "${_arg}")

        list(APPEND _encoded_args "${_encoded_arg}")
        # message("       Encoded to: ${_encoded_arg}") # DEBUG
    endforeach()

    set("${_esc_return_argn}" "${_encoded_args}" PARENT_SCOPE)
endfunction()
