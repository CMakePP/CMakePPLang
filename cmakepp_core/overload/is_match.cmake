include_guard()
include(cmakepp_core/overload/is_variadic)
include(cmakepp_core/overload/n_required)

#[[[ Determines if the overload can be called with arguments of the given types.
#
# :param _oim_this: The overload instance we want to call.
# :type _oim_this: overload
# :param _oim_result: Name for variable which will hold the result.
# :type _oim_result: desc
# :returns: ``_oim_result`` will be set to ``TRUE`` if this overload can be
#           called with arguments of the provided tyeps and ``FALSE`` otherwise.
# :rtype: bool
#]]
function(cpp_overload_is_match _oim_this _oim_result)

    # Get this overload's traits
    cpp_overload_n_required("${_oim_this}" _oim_n_required)
    cpp_overload_is_variadic("${_oim_this}" _oim_is_variadic)

    # Put the input types into a list and get the length
    set(_oim_types ${ARGN})
    list(LENGTH _oim_types _oim_n_types)

    # Were we provided enough arguments?
    if("${_oim_is_variadic}")
        if("${_oim_n_required}" EQUAL 0) # Pure variadic, any number is fine
            set("${_oim_result}" TRUE PARENT_SCOPE)
            return()
        elseif("${_oim_n_types}" LESS "${_oim_n_required}")
            # Provided less than the required number of arguments
            set("${_oim_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    elseif(NOT "${_oim_n_types}" EQUAL "${_oim_n_required}")
        # Non-variadic and had different number of arguments
        set("${_oim_result}" FALSE PARENT_SCOPE)
        return()
    elseif("${_oim_n_types}" EQUAL 0) # Non-variadic, both have 0 args
        set("${_oim_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # Get the types of the arguments to this overload
    cpp_object(GET_ATTR "${_oim_this}" _oim_args "args")

    # Loop termination condition (we have at least 1 arg at this point)
    math(EXPR _oim_end "${_oim_n_required} - 1")

    # Loop over types ensuring they are implicitly convertible
    foreach(_oim_i RANGE "${_oim_end}")
        list(GET _oim_types "${_oim_i}" _oim_type_i)
        list(GET _oim_args "${_oim_i}" _oim_arg_i)
        cpp_implicitly_convertible(
            _oim_is_good "${_oim_type_i}" "${_oim_arg_i}"
        )

        # If they aren't implicitly convertible early abort
        if(NOT "${_oim_is_good}")
            set("${_oim_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    endforeach()

    # If we get here it means the overload can be called with the provided types
    set("${_oim_result}" TRUE PARENT_SCOPE)
endfunction()
