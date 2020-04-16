include_guard()
include(cmakepp_core/utilities/unique_id)

#[[[ Performs most of the work for dynamically calling a function.
#
# ``cpp_call_fxn`` is a macro to avoid needing to forward returns. In
# order to actually call the function we need to write the call to disk. This
# involves setting a few variables, so in order to avoid contaminating the
# caller's namespace we wrap this part of ``cpp_call_fxn`` in this
# function, ``_cpp_call_fxn_guts``. ``_cpp_call_fxn_guts`` is not intended to be
# called from outside of ``cpp_call_fxn``.
#
# :param _cfg_fxn2call: The name of the function we are calling.
# :type _cfg_fxn2call: desc
# :param *args: The arguments to forward to the function.
#]]
function(_cpp_call_fxn_guts _cfg_fxn2call _cfg_result)
    # Create a new arg list that is a copy of ARGN except all args of type desc
    # are surrounded with double quotes
    set(_cfg_args_list "")

    # Loop over all args
    foreach(_cfg_current_arg ${ARGN})
        # Get the type of the arg
        cpp_type_of(_cfg_curr_arg_type "${_cfg_current_arg}")

        # If the arg is of type desc, surround it with double quotes,
        # Leave all other arguments the same
        if("${_cfg_curr_arg_type}" STREQUAL "desc")
            string(APPEND _cfg_args_list " \"${_cfg_current_arg}\"")
        else()
            string(APPEND _cfg_args_list " ${_cfg_current_arg}")
        endif()
    endforeach()

    # Write a .cmake file that calls the function
    cpp_unique_id(_cfg_uuid)
    set(_cfg_file "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxn_calls")
    set(_cfg_file "${_cfg_file}/${_cfg_fxn2call}_${_cfg_uuid}.cmake")
    file(WRITE "${_cfg_file}" "${_cfg_fxn2call}(${_cfg_args_list})")
    set("${_cfg_result}" "${_cfg_file}" PARENT_SCOPE)
endfunction()

#[[[ Calls a function who's name is provided at runtime.
#
# CMake does not allow you to dynamically determine the name of a function. For
# example one can NOT do ``${name_of_fxn}(<args...>)`` or any other variation
# which retrieves part of the function's name from a variable. The ``cpp_call``
# macro allows us to circumvent this limitation at the cost of some I/O.
#
# :param _ccf_fxn2call: The name of the function to call.
# :type _ccf_fxn2call: desc
# :param *args: The arguments to forward to the function.
#
# .. note::
#
#    ``cpp_call_fxn`` is a macro to avoid creating a new scope. If a new scope
#    was created it would be necessary to forward returns, which would
#    significantly complicate the implementation.
#]]
macro(cpp_call_fxn _cf_fxn2call)
    # Create a .cmake file that calls the function with the provided args
    _cpp_call_fxn_guts("${_cf_fxn2call}" __cpp_call_fxn_file ${ARGN})
    # Include that .cmake file
    include("${__cpp_call_fxn_file}")
endmacro()
