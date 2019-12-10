include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Retrieves the member function vtable for the object.
#
# This function is code factorization for obtaining an ``Object``'s member
# function vtable. The member function vtable is a map from human-readable
# function names to the map of available overloads (the overload map, maps from
# positional argument types to mangled function names).
#
# :param _cogf_fxns: Name for the identifier which will hold the result.
# :type _cogf_fxns: desc
# :param _cogf_object: The object whose vtable has been requested.
# :type _cogf_object: object
# :returns: ``_cogf_fxns`` will be set to an alias of the object's vtable.
# :rtype: map*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is run in debug
#                               mode or not.
#
# If CMakePP is run in debug mode this function will ensure that the positional
# arguments have the correct types and that no additional arguments are
# provided. If either of these assumptions is violated an error will be raised.
# This function does not check that the vtable exists (the constructor for the
# ``Object`` class provides all ``Object`` instances with one, so barring
# malicious user-intervention, it will exist as long as the input is an
# ``Object``).
#]]
function(_cpp_object_get_fxns _cogf_fxns _cogf_object)
    cpp_assert_signature("${ARGV}" desc obj)

    get_property(_cogf_state GLOBAL PROPERTY "${_cogf_object}")
    cpp_map(GET "${_cogf_fxns}" "${_cogf_state}" "fxns")
    cpp_return("${_cogf_fxns}")
endfunction()
