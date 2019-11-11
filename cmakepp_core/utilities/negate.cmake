include_guard()
include(cmakepp_core/utilities/ternary_op)

#[[[ Negates the result of the provided identifier
#
# CMake natively has no way to do something like ``!${value}``, this function
# fixes that by setting the identifier to opposite of its current value.
#
# :param _cn_result: An identifier to store the negated result
# :type _cn_result: identifier
# :param _cn_val: The value we are negating.
# :type _cn_val: bool
# :returns: ``TRUE`` if ``_cn_val`` is ``FALSE`` and ``FALSE`` otherwise. The
#           value is returned via the identifier provided as ``_cn_result``.
# :rtype: bool
#
# .. note::
#
#    We use a macro to avoid an unnecessary return statement.
#
# Example Usage:
# ==============
#
# The following example shows how to negate the boolean value contained in a
# variable. In practice the variable is usually the result of another function
# call.
#
# .. code-block::
#
#    include(cmakepp_core/utilities/negate)
#    set(is_true TRUE)
#    cpp_negate(is_false "${_is_true}")
#    message("is_false: ${is_false}")  # Prints FALSE
#]]
macro(cpp_negate _cn_result _cn_val)
    cpp_ternary_op("${_cn_result}" "${_cn_val}" FALSE TRUE)
endmacro()
