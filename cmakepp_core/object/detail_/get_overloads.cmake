include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/detail_/assert_has_member_fxn)
include(cmakepp_core/object/detail_/get_fxns)
include(cmakepp_core/utilities/return)

#[[[ Returns the map of known overloads for a member function.
#
# This function is code factorization for retrieving the list of overloads for
# a member function. The overloads are a map from input arguments to the mangled
# function name to call.
#
# :param _cogo_overloads: Name for the variable which will hold the result.
# :type _cogo_overloads: desc
# :param _cogo_type: The object whose vtable is being accessed.
# :type _cogo_type: obj
# :param _cogo_fxn: The name of the function to retrieve from the vtable.
# :type _cogo_fxn: desc
# :returns: ``_cogo_overloads`` will be set to a map whose keys are lists of
#           types and whose values are the mangled function name to call for
#           inputs of those types.
# :rtype: map*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# If CMakePP is in debug mode this function will assert that all inputs have the
# correct types and that a vtable entry exists for the requested function. These
# checks are only done if CMakePP is in debug mode.
#]]
function(_cpp_object_get_overloads _cogo_overloads _cogo_type _cogo_fxn)
    cpp_assert_signature("${ARGV}" desc obj desc)
    _cpp_object_assert_has_member_fxn("${_cogo_type}" "${_cogo_fxn}")

    _cpp_object_get_fxns(_cogo_fxns "${_cogo_type}")
    cpp_map(GET "${_cogo_overloads}" "${_cogo_fxns}" "${_cogo_fxn}")
    cpp_return("${_cogo_overloads}")
endfunction()
