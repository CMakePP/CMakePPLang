include_guard()

# Create the global exception handlers map
cpp_map(CTOR _exception_handlers)
cpp_set_global("_CPP_EXCEPTION_HANDLERS_" "${_exception_handlers}")

#
function(cpp_catch _c_name _c_exec_type)
    cpp_assert_signature("${ARGV}" desc desc)

    # Get the map of exception handlers
    cpp_get_global(_c_exception_handlers "_CPP_EXCEPTION_HANDLERS_")

    # Create unique function name
    cpp_unique_id("${_c_name}")

    # Update map of exception handlers for this exception type
    cpp_map(SET "${_c_exception_handlers}" "${_c_exec_type}" "${${_c_name}}")
    cpp_set_global("_CPP_EXCEPTION_HANDLERS_" "${_exception_handlers}")

    # Return the function name
    cpp_return("${_c_name}")
endfunction()

#
function(cpp_raise _r_exec_type)
    # Check that we're within a try block

    # Get the map of exception handlers and attempt to get the handler for
    # this type from the map
    cpp_get_global(_r_exception_handlers "_CPP_EXCEPTION_HANDLERS_")
    cpp_map(GET "${_r_exception_handlers}" _r_fxn_2_call "${_r_exec_type}")

    # Call the function if its found, else throw an error
    if("${_r_fxn_2_call}" STREQUAL "")
        message(FATAL_ERROR "No exception handler for that type")
    else()
        cpp_call_fxn("${_r_fxn_2_call}" "${_r_exec_type}" "${ARGN}")
    endif()
endfunction()

macro(cpp_try)
    # set count indicating that we're within another try
endmacro()


macro(cpp_end_try_catch)
    # decrement count indicating that we've left a try block
endmacro()
