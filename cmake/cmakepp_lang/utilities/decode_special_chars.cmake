include_guard()

include(cmakepp_lang/utilities/special_chars_lookup)

#[[[
# Decodes special characters to protect them during function passes.
#
# This function decodes special characters that need to be escaped in a CMake
# string to protect them while being passed as function parameters through 
# multiple functions. It is assumed that this will be called on the arguments
# immediately before the function is finalized and written to a file.
# 
# The special characters handled are ``$;"\\``. For more information about
# why this is necessary, see documentation for ``cpp_encode_special_chars``.
#
# :param _dsc_argn: The argument list. This should have at least one string in
#                   it, otherwise this function will have nothing to encode.
# :type _dsc_argn: list
# :param _dsc_return_argn: Return variable for the encoded argument list.
# :type _dsc_return_argn: list
# :returns: The list of arguments with special characters encoded.
# :rtype: list
#
# Example Usage
# =============
#
# See documentation for ``cpp_encode_special_chars`` for usage of both the
# encoding and decoding functions.
#]]
function(cpp_decode_special_chars _dsc_argn _dsc_return_argn)

    # Get the replacement characters from the lookup map
    cpp_map(GET "${special_chars_lookup}" _quote_replace "dquote")
    cpp_map(GET "${special_chars_lookup}" _dollar_replace "dollar")
    cpp_map(GET "${special_chars_lookup}" _semicolon_replace "scolon")
    cpp_map(GET "${special_chars_lookup}" _bslash_replace "bslash")

    # Decode each encoded special character in the arguments
    foreach(_arg ${_dsc_argn})
        # Make sure that the special char is actually escaped
        string(REPLACE "${_quote_replace}" "\\\"" _decoded_arg ${_arg})
        string(REPLACE "${_bslash_replace}" "\\\\" _decoded_arg ${_decoded_arg})
        string(REPLACE "${_dollar_replace}" "\\\$" _decoded_arg ${_decoded_arg})
        string(REPLACE "${_semicolon_replace}" "\\\;" _decoded_arg ${_decoded_arg})

        list(APPEND _decoded_args ${_decoded_arg})
    endforeach()

    set("${_dsc_return_argn}" "${_decoded_args}" PARENT_SCOPE)
endfunction()
