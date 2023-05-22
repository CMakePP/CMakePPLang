# Copyright 2023 CMakePP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_guard()

include(cmakepp_lang/utilities/special_chars_lookup)

#[[[
# Encodes special characters to protect them during function passes.
#
# This function encodes special characters that need to be escaped in a CMake
# string to protect them while being passed as function parameters through 
# multiple functions. It is assumed that this will be called on the arguments
# immediately after they are passed into the first function in a series of 
# function calls, protecting the special characters until they are decoded at
# their destination.
# 
# This is necessary because CMake removes the backslashes escaping
# characters from strings as they are passed as a function or macro
# parameters. Encoding special characters removes the burden on the user
# to have to add backslashes based on the various function calls being
# performed in the background when an object method is called.
#
# Specifically, the special characters handled are ``$;"\\``.
#
# :param argn: The argument list. This should have at least one string in
#              it, otherwise this function will have nothing to encode.
# :type argn: list
# :param return_argn: Return variable for the encoded argument list.
# :type return_argn: list
# :returns: The list of arguments with special characters encoded.
# :rtype: list
#
# Example Usage
# =============
#
# This function is intended to be called near the top of a function call chain
# where arguments will be passed through multiple levels of function calls.
# This ensures that special characters are not altered and do not cause
# unintended side effects while being passed through functions and macros.
#
# The special characters need to be decoded again upon reaching their destination.
#
# .. code-block::
#
#    include(cmakepp_lang/asserts/signature)
#    function(my_fxn a_str a_bool)
#        cpp_encode_special_chars("${ARGN}" encoded_args) # Encode the arguments
#        do_stuff(encoded_args)
#    endfunction()
#
#    function(do_stuff encoded_arg_list)
#        cpp_decode_special_chars("${encoded_arg_list}" decoded_args)
#        # Do stuff with decoded_args
#    endfunction()
#
# The only argument to this function should always be ``"${ARGN}"``.
#]]
function(cpp_encode_special_chars _esc_argn _esc_return_argn)

    # Get the replacement characters from the lookup map
    cpp_map(GET "${special_chars_lookup}" _quote_replace "dquote")
    cpp_map(GET "${special_chars_lookup}" _dollar_replace "dollar")
    cpp_map(GET "${special_chars_lookup}" _semicolon_replace "scolon")
    cpp_map(GET "${special_chars_lookup}" _bslash_replace "bslash")

    # Encode each special character in the string
    foreach(_arg ${_esc_argn})
        string(REPLACE ";" "${_semicolon_replace}" _encoded_arg "${_arg}")
        string(REPLACE "\$" "${_dollar_replace}" _encoded_arg "${_encoded_arg}")
        string(REPLACE "\"" "${_quote_replace}" _encoded_arg "${_encoded_arg}")
        string(REPLACE "\\" "${_bslash_replace}" _encoded_arg "${_encoded_arg}")

        list(APPEND _encoded_args "${_encoded_arg}")
    endforeach()

    set("${_esc_return_argn}" "${_encoded_args}" PARENT_SCOPE)
endfunction()
