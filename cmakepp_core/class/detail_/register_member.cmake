include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/get_fxns)
include(cmakepp_core/map/map)

#[[[ Registers a member function with the class registry.
#
# Associated with each member function of a class is an array filled with the
# mangled overloads available. This function will create that array if it does
# not exist for the provided function. If the array already exists, this
# operation is a null op. This function will raise an error if the class
# declaration has not been  started prior to this call.
#
# :param _ccrm_type: The name of the class we are adding the function to.
# :type _ccrm_type: desc
# :param _ccrm_fxn_name: The human-readable name of the function we are adding
#                        to the class.
# :type _ccrm_fxn_name: desc
#]]
function(_cpp_class_register_member _ccrm_type _ccrm_fxn_name)
    cpp_assert_signature("${ARGV}" desc desc)
    _cpp_class_get_fxns(_ccrm_fxns "${_ccrm_type}")
    cpp_map(HAS_KEY _ccrm_has_fxn "${_ccrm_fxns}" "${_ccrm_fxn_name}")
    if(NOT "${_ccrm_has_fxn}")
        cpp_array(CTOR _ccrm_overloads)
        cpp_map(SET "${_ccrm_fxns}" "${_ccrm_fxn_name}" "${_ccrm_overloads}")
    endif()
endfunction()
