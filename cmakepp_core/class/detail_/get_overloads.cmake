include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/get_fxns)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/return)

#[[[ Code factorization for retrieving the array of overloads for a member
#    function.
#
# This code wraps the process of returning the array of registered overloads for
# a particular class's member function. An error will be raised if the class has
# not been registered or if the function has not been registered.
#
# :param _ccgo_result: Name to use for the variable which will hold the result.
# :type _ccgo_result: desc
# :param _ccgo_type: Class whose member function overloads are being retrieved
# :type _ccgo_type: desc
# :param _ccgo_fxn_name: Name of the member function whose overloads are being
#                        retrieved.
# :type _ccgo_fxn_name: desc
# :returns: ``_ccgo_result`` will be set to the array of overloads, which have
#           already been registered for this class's particular member function.
# :rtype: array*
#]]
function(_cpp_class_get_overloads _ccgo_result _ccgo_type _ccgo_fxn_name)
    cpp_assert_signature("${ARGV}" desc desc desc)

    # This line will fail if we have not registered the type
    _cpp_class_get_fxns(_ccgo_fxns "${_ccgo_type}")

    cpp_map(HAS_KEY _ccgo_has_fxn "${_ccgo_fxns}" "${_ccgo_fxn_name}")
    cpp_assert("${_ccgo_has_fxn}" "${_ccgo_fxn_name} has been registered")

    cpp_map(GET "${_ccgo_result}" "${_ccgo_fxns}" "${_ccgo_fxn_name}")
    cpp_return("${_ccgo_result}")
endfunction()
