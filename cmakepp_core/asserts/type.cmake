include_guard()
include(cmakepp_core/types/implicitly_convertible)
include(cmakepp_core/types/type_of)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Tests that the provided object can be implicitly cast to the provided type.
#
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode
# :type CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_assert_type _at_type _at_obj)
    cpp_enable_if_debug()
    cpp_type_of(_at_obj_type "${_at_obj}")
    cpp_implicitly_convertible(_at_convertible "${_at_obj_type}" "${_at_type}")
    cpp_assert(
        "${_at_convertible}" "${_at_obj_type} is convertible to ${_at_type}"
    )
endfunction()
