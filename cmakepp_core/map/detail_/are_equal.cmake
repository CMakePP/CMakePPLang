include_guard()
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/asserts/signature)
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

    # Quick check to see if LHS and RHS are literally the same instance
    if("${_cmae_lhs}" STREQUAL "${_cmae_rhs}")
        set("${_cmae_result}" TRUE)
        cpp_return("${_cmae_result}")
    endif()

    # Rest of early aborts will be because the maps are not equal
    set("${_cmae_result}" FALSE)

    # Get the keys from each map
    _cpp_map_keys(_cmae_lhs_keys "${_cmae_lhs}")
    _cpp_map_keys(_cmae_rhs_keys "${_cmae_rhs}")

    # Ensure the maps have the same number of keys
    list(LENGTH _cmae_lhs_keys _n_lhs)
    list(LENGTH _cmae_rhs_keys _n_rhs)

    if(NOT "${_n_lhs}" STREQUAL "${_n_rhs}")
        cpp_return("${_cmae_result}")
    endif()

    # Loop over keys in LHS
    foreach(_cmae_key_i IN LISTS _cmae_lhs_keys)

        # Ensure RHS has this key
        _cpp_map_has_key(_cmae_rhs_has_key "${_cmae_rhs}" "${_cmae_key_i}")

        if(NOT "${_cmae_rhs_has_key}")
            cpp_return("${_cmae_result}")
        endif()

        # Get the values and compare them
        _cpp_map_get(_cmae_value_lhs "${_cmae_lhs}" "${_cmae_key_i}")
        _cpp_map_get(_cmae_value_rhs "${_cmae_rhs}" "${_cmae_key_i}")
        cpp_equal(_cmae_same "${_cmae_value_lhs}" "${_cmae_value_rhs}")
        if(NOT "${_cmae_same}")
            cpp_return("${_cmae_result}")
        endif()
    endforeach()

    # If we made it this far the maps are equal...
    set("${_cmae_result}" TRUE PARENT_SCOPE)
endfunction()
