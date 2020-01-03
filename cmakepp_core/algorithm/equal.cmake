include_guard()
include(cmakepp_core/object/equal)
include(cmakepp_core/types/type_of)
include(cmakepp_core/types/implicitly_convertible)
include(cmakepp_core/utilities/compare_lists)
include(cmakepp_core/utilities/return)

#[[[ Compares two values for equivalency.
#
# This function can be used to compare any two CMakePP objects for equality. For
# native CMake types, like booleans and integers, equality is defined as being
# the same string. ``cpp_equal`` will also compare objects like CMakePP maps or
# instances of user-defined classes to ensure they have the same state. If two
# objects have different types they are defined to be unequal.
#
# :param _ce_result: The name to use for variable holding the result.
# :type _ce_result: desc
# :param _ce_lhs: One of the two values involved in the comparison.
# :type _ce_lhs: str
# :param _ce_rhs: The other value involved in the comparison
# :type _ce_rhs: str
# :returns: ``_ce_result`` will be set to ``TRUE`` if ``_ce_lhs`` compares equal
#           to ``_ce_rhs`` and ``FALSE`` otherwise.
# :rtype: bool*
#
#]]
function(cpp_equal _ce_result _ce_lhs _ce_rhs)

    cpp_type_of(_ce_lhs_type "${_ce_lhs}")
    cpp_type_of(_ce_rhs_type "${_ce_rhs}")
    message("${_ce_rhs_type} ${_ce_lhs_type}")
    cpp_implicitly_convertible(
        _ce_good_types "${_ce_rhs_type}" "${_ce_lhs_type}"
    )

    # Different types
    if(NOT "${_ce_good_types}")
        set("${_ce_result}" FALSE PARENT_SCOPE)
        return()
    endif()

    cpp_implicitly_convertible(_ce_is_obj "${_ce_lhs_type}" "obj")
    message("Equal: ${_ce_is_obj} ${_ce_lhs_type}")
    if("${_ce_is_obj}")
        _cpp_object_equal("${_ce_lhs}" "${_ce_result}" "${_ce_rhs}")
        cpp_return("${_ce_result}")
    elseif("${_ce_lhs_type}" STREQUAL "list")
        cpp_compare_lists("${_ce_result}" _ce_lhs _ce_rhs)
        cpp_return("${_ce_result}")
    elseif("${_ce_lhs_type}" STREQUAL "map")
        cpp_map(EQUAL "${_ce_lhs}" "${_ce_result}" "${_ce_rhs}")
        cpp_return("${_ce_result}")
    elseif("${_ce_lhs}" STREQUAL "${_ce_rhs}")
        set("${_ce_result}" TRUE PARENT_SCOPE)
    else()
        set("${_ce_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
