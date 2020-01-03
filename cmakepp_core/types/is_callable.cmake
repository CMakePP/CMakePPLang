include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/types/implicitly_convertible)
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/sanitize_string)

#[[[ Handles logic for comparing the human-readable names of the functions.
#
# This function compares the name part of two signatures (*i.e.*, the 0th
# element) in a case-insensitive manner.
#
# :param _cn_result: The name for the variable which will hold the result.
# :type _cn_result: desc
# :param _cn_lhs: The signature of the first function.
# :type _cn_fxn: list*
# :param _cn_rhs: The signature of the second function.
# :type _cn_fxn: list*
# :returns: ``_cn_result`` will be set to ``TRUE`` if the two signatures have
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

#[[[ Attempts to rule out a signature match based on length arguments alone.
#
# For non-variadic functions we know that if one signature is longer than the
# other they can't possibly be a match. For a variadic function with :math:`n`
# required positional arguments we know that if the user provided less than
# :math:`n` arguments, this function can not possibly be called with the
# provided arguments.
#
# :param _cl_result: Name for variable which will hold the result.
# :type _cl_result: desc
# :param _cl_fxn: The signature of the function we are trying to call.
# :type _cl_fxn: list*
# :param _cl_args: The signature of how we are trying to call the function.
# :type _cl_args: list*
# :returns: ``_cl_result`` will be set to ``TRUE`` if we can call the function
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

#[[[ Determines if a function can be run as the specified signature.
#
# This function takes two lists ``_ic_fxn`` and ``_ic_args``. Each list is
# interpreted as being a function signature such that the first element is the
# name of the function and the remaining arguments are: the types of the
# arguments the function was declared to take (for ``_ic_fxn``) or the types of
# the arguments being passed in (for ``_ic_args``). This function ultimately
# determines whether there is a series of implicit casts which will convert the
# types in ``_ic_args`` into those in ``_ic_fxn``. If there is than ``_ic_fxn``
# is callable as the signature provided by ``_ic_args``. If there is no such set
# of casts then ``_ic_fxn`` is not callable with the signature provided by
# ``_ic_args``.
#
# :param _ic_result: Name of the variable which will hold the result.
# :type _ic_result: desc
# :param _ic_fxn: The signature of the function we are trying to cast to.
# :type _ic_fxn: list*
# :param _ic_args: The signature of the function we are trying to cast from.
# :type _ic_args: list*
# :returns: ``_ic_result`` will be set to ``TRUE`` if ``_ic_args`` can be cast
#           to ``_ic_fxn`` and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will ensure that only three
# arguments are provided and that each argument has the correct type. If any of
# these asserts fail an error will be raised. These assertions are only done in
# debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
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
