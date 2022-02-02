include_guard()
include(cmakepp_lang/class/detail_/bases)
include(cmakepp_lang/object/object)
include(cmakepp_lang/types/cmakepp_type)
include(cmakepp_lang/class/set_kwargs_attrs)

#[[[ Finds the proper CTOR function to call for the given object and arguments.
#
# This function checks if the CTOR call was a KWARGS call, a regular CTOR call
# with arguments, or CTOR with no arguments. If it was a KWARGS call, the
# _cpp_set_kwargs_attrs is called. If it was a CTOR call with arguments, it
# attempts to find the CTOR that matches the call signature and call it. If
# no CTOR is called, an error is thrown. If it is an CTOR call with no arguments
# it attempts to find a CTOR with a matching signature but does not throw an
# error if none is found.
#
# :param _fc_this: The object being constructed.
# :type _fc_this: obj
# :param _fc_type: The type of the object being constructed.
# :type _fc_type: obj
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will ensure that it was
# called with an obj and a type as the first two parameters.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Additionally, this function will always throw an error if a CTOR call with
# arguments was made an no CTOR can be found matching the signature of the call.
#]]
function(_cpp_find_ctor _fc_this _fc_type)
    cpp_assert_signature("${ARGV}" obj class args)

    # Determine if this is KWARGS CTOR call or a regular CTOR call
    if("${ARGV2}" STREQUAL "KWARGS")
        # Handle KWARGS CTOR call
        list(SUBLIST ARGN 1 -1 _fc_kwargs)
        _cpp_set_kwargs_attrs("${_fc_this}" "${_fc_kwargs}")
    else()
        # Handle regular CTOR call, make the signature of the CTOR call made
        set(_fc_sig "ctor")
        list(APPEND _fc_sig "desc")
        foreach(_fc_arg_i ${ARGN})
            cpp_type_of(_fc_type_i "${_fc_arg_i}")
            cpp_sanitize_string(_fc_nice_type_i "${_fc_type_i}")
            list(APPEND _fc_sig "${_fc_nice_type_i}")
        endforeach()

        # Create a dummy object of the type we're trying to find a CTOR for
        cpp_get_global(_fc_state "${_fc_type}__state")
        _cpp_object_copy("${_fc_state}" _fc_subobj)

        # Attempt to find a CTOR function matching that signature
        _cpp_object_get_symbol("${_fc_subobj}" _fc_symbol _fc_sig)
        if(_fc_symbol)
            # CTOR found, call it
            cpp_call_fxn("${_fc_symbol}" "${_fc_this}" ${ARGN})
        else()
            # No CTOR was found, check if any args other than the instance handle
            # were passed in. If they were, throw error
            list(LENGTH ARGN _fc_argn_length)
            if(_fc_argn_length GREATER 0)
                # If additional arguments were passed in, throw error
                cpp_print_fxn_sig(_fc_str_sig ${_fc_sig})
                message(
                    FATAL_ERROR
                    "No suitable overload of ${_fc_str_sig} for type ${_fc_type}"
                )
            endif()
        endif()
    endif()
endfunction()
