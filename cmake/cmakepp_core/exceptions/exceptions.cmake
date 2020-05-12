include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/global)
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

    # Check if an exception handler already exists for this type, if so
    # throw an error
    cpp_map(HAS_KEY "${_c_exception_handlers}" _c_has_key "${_c_exec_type}")
    if(_c_has_key)
        message(FATAL_ERROR "A handler is already set for this exception type")
    endif()

    # Create unique function name
    cpp_unique_id("${_c_exec_type}")

    # Update map of exception handlers for this exception type
    cpp_map(SET "${_c_exception_handlers}" "${_c_exec_type}" "${${_c_exec_type}}")
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
    cpp_map(GET "${_r_exception_handlers}" _r_fxn_2_call "${_r_exec_type}")

    # Call the function if its found, else throw an error
    if("${_r_fxn_2_call}" STREQUAL "")
        message(FATAL_ERROR "No exception handler for exception type ${_r_exec_type}")
    else()
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

    # Remove the handler for this exception type
    cpp_get_global(_etc_exception_handlers "_CPP_EXCEPTION_HANDLERS_")
    cpp_map(SET "${_etc_exception_handlers}" "${_etc_exec_type}" "")
endfunction()
