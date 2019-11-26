include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/assert_class_is_registered)
include(cmakepp_core/class/detail_/get_class_registry)

#[[[ Retrieves the map from attribute names to types for a class.
#
# The map for a particular class type stores the list of attributes in a submap.
# This function wraps the process of retrieving that map, It's ultimately just
# code factorization.
#
# :param _ccga_attrs: The name for the variable used to hold the result.
# :type _ccga_fxns: desc
# :param _ccga_type: The type of the class we are getting the attributes for.
#                    Must be a class whose registration process has been
#                    minimally started, if not finished.
# :type _ccga_type: desc
# :returns: ``_ccga_attrs`` will contain a map from attribute names to types.
# :rtype: map*
#]]
function(_cpp_class_get_attrs _ccga_attrs _ccga_type)
    cpp_assert_signature("${ARGV}" desc desc)
    _cpp_assert_class_is_registered("${_ccga_type}")

    _cpp_get_class_registry(_ccga_registry)
    # Basically does: "return registry.at(class).at(attr)"
    cpp_map(GET _ccga_class "${_ccga_registry}" "${_ccga_type}")
    cpp_map(GET "${_ccga_attrs}" "${_ccga_class}" attributes)
    cpp_return("${_ccga_attrs}")
endfunction()
