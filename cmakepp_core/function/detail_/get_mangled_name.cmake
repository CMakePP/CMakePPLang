include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/function/detail_/get_overloads)
include(cmakepp_core/function/detail_/is_match)
include(cmakepp_core/map/map)
include(cmakepp_core/types/get_types)
include(cmakepp_core/utilities/print_fxn_sig)
include(cmakepp_core/utilities/return)

#[[[ Given a set of inputs, returns the mangled name of the overload to call.
#
# This function is meant to be called from ``_cpp_function_call_overload`` to
# ensure that an overload exists for the provided arguments and to retrieve the
# mangled name of that overload.
#
# :param _cfgmn_fxn: The name of the function we are calling.
# :type _cfgmn_fxn: desc
# :param _cfgmn_result: Name for the variable which will hold the result.
# :type _cfgmn_result: desc
# :param *args: The inputs the function is being called with.
# :returns: ``_cfgmn_result`` will be set to the mangled name of the overload
#           to call.
# :rtype: desc*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# This function will raise an error if no suitable overload of ``_cfgmn_fxn``
# has been registered, or is in scope. This error check is always performed.
# Additionally, if CMakePP is in debug mode this function will ensure that the
# ``_cfgmn_fxn`` and ``cfgmn_result`` are of the correct types. The type checks
# are only done in debug mode.
#]]
function(_cpp_function_get_mangled_name _cfgmn_fxn _cfgmn_result)
    cpp_assert_signature("${ARGV}" desc desc args)
    cpp_get_types(_cfgmn_types ${ARGN})

    _cpp_function_get_overloads("${_cfgmn_fxn}" _cfgmn_overloads)
    cpp_map(KEYS _cfgmn_keys "${_cfgmn_overloads}")
    foreach(_cfgmn_key ${_cfgmn_keys})
        _cpp_function_is_match(_cfgmn_match "${_cfgmn_key}" "${_cfgmn_types}")
        if("${_cfgmn_match}")
            cpp_map(
                GET "${_cfgmn_result}" "${_cfgmn_overloads}" "${_cfgmn_key}"
            )
            if(COMMAND "${${_cfgmn_result}}")
                cpp_return("${_cfgmn_result}")
            endif()
        endif()
    endforeach()

    cpp_array(AS_LIST _cfgmn_types "${_cfgmn_types}")
    cpp_print_fxn_sig(_cfgmn_sig "${_cfgmn_fxn}" ${_cfgmn_types})
    message(
        FATAL_ERROR "Overload ${_cfgmn_sig} does not exist or is not in scope."
    )
endfunction()
