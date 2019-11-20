include_guard()
include(cmakepp_core/map/map)

#[[[ Compares two arrays for equality.
#
# Two arrays are equal if they contain the same number of elements, the same
# elements, and the elements are stored in the same order.
#
# :param _caae_result: The name to use for the variable containing the result.
# :type _caae_result: desc
# :param _caae_lhs: One of the two arrays to compare.
# :type _caae_lhs: array
# :param _caae_rhs: The other array being compared
# :type _caae_rhs: array
# :returns: ``_caae_result`` will be set to ``TRUE`` if the arrays are equal and
#           ``FALSE`` otherwise.
# :rtype: bool*
#]]
function(_cpp_array_are_equal _caae_result _caae_lhs _caae_rhs)
    cpp_assert_signature("${ARGV}" desc array array)
    get_property(_caae_lhs_state GLOBAL PROPERTY "${_caae_lhs}")
    get_property(_caae_rhs_state GLOBAL PROPERTY "${_caae_rhs}")
    cpp_map(
        ARE_EQUAL
        "${_caae_result}" "${_caae_lhs_state}" "${_caae_rhs_state}"
    )
    cpp_return("${_caae_result}")
endfunction()
