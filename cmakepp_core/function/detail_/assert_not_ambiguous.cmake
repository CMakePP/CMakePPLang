include_guard()
include(cmakepp_core/algorithm/contains)
include(cmakepp_core/array/array)
include(cmakepp_core/function/detail_/get_overloads)
include(cmakepp_core/function/detail_/is_match)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/print_fxn_sig)

#[[[ Asserts the provided overload is not ambiguous with any in scope overloads.
#
# We say two signatures are ambiguous if there exists a set of inputs which can
# be passed to both signatures. This function will loop over the known overloads
# for a function and ensure that the provided overload does not conflict with
# any of the existing (and in scope) overloads for the function. All error
# checks are only done if CMakePP is run in debug mode.
#
# :param _cfana_fxn: The function whose overloads should be considered.
# :type _cfana_fxn: desc
# :param *args: The types defining the overload we are considering.
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
#]]
function(_cpp_function_assert_not_ambiguous _cfana_fxn)
    cpp_enable_if_debug()
    cpp_assert_signature("${ARGV}" desc args)

    # Put types in an array, get the length, and determine if variadic
    cpp_array(CTOR _cfana_types ${ARGN})
    cpp_array(LENGTH _cfana_n "${_cfana_types}")
    cpp_array(END _cfana_n1 "${_cfana_types}")
    cpp_contains(_cfana_has_args "args" "${_cfana_types}")

    # Get the known overloads and loop over them
    _cpp_function_get_overloads("${_cfana_fxn}" _cfana_overloads)
    cpp_map(KEYS _cfana_sigs "${_cfana_overloads}")
    set(_cfana_match FALSE)
    foreach(_cfana_sig_i ${_cfana_sigs})

        # For i-th overload, get mangled name, length, and if variadic
        cpp_array(LENGTH _cfana_m "${_cfana_sig_i}")
        cpp_contains(_cfana_sig_has_args "args" "${_cfana_sig_i}")

        math(EXPR _cfana_m1 "${_cfana_m} + 1")

        # Condition 1 accounts for
        #   - sig and types are variadic with m <= n
        #   - Only sig is variadic with m<=n
        # Condition 2 gets:
        #   - Sig and types are variadic with n < m
        #     - All both variadic now complete
        #   - Only types is variadic with  n <= m+1
        #     - Note we screened out both variadic and m == n-1 in condition 1
        # Condition 3 gets the rest
        if("${_cfana_sig_has_args}" AND "${_cfana_m}" LESS_EQUAL "${_cfana_n}")
            _cpp_function_is_match(
                _cfana_match "${_cfana_sig_i}" "${_cfana_types}"
            )
        elseif("${_cfana_has_args}" AND "${_cfana_n}" LESS_EQUAL "${_cfana_m1}")
            _cpp_function_is_match(
                _cfana_match "${_cfana_types}" "${_cfana_sig_i}"
            )
        else()
            _cpp_function_is_match(
                _cfana_match "${_cfana_sig_i}" "${_cfana_types}"
            )
        endif()

        # If overload doesn't match try the next one
        if(NOT "${_cfana_match}")
            continue()
        endif()

        # Get mangled name and error if it's in scope
        cpp_map(GET _cfana_mangled_name "${_cfana_overloads}" "${_cfana_sig_i}")
        if(COMMAND "${_cfana_mangled_name}")
            cpp_print_fxn_sig(_cfana_new "${_cfana_fxn}" ${ARGN})
            cpp_array(AS_LIST _cfana_args "${_cfana_sig_i}")
            cpp_print_fxn_sig(_cfana_old "${_cfana_fxn}" ${_cfana_args})
            message(
                FATAL_ERROR
                "${_cfana_new} conflicts with existing overload ${_cfana_old}"
            )
        endif()
    endforeach()
endfunction()
