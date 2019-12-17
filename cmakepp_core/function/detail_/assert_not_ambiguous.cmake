include_guard()
include(cmakepp_core/overload/overload)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/print_fxn_sig)

function(_cpp_function_assert_not_ambiguous _fana_this _fana_overload)

    cpp_enable_if_debug()
    cpp_overload(IS_VARIADIC "${_fana_overload}" _fana_is_variadic)
    cpp_overload(N_REQUIRED "${_fana_overload}" _fana_n)
    cpp_overload(REQUIRED_ARGS "${_fana_overload}" _fana_args)

    cpp_object(GET_ATTR "${_fana_this}" _fana_overloads "overloads")
    foreach(_fana_overload_i ${_fana_overloads})
        cpp_overload(IS_VARIADIC "${_fana_overload_i}" _fana_i_is_variadic)
        cpp_overload(N_REQUIRED "${_fana_overload_i}" _fana_m)
        cpp_overload(REQUIRED_ARGS "${_fana_overload_i}" _fana_i_args)

        set(_fana_bad FALSE)
        if("${_fana_is_variadic}" AND "${_fana_i_is_variadic}")
            if("${_fana_n}" LESS_EQUAL "${_fana_m}")
                cpp_overload(
                    IS_MATCH "${_fana_overload}" _fana_bad ${_fana_i_args}
                )
            else()
                cpp_overload(
                    IS_MATCH "${_fana_overload_i}" _fana_bad ${_fana_args}
                )
            endif()
        elseif("${_fana_is_variadic}")
            if("${_fana_n}" LESS_EQUAL "${_fana_m}")
                cpp_overload(
                        IS_MATCH "${_fana_overload}" _fana_bad ${_fana_i_args}
                )
            endif()
        elseif("${_fana_i_is_variadic}")
            if("${_fana_m}" LESS_EQUAL "${_fana_n}")
                cpp_overload(
                    IS_MATCH "${_fana_overload_i}" _fana_bad ${_fana_args}
                )
            endif()
        else()
            cpp_overload(IS_MATCH "${_fana_overload}" _fana_bad ${_fana_i_args})
        endif()

        if("${_fana_bad}")
            cpp_object(GET_ATTR "${_fana_this}" _fana_name "name")
            cpp_overload(ARGS "${_fana_overload}" _fana_args)
            cpp_overload(ARGS "${_fana_overload_i}" _fana_i_args)
            cpp_print_fxn_sig(_fana_input "${_fana_name}" ${_fana_args})
            cpp_print_fxn_sig(_fana_other "${_fana_name}" ${_fana_i_args})
            message(
                FATAL_ERROR "${_fana_input} is ambiguous with ${_fana_other}"
            )
        endif()
    endforeach()
endfunction()
