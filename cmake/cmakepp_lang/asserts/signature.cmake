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

include(cmakepp_lang/asserts/type)
include(cmakepp_lang/asserts/assert)
include(cmakepp_lang/utilities/enable_if_debug)

#[[[
# Ensures a function was called with the correct number and types of objects.
#
# This function encapsulates the logic required to make sure that a CMake
# function was called with the correct numer and types of arguments. It should
# be noted that CMake itself already ensures that the user passed enough
# arguments to satisfy all positional arguments so this function does not check
# that. This function involves somewhat expensive error-checking and will only
# run if CMakePP is run in debug mode.
#
# :param argv: The values of the arguments which were passed to the caller.
# :type argv: list
# :param \*args: The types that each argument should obey. Users can pass
#                ``args`` as a type to indicate that their function is variadic.
#                If provided, ``args`` must be the last type.
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# Example Usage
# =============
#
# This function is intended to be called first thing inside as many CMakePP and
# user functions as possible. A typical use case looks like:
#
# .. code-block::
#
#    include(cmakepp_lang/asserts/signature)
#    function(my_fxn a_int a_bool)
#        cpp_assert_signature("${ARGV}" int bool)
#    endfunction()
#
# The first argument to ``cpp_assert_signature`` should always be ``"${ARGV}``
# the remaining arguments should be the types
#]]
function(cpp_assert_signature _cas_argv)
    cpp_enable_if_debug()
    list(LENGTH _cas_argv _cas_nargs)
    set(_cas_has_args FALSE)
    set(_cas_counter 0)

    foreach(_cas_type_i ${ARGN})
        string(TOLOWER "${_cas_type_i}" _cas_type_i)
        # Only way this can be true is if the previous iteration set it to true
        if(_cas_has_args)
            cpp_assert(FALSE "'args' is last type provided")
        endif()

        # *args is allowed to be set to any value, including no value
        if("${_cas_type_i}" STREQUAL "args")
            set(_cas_has_args TRUE)
            continue()
        endif()

        # Get the counter-th argument passed to the function
        list(GET _cas_argv "${_cas_counter}" _cas_elem)
        # Only check if the type is not supposed to be a string
        if(NOT "${_cas_type_i}" STREQUAL "str")
            cpp_assert_type("${_cas_type_i}" "${_cas_elem}")
        endif()

        math(EXPR _cas_counter "${_cas_counter} + 1")
    endforeach()

    if(_cas_has_args)
        return()
    endif()

    # Make sure the user didn't pass extra arguments
    if("${_cas_nargs}" GREATER "${_cas_counter}")
        set(_cas_error "Function takes ${_cas_counter} argument(s), but")
        message(FATAL_ERROR "${_cas_error} ${_cas_nargs} was/were provided")
    endif()
endfunction()
