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

#[[[ @module
# Defines functions for checking if a function can be run with the specified
# signature. This is used, for example, to enforce strong typing on class
# member functions.
#]]

include_guard()

include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/types/implicitly_convertible)
include(cmakepp_lang/utilities/return)
include(cmakepp_lang/utilities/sanitize_string)

#[[[
# Handles logic for comparing the human-readable names of the functions.
#
# This function compares the name part of two signatures (*i.e.*, the 0th
# element) in a case-insensitive manner.
#
# :param result: The name for the variable which will hold the result.
# :type result: desc
# :param lhs: The signature of the first function.
# :type fxn: list*
# :param rhs: The signature of the second function.
# :type fxn: list*
# :returns: ``result`` will be set to ``TRUE`` if the two signatures have
#           the same name (up to case-sensitivity) and ``FALSE`` otherwise.
# :rtype: bool
#
# .. note::
#
#    This routine has been factored out to facilitate testing of is_callable. It
#    is not meant for use outside of the scope of comparing function signatures.
#
#]]
function(_cpp_compare_names _cn_result _cn_lhs _cn_rhs)
    list(GET "${_cn_lhs}" 0 _cn_lhs_name)
    list(GET "${_cn_rhs}" 0 _cn_rhs_name)
    cpp_sanitize_string(_cn_lhs_name "${_cn_lhs_name}")
    cpp_sanitize_string(_cn_rhs_name "${_cn_rhs_name}")

    if("${_cn_lhs_name}" STREQUAL "${_cn_rhs_name}")
        set("${_cn_result}" TRUE PARENT_SCOPE)
    else()
        set("${_cn_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()

#[[[
# Attempts to rule out a signature match based on length arguments alone.
#
# For non-variadic functions we know that if one signature is longer than the
# other they can't possibly be a match. For a variadic function with :math:`n`
# required positional arguments we know that if the user provided less than
# :math:`n` arguments, this function can not possibly be called with the
# provided arguments.
#
# :param result: Name for variable which will hold the result.
# :type result: desc
# :param fxn: The signature of the function we are trying to call.
# :type fxn: list*
# :param args: The signature of how we are trying to call the function.
# :type args: list*
# :returns: ``result`` will be set to ``TRUE`` if we can call the function
#           with the provided arguments and ``FALSE`` otherwise.
# :rtype: bool
#
# .. note::
#
#    This routine has been factored out to facilitate testing of is_callable. It
#    is not meant for use outside of the scope of comparing function signatures.
#]]
function(_cpp_compare_lengths _cl_result _cl_fxn _cl_args)
    list(LENGTH "${_cl_fxn}" _cl_fxn_n)
    list(LENGTH "${_cl_args}" _cl_args_n)

    # Handle scenario where fxn takes no arguments
    if("${_cl_fxn_n}" EQUAL 1)
        if("${_cl_args_n}" EQUAL 1)
            set("${_cl_result}" TRUE PARENT_SCOPE)
        else()
            set("${_cl_result}" FALSE PARENT_SCOPE)
        endif()
        return()
    endif()

    # We know fxn takes at least one argument or is possibly pure variadic
    math(EXPR _cl_fxn_last "${_cl_fxn_n} - 1")

    list(GET "${_cl_fxn}" "${_cl_fxn_last}" _cl_fxn_last_value)

    if("${_cl_fxn_last_value}" STREQUAL "args")
        # Variadic, so args must have fxn_n -1 or more values
        if("${_cl_args_n}" LESS "${_cl_fxn_last}")
            set("${_cl_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    else()
        #Not variadic, so args must have same number of values
        if(NOT "${_cl_args_n}" EQUAL "${_cl_fxn_n}")
            set("${_cl_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    endif()

    set("${_cl_result}" TRUE PARENT_SCOPE)
endfunction()

#[[[
# Determines if a function can be run as the specified signature.
#
# This function takes two lists ``fxn`` and ``args``. Each list is
# interpreted as being a function signature such that the first element is the
# name of the function and the remaining arguments are: the types of the
# arguments the function was declared to take (for ``fxn``) or the types of
# the arguments being passed in (for ``args``). This function ultimately
# determines whether there is a series of implicit casts which will convert the
# types in ``args`` into those in ``fxn``. If there is than ``fxn``
# is callable as the signature provided by ``args``. If there is no such set
# of casts then ``fxn`` is not callable with the signature provided by
# ``args``.
#
# :param result: Name of the variable which will hold the result.
# :type result: desc
# :param fxn: The signature of the function we are trying to cast to.
# :type fxn: list*
# :param args: The signature of the function we are trying to cast from.
# :type args: list*
# :returns: ``result`` will be set to ``TRUE`` if ``args`` can be cast
#           to ``fxn`` and ``FALSE`` otherwise.
# :rtype: bool
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will ensure that only three
# arguments are provided and that each argument has the correct type. If any of
# these asserts fail an error will be raised. These assertions are only done in
# debug mode.
#]]
function(cpp_is_callable _ic_result _ic_fxn _ic_args)
    cpp_assert_signature("${ARGV}" desc desc desc)

    _cpp_compare_names("${_ic_result}" "${_ic_fxn}" "${_ic_args}")
    if(NOT "${${_ic_result}}")
        cpp_return("${_ic_result}")
    endif()

    list(LENGTH "${_ic_fxn}" _ic_fxn_n)
    _cpp_compare_lengths("${_ic_result}" "${_ic_fxn}" "${_ic_args}")
    if(NOT "${${_ic_result}}")
        cpp_return("${_ic_result}")
    # Get true if n == m == 1, but foreach below won't handle it, so return here
    elseif("${_ic_fxn_n}" EQUAL 1)
        set("${_ic_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # foreach is inclusive and since fxn takes at least 1 arg, ok to subtract 1
    math(EXPR _ic_fxn_n "${_ic_fxn_n} - 1")

    foreach(_ic_i RANGE 1 "${_ic_fxn_n}")
        list(GET "${_ic_fxn}" "${_ic_i}" _ic_fxn_i)

        # If we've matched this far and fxn is variadic it's a match!!
        if("${_ic_fxn_i}" STREQUAL "args")
            set("${_ic_result}" TRUE PARENT_SCOPE)
            return()
        endif()

        list(GET "${_ic_args}" "${_ic_i}" _ic_args_i)
        cpp_implicitly_convertible(_ic_good "${_ic_args_i}" "${_ic_fxn_i}")
        if(NOT "${_ic_good}")
            set("${_ic_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    endforeach()

    set("${_ic_result}" TRUE PARENT_SCOPE)
endfunction()
