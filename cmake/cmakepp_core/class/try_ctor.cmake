include_guard()
include(cmakepp_core/class/detail_/bases)
include(cmakepp_core/object/object)
include(cmakepp_core/types/cmakepp_type)

# TODO docstring
# Attempt to find a CTOR for the instance that matches the call signature
# If one isn't found, don't complain
function(cpp_try_ctor _tc_this _tc_type)
    # cpp_assert_signature("${ARGV}" class desc args)

    # Make the signature of the CTOR call made
    # (tuple with name of fxn and arg types) we want
    set(_tc_sig "ctor")
    list(APPEND _tc_sig "desc")
    foreach(_tc_arg_i ${ARGN})
        cpp_type_of(_tc_type_i "${_tc_arg_i}")
        cpp_sanitize_string(_tc_nice_type_i "${_tc_type_i}")
        list(APPEND _tc_sig "${_tc_nice_type_i}")
    endforeach()

    # Attempt to find a CTOR function matching that signature, if none is found
    # that is alright since the creation of the object has already happened
    _cpp_object_get_symbol("${_tc_this}" _tc_symbol _tc_sig)
    if(_tc_symbol)
        # CTOR found, call it
        cpp_call_fxn("${_tc_symbol}" "${_tc_this}" ${ARGN})
    else()
        # No CTOR was found, check if any args other than the instance handle
        # were passed in. If they were, throw error
        list(LENGTH ARGN _tc_argn_length)
        if(_tc_argn_length GREATER 0)
            # If additional arguments were passed in, throw error
            cpp_print_fxn_sig(_tc_str_sig ${_tc_sig})
            message(
                FATAL_ERROR
                "No suitable overload of ${_tc_str_sig} for type ${_tc_type}"
            )
        endif()
    endif()
endfunction()
