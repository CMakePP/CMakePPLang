include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/get_attrs)

#[[[ Public API for adding an attribute to a class.
#
# This function is called by users to add an attribute to a CMakePP class.
#
# :param _ca_class_type: The class we are adding the attribute to.
# :type _ca_class_type: desc
# :param _ca_name: The name of the attribute we are adding.
# :type _ca_name: desc
# :param _ca_attr_type: The CMakePP type of the attribute
# :type _ca_attr_type: type
#]]
function(cpp_attr _ca_class_type _ca_name _ca_attr_type)
    cpp_assert_signature("${ARGV}" desc desc type)
    _cpp_class_get_attrs(_ca_attrs "${_ca_class_type}")
    cpp_map(SET "${_ca_attrs}" "${_ca_name}" "${_ca_attr_type}")
endfunction()
