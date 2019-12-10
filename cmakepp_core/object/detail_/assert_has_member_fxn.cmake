include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/detail_/get_fxns)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Code factorization for ensuring that a member function exists.
#
# ``_cpp_object_assert_has_member_fxn`` checks to see if the provided instance
# has a member function with the provided name. This function does not assert
# that overloads exist for the function, or that it has been implemented only
# that a vtable entry exists. The assertion only occurrs in CMakePP is in debug
# mode.
#
# :param _coahmf_type: The object whose vtable is being analyzed.
# :type _coahmf_type: obj
# :param _coahmf_fxn: The unmangled function we are looking for.
# :type _coahmf_fxn: desc
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# Error Checking:
# ===============
#
# If CMakePP is run in debug mode this function will ensure that the arguments
# provided to it have the correct types and that no extra arguments have been
# provided. These error checks are only run if CMakePP is in debug mode.
#]]
function(_cpp_object_assert_has_member_fxn _coahmf_type _coahmf_fxn)
    cpp_enable_if_debug()
    cpp_assert_signature("${ARGV}" obj desc)
    _cpp_object_get_fxns(_coahmf_fxns "${_coahmf_type}")
    cpp_map(HAS_KEY _coahmf_has_key "${_coahmf_fxns}" "${_coahmf_fxn}")
    cpp_assert("${_coahmf_has_key}" "Class has member function ${_coahmf_fxn}")
endfunction()
