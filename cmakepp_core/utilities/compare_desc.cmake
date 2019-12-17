include_guard()

#[[[ Implements a case-insensitive ``desc`` comparison.
#
#]]
function(cpp_compare_desc _cd_return _cd_lhs _cd_rhs)
    cpp_assert_signature("${ARGV}" desc desc)

    string(TOLOWER "${_cdlhs}" _cd_lhs)
    string(TOLOWER "${_cdlhs}" _cd_rhs)
    if("${_cd_lhs}" STREQUAL "${_cd_rhs}")
        set("${_cd_return}" TRUE PARENT_EQUAL)
    else()
        set("${_cd_return}" FALSE PARENT_EQUAL)
    endif()
endfunction()
