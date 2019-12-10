include_guard()
include(cmakepp_core/algorithm/contains)
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/types/implicitly_convertible)
include(cmakepp_core/utilities/return)

#[[[ Determines if an overload can be called with the provided types.
#
# This function compares two arrays of types. The first array of types,
# ``_cfim_sig``, is assumed to be the types constituting a function's overload.
# The second array of types ``_cfim_types`` is assumed to be an array
# corresponding to the types of the objects we are attempting to pass into the
# overload. Under these assumptions, this function then determines whether it is
# valid to call a function with signature ``_cfim_sig`` using arguments of types
# ``_cfim_types``. This actual function does not enforce any preexisting
# conditions on either array of types (*i.e.*, ``_cfim_sig`` does not need to be
# an actual overload nor does ``_cfim_types`` need to correspond to actual
# objects).
#
# :param _cfim_result: Name to use for identifier holding the result.
# :type _cfim_result: desc
# :param _cfim_sig: An array such that the i-th element is the type of the i-th
#                   positional argument in the overload. For variadic overloads
#                   the last type will be ``args``.
# :type _cfim_sig: array
# :param _cfim_types: The types of the arguments being passed to ``_cfim_sig``.
# :type _cfim_types: array
# :returns: ``_cfim_result`` will be set to ``TRUE`` if it is possible to call
#           an overload of ``_cfim_sig`` using arguments of types
#           ``_cfim_types`` and ``FALSE`` otherwise.
# :rtype: bool*
#]]
function(_cpp_function_is_match _cfim_result _cfim_sig _cfim_types)
    cpp_assert_signature("${ARGV}" desc array array)

    # Is overload variadic? If not just compare arrays.
    cpp_contains(_cfim_is_variadic "args" "${_cfim_sig}")
    if(NOT "${_cfim_is_variadic}")
        cpp_equal("${_cfim_result}" "${_cfim_sig}" "${_cfim_types}")
        cpp_return("${_cfim_result}")
    endif()

    # Get number of required positional arguments and length of types
    cpp_array(END _cfim_sig_n "${_cfim_sig}")
    cpp_array(LENGTH _cfim_types_n "${_cfim_types}")

    # If _cfim_sig_n is 0 then the signature is fxn(*args) and everything works
    if("${_cfim_sig_n}" EQUAL 0)
        set("${_cfim_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # Types needs to minimally have enough arguments for the required positions
    if("${_cfim_types_n}" LESS "${_cfim_sig_n}")
        set("${_cfim_result}" FALSE PARENT_SCOPE)
        return()
    endif()

    # We assume "args" is the last type in sig, don't want to look at it
    math(EXPR _cfim_sig_n "${_cfim_sig_n} - 1")

    # Loop over types making sure they're compatible
    foreach(_cfim_arg_i RANGE "${_cfim_sig_n}")
        cpp_array(GET _cfim_lhs "${_cfim_sig}" "${_cfim_arg_i}")
        cpp_array(GET _cfim_rhs "${_cfim_types}" "${_cfim_arg_i}")
        cpp_implicitly_convertible(_cfim_good "${_cfim_lhs}" "${_cfim_rhs}")
        if(NOT "${_cfim_good}")
            set("${_cfim_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    endforeach()

    set("${_cfim_result}" TRUE PARENT_SCOPE)
endfunction()
