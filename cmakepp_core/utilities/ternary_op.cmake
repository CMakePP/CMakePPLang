include_guard()
include(cmakepp_core/utilities/return)

#[[[ Implements a ternary operator.
#
# Having the value of a variable depend on whether a condition is true or not
# is very common in most codes. Consequentially many languages implement what is
# called the ternary operator or conditional operator. The ``cpp_ternary_op``
# is the CMakePP version. Based on whether a condition is true or not,
# ``cpp_ternary_op`` will return one of two values: ``_cto_tval`` if the
# condition is true and ``_cto_fval`` if the condition is false.
#
#
# :param _cto_result: Identifier to hold the resulting value.
# :type _cto_result: identifier
# :param _cto_cond: The condition to evaluate. Valid conditions are anything
#                   that can be used in CMake's "if" statements; however, if
#                   the condition has multiple pieces (*e.g.*, ``x STREQUAL x``)
#                   it must be passed as a list (*e.g.*, ``x;STREQUAL;x``).
# :type _cto_cond: bool or list(str)
# :param _cto_tval: The value to return if ``_cto_cond`` is true.
# :type _cto_tval: str
# :param _cto_fval: The value to return if ``_cto_cond`` is false.
# :type _cto_fval: str
# :returns: ``_cto_tval`` if ``_cto_cond`` is true and ``_cto_fval`` otherwise.
#           The result is returned via ``_cto_result``.
# :rtype: str
#
# Example
# =======
#
# The following demonstrates setting the variable ``result`` based on whether or
# not some variable ``input`` contains the string ``foo``.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/utilities/ternary_op)
#    set(input "foo")
#    cpp_ternary_op(result "${input} ;STREQUAL;foo " "was_foo" "was_not_foo")
#    message("result contains: ${result}")  # Should print "was_foo"
#
# It should be noted that on the third line we include an extra space after the
# variable
#]]
function(cpp_ternary_op _cto_result _cto_cond _cto_tval _cto_fval)
    if(${_cto_cond})
        set("${_cto_result}" "${_cto_tval}")
    else()
        set("${_cto_result}" "${_cto_fval}")
    endif()
    cpp_return("${_cto_result}")
endfunction()
