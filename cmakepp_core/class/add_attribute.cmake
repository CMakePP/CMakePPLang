include_guard()
include(cmakepp_core/object/object)

#[[[ Registers an attribute and optionally a default value for that attribute.
#
# This function is used to declare that a class has a particular attribute.
# Optionally the user may also specify a default value for the attribute (if no
# value is specified the attribute will be set to the empty string).
#
# :param _caa_this: The Class instance we are adding the attribute to.
# :type _caa_this: class
# :param _caa_name: The name of the attribute we are adding. Names are
#                   case-insensitive.
# :type _caa_name: desc
# :param *args: The default value for the attribute. If multiple values are
#               provided the attribute will be initialized to a list containing
#               those values.
#]]
function(cpp_class_add_attr _caa_this _caa_name)
    string(TOLOWER "${_caa_name}" _caa_lc_name)
    cpp_object(GET_ATTR "${_caa_this}" _caa_attrs "attrs")
    list(APPEND _caa_attrs "${_caa_lc_name}")
    cpp_object(SET_ATTR "${_caa_this}" "attrs" "${_caa_attrs}")
    cpp_object(SET_ATTR "${_caa_this}" "_cpp_class_${_caa_lc_name}" "${ARGN}")
endfunction()

#[[[ Public API for adding an attribute to a class.
#
# This API is a thin wrapper around ``cpp_class_add_attr`` which hides the
# details of how the class information is stored from the user.
#
# :param _ca_this: The type we are adding the attribute to.
# :type _ca_this: class*
# :param _ca_name: The name of the attribute we are adding. Names are
#                   case-insensitive.
# :type _ca_name: desc
# :param *args: The default value for the attribute. If multiple values are
#               provided the attribute will be initialized to a list containing
#               those values.
#]]
function(cpp_attr _ca_type _ca_name)
    string(TOLOWER "${_ca_type}" _ca_lc_type)
    cpp_class_add_attr("${_cpp_${_ca_lc_type}_helper}" "${_ca_name}" ${ARGN})
endfunction()
