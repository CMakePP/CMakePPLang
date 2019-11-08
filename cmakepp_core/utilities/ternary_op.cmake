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
# :param _cto_tval: The value to return if the condition is true.
# :type _cto_tval: str
# :param _cto_fval: The value to return if the condition is false.
# :type _cto_fval: str
# :param ARGN: The condition. ``ARGN`` can be a single value whose truthy-ness
               will be evaluated like ``if(${ARGN})`` or a statement like
               ``x y z`` where ``x`` and ``z`` are the values being compared and
               ``y`` is one of the CMake comparison operators (``EQUAL``,
               ``LESS``, ``STREQUAL``, etc.). We are unable to accept any other
               condition at this time.
# :returns: ``_cto_tval`` if ``ARGN`` is true and ``_cto_fval`` otherwise. The
#           result is returned via ``_cto_result``.
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
#    cpp_ternary_op(result "was_foo" "was_not_foo" "${input} STREQUAL "foo")
#    message("result contains: ${result}")  # Should print "was_foo"
#]]
function(cpp_ternary_op _cto_result _cto_tval _cto_fval)
    if(NOT ${ARGC} EQUAL 4 AND NOT ${ARGC} EQUAL 6)
        message(
            FATAL_ERROR
            "Ternary op must be called with either 4 or 6 arguments. Call was:"
            "cpp_ternary_op(${ARGV})"
        )
    endif()

    if(${ARGC} EQUAL 4 AND "${ARGN}")
        set("${_cto_result}" "${_cto_tval}")
    elseif(${ARGC} EQUAL 6 AND "${ARGV3}" ${ARGV4} "${ARGV5}")
        set("${_cto_result}" "${_cto_tval}")
    else()
        set("${_cto_result}" "${_cto_fval}")
    endif()
    cpp_return("${_cto_result}")
endfunction()
