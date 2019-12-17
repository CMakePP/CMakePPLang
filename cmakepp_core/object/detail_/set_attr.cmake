include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/detail_/get_state)

#[[[ Sets an object's attribute to the provided value.
#
# This function encapsulates the process of setting the value of an object's
# attribute. If the attribute has already been set this function will overwrite
# its value.
#
# :param _cosa_object: The object whose attribute is being set.
# :type _cosa_object: obj
# :param _cosa_attr: The name of the attribute we are setting.
# :type _cosa_attr: desc
# :param _cosa_value: The value we are setting the attribute to.
# :type _cosa_value: str
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
#
# If CMakePP is run in debug mode this function will ensure that the function
# has been provided the correct number and types of arguments. This error check
# is only done if CMakePP is run in debug mode.
#]]
function(_cpp_object_set_attr _cosa_object _cosa_attr _cosa_value)
    cpp_assert_signature("${ARGV}" obj desc str)

    _cpp_object_get_attrs("${_cosa_object}" _cosa_attrs)
    cpp_map(SET "${_cosa_attrs}" "${_cosa_attr}" "${_cosa_value}")
endfunction()
