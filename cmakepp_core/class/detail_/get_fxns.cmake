include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/assert_class_is_registered)
include(cmakepp_core/class/detail_/get_class_registry)

#[[[ Retrieves the map from function names to mangled overloads for a class.
#
# The map for a particular class type stores the list of available functions in
# a submap. This function wraps the process of retrieving that dictionary, It's
# ultimately just code factorization.
#
# :param _ccgf_fxns: The name for the variable used to return the map of fxns.
# :type _ccgf_fxns: desc
# :param _ccgf_type: The type of the class we are getting the functions for.
#                    Must be a class whose registration process has been
#                    minimally started, if not finished.
# :type _ccgf_type: desc
# :returns: ``_ccgf_fxns`` will contain a map from function names to mangled
#           overloads.
# :rtype: map*
#]]
function(_cpp_class_get_fxns _ccgf_fxns _ccgf_type)
    cpp_assert_signature("${ARGV}" desc desc)

    _cpp_assert_class_is_registered("${_ccgf_type}")
    _cpp_get_class_registry(_ccgf_registry)

    # Basically does: "return registry.at(class).at(fxns)"
    cpp_map(GET _ccgf_class "${_ccgf_registry}" "${_ccgf_type}")
    cpp_map(GET "${_ccgf_fxns}" "${_ccgf_class}" fxns)
    cpp_return("${_ccgf_fxns}")
endfunction()
