include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/call_fxn)

# Create the global exception handlers map
cpp_map(CTOR _exception_handlers)
cpp_set_global("_CPP_EXCEPTION_HANDLERS_" "${_exception_handlers}")

#[[[ Declares an exception handler function
#
# This command enables users to declare a handler function for a specified
# exception type. Subsequent calls to the ``cpp_raise`` command for that
# exception type will call the handler function declared with this command.
#
# Example usage:
#
# cpp_catch(my_exec_type)
# function("${my_exec_type}" message)
#    message("In my_exception_handler for exception type: my_exec_type")
#    message("Exception details: ${message}")
# endfunction()
#
# :param _c_exec_type: The exception type to be handled
# :type _c_exec_type: desc
# :returns: ``_c_exec_type`` will be set to the mangled name of the declared
#            exception handler.
# :rtype: desc
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with at least one argument and that
# the argument is of type desc.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_catch _c_exec_type)
    cpp_assert_signature("${ARGV}" desc)

    # Get the map of exception handlers
    cpp_get_global(_c_exception_handlers "_CPP_EXCEPTION_HANDLERS_")

    # Create unique function name
    cpp_unique_id("${_c_exec_type}")

    # Check if this key already exists in the map
    cpp_map(HAS_KEY "${_c_exception_handlers}" _c_has_key "${_c_exec_type}")
    if(_c_has_key)
        # If it exists, append this handler to the list of handlers
        cpp_map(APPEND "${_c_exception_handlers}"
                "${_c_exec_type}" "${${_c_exec_type}}")
    else()
        # If it doesn't, add this handler
        cpp_map(SET "${_c_exception_handlers}"
                "${_c_exec_type}" "${${_c_exec_type}}")
    endif()

    # Update map of exception handlers for this exception type
    cpp_set_global("_CPP_EXCEPTION_HANDLERS_" "${_exception_handlers}")

    # Return the function name
    cpp_return("${_c_exec_type}")
endfunction()

#[[[ Raises an exception
# This command raises an exception of the specified type. This will call
# the exception handler for that type if it is declared. command.
#
# Example usage:
#
# cpp_raise(my_exec_type)
#
# :param _r_exec_type: The exception type to be raised
# :type _r_exec_type: desc
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with at least one argument and that
# the argument is of type desc.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_raise _r_exec_type)
    cpp_assert_signature("${ARGV}" desc)

    # Get the map of exception handlers and attempt to get the handler for
    # this type from the map
    cpp_get_global(_r_exception_handlers "_CPP_EXCEPTION_HANDLERS_")
    cpp_map(GET "${_r_exception_handlers}" _r_handlers_list "${_r_exec_type}")

    # If the list is empty, throw an error, otherwise get the last handler
    # and call it
    if("${_r_handlers_list}" STREQUAL "")
        message(FATAL_ERROR "Uncaught ${_r_exec_type} exception: ${ARGV}")
    else()
        list(GET _r_handlers_list -1 _r_fxn_2_call)
        cpp_call_fxn("${_r_fxn_2_call}" "${ARGN}")
    endif()
endfunction()

#[[[ Denotes that we are starting a try block.
#
# This function is a no-op that completes the fencing associated with a try
# block.
#
# Error Checking
# ==============
#
# None. This function is a no-op and has no errors to check for.
#]]
macro(cpp_try)
endmacro()

#[[[ Ends a try-catch block
#
# This command ends a try-catch block and removes the exception handler for the
# specified type.
#
# :param _etc_exec_type: The exception type to be raised
# :type _etc_exec_type: desc
#
# Example usage:
#
# cpp_end_try_catch(my_exec_type)
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with at least one argument and that
# the argument is of type desc.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_end_try_catch _etc_exec_type)
    cpp_assert_signature("${ARGV}" desc)

    # Get the handlers for this type
    cpp_get_global(_etc_exception_handlers "_CPP_EXCEPTION_HANDLERS_")
    cpp_map(GET "${_etc_exception_handlers}" _etc_handlers_list "${_etc_exec_type}")

    # Remove the last handler for this exception type from the list
    list(LENGTH _etc_handlers_list _etc_len)
    math(EXPR _etc_len_sub_1 "${_etc_len} - 1")
    list(SUBLIST _etc_handlers_list 0 "${_etc_len_sub_1}" _etc_new_handlers_list)

    # Update the list of handlers for this type
    cpp_map(SET "${_etc_exception_handlers}" "${_etc_exec_type}" "${_etc_new_handlers_list}")
endfunction()
