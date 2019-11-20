include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/logic/are_equal)
include(cmakepp_core/utilities/return)

#[[[ Compares two maps in order to determine if they are equal.
#
# Two maps are equal if they contain the same key, value pairs. The order in
# which the key, value pairs are stored is not considered.
#
# :param _cmae_result: The name for the variable which will hold the result.
# :type _cmae_result: desc
# :param _cmae_lhs: One of the two maps to compare.
# :type _cmae_lhs: map
# :param _cmae_rhs: The other map being compared.
# :type _cmae_rhs: map
# :returns: ``_cmae_result`` will be set to ``TRUE`` if the two maps compare
#           equal and ``FALSE`` otherwise.
# :rtype: bool*
#]]
function(_cpp_map_are_equal _cmae_result _cmae_lhs _cmae_rhs)
    cpp_assert_signature("${ARGV}" desc map map)

    set("${_cmae_result}" FALSE)
    if("${_cmae_lhs}" STREQUAL "${_cmae_rhs}")
        set("${_cmae_result}" TRUE)
        cpp_return("${_cmae_result}")
    endif()

    _cpp_map_keys(_cmae_lhs_keys "${_cmae_lhs}")
    _cpp_map_keys(_cmae_rhs_keys "${_cmae_rhs}")

    # Key order doesn't matter, so make sure keys are in the same order
    list(SORT _cmae_lhs_keys)
    list(SORT _cmae_rhs_keys)

    cpp_are_equal(_cmae_same_keys "${_cmae_lhs_keys}" "${_cmae_rhs_keys}")

    if(NOT "${_cmae_same_keys}")
        cpp_return("${_cmae_result}")
    endif()

    foreach(_cmae_key_i IN LISTS _cmae_lhs_keys)
        _cpp_map_get(_cmae_value_lhs "${_cmae_lhs}" "${_cmae_key_i}")
        _cpp_map_get(_cmae_value_rhs "${_cmae_rhs}" "${_cmae_key_i}")
        cpp_are_equal(_cmae_same "${_cmae_value_lhs}" "${_cmae_value_rhs}")
        if(NOT "${_cmae_same}")
            cpp_return("${_cmae_result}")
        endif()
    endforeach()

    set("${_cmae_result}" TRUE)
    cpp_return("${_cmae_result}")
endfunction()
