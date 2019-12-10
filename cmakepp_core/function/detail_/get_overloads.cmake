include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/utilities/get_global)
include(cmakepp_core/utilities/set_global)

#[[[ Retrieves the overloads which have been declared for this function.
#
# For each function CMakePP stores a map of all overloads that have ever been
# declared for a function. At a given time these overloads may or may not be in
# scope. The map reduces the space of possible overloads for us.
#
# :param _cfgo_fxn: The name of the function we are retrieving the overloads
#                   for.
# :type _cfgo_fxn: desc
# :param _cfgo_overloads: Name to use for variable which will hold the result.
# :type _cfgo_overloads: desc
# :returns: ``_cfgo_overloads`` will be set to a map of overloads. The resulting
#           map is such that keys are ``array`` of types and values are mangled
#           names.
# :rtype: map*
#]]
function(_cpp_function_get_overloads _cfgo_fxn _cfgo_overloads)
    cpp_assert_signature("${ARGV}" desc desc)

    # If this fxn already has overloads they will be stored in this variable
    cpp_get_global("${_cfgo_overloads}"  "${_cfgo_fxn}_overloads")

    # If the contents of the variable is a map assume its a map of overloads
    cpp_get_type(_cfgo_type "${${_cfgo_overloads}}")
    if("${_cfgo_type}" STREQUAL "map")
        cpp_return("${_cfgo_overloads}")
        return()
    endif()

    # If we get here then the map doesn't exist so make it and return it
    cpp_map(CTOR "${_cfgo_overloads}")
    cpp_set_global("${_cfgo_fxn}_overloads" "${${_cfgo_overloads}}")
    cpp_return("${_cfgo_overloads}")
endfunction()
