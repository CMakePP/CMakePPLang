include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Retrieves the most-derived type of an object.
#
# An object can only have one most-derived type. For all intents and purposes
# that most-derived type is "the type" of the object. This function wraps the
# process cof retrieving the most-derived type.
#
# :param _cogt_type: Name for the variable which will hold the result.
# :type _cogt_type: desc
# :param _cogt_object: The object we want the type of.
# :type _cogt_object: obj
# :returns: ``_cogt_type`` will be set to ``_cogt_object``'s type.
# :rtype: type*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is run in debug
#                               mode or not.
#
# If CMakePP is in debug mode this function will ensure that all arguments have
# the correct types and that no additional arguments have been provided. These
# error checks only occur if CMakePP is run in debug mode.
#]]
function(_cpp_object_get_type _cogt_type _cogt_object)
    cpp_assert_signature("${ARGV}" desc obj)

    get_property(_cogt_state GLOBAL PROPERTY "${_cogt_object}")
    cpp_map(GET _cogt_types "${_cogt_state}" "types")
    cpp_array(BACK "${_cogt_type}" "${_cogt_types}")
    cpp_return("${_cogt_type}")
endfunction()
