include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/function/detail_/assert_not_ambiguous)
include(cmakepp_core/function/detail_/get_overloads)
include(cmakepp_core/function/detail_/mangle_fxn)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Registers an overload with CMakePP
#
# This function is responsible for ensuring that the overload the user is
# declaring is valid (*i.e.*, not ambiguous) and for actually registering the
# overload.
#
# :param _cfao_fxn: The name of the function we are defining an overload for.
# :type _cfao_fxn: desc
# :param *args: The types of the arguments for this overload.
# :returns: ``_cfao_fxn`` will be set to the mangled name for this overload.
# :rtype: desc*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
#
# If CMakePP is run in debug mode this function will ensure that the provided
# arguments have the correct types and that the resulting overload does not
# conflict with any of the existing overloads in scope. These checks are only
# performed if CMakePP is in debug mode.
#]]
function(_cpp_function_add_overload _cfao_fxn)
    cpp_assert_signature("${ARGV}" desc args)
    # Ensure this is a good overload to add
    _cpp_function_assert_not_ambiguous("${_cfao_fxn}" ${ARGN})

    # Get the overloads
    _cpp_function_get_overloads("${_cfao_fxn}" _cfao_overloads)

    # Make the key and value respectively
    cpp_array(CTOR _cfao_types ${ARGN})
    _cpp_mangle_fxn("${_cfao_fxn}" "${_cfao_fxn}" ${ARGN})

    # Actually add the overload
    cpp_map(SET "${_cfao_overloads}" "${_cfao_types}" "${${_cfao_fxn}}")

    # Return the mangled name
    cpp_return("${_cfao_fxn}")
endfunction()
