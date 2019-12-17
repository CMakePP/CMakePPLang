include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/utilities/get_global)
include(cmakepp_core/utilities/return)

#[[[ Determines if two objects are equal.
#
# Two objects are equal if they hold the same state and are of the same type.
#
# :param _coe_lhs: One of the two objects we are comparing.
# :type _coe_lhs: obj
# :param _coe_result: Name for identifier which will hold the result.
# :type _coe_result: desc
# :param _coe_rhs: The other object being compared
# :type _coe_rhs: desc
# :returns: ``_coe_result`` will be set to ``TRUE`` if the two objects are equal
#           and ``FALSE`` otherwise.
# :rtype: bool*
#]]
function(_cpp_object_equal _coe_lhs _coe_result _coe_rhs)
    cpp_assert_signature("${ARGV}" obj desc obj)

    cpp_get_global(_coe_lhs_state "${_coe_lhs}")
    cpp_get_global(_coe_rhs_state "${_coe_rhs}")
    cpp_equal("${_coe_result}" "${_coe_lhs_state}" "${_coe_rhs_state}")
    cpp_return("${_coe_result}")
endfunction()
