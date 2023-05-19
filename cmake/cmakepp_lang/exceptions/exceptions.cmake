# Copyright 2023 CMakePP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#[[[ @module
# Defines the public API for CMakePPLang exception handling.
#]]

include_guard()

include(cmakepp_lang/map/map)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/call_fxn)

# Create the global exception handlers map
cpp_map(CTOR _exception_handlers)
cpp_set_global("_CPP_EXCEPTION_HANDLERS_" "${_exception_handlers}")

#[[[
# Declares an exception handler function
#
# This command enables users to declare a handler function for specified
# exception types. Subsequent calls to the ``cpp_raise`` command for those
# exception types will call the handler function declared for that type.
#
# :param \*args: The exception types to declare handlers for.
# :returns: each arg will be set to the mangled name of the declared
#           exception handler for that exception type.
# :rtype: desc
# 
# Example Usage
# =============
# 
# .. code-block:: cmake
# 
#    cpp_catch(my_exec_type_1 my_exec_type_2)
#    function("${my_exec_type_1}" message)
#       message("In my_exception_handler for exception type: my_exec_type_1")
#       message("Exception details: ${message}")
#    endfunction()
#    function("${my_exec_type_2}" message)
#       message("In my_exception_handler for exception type: my_exec_type_2")
#       message("Exception details: ${message}")
#    endfunction()
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with one or more desc arguments.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(cpp_catch)
    cpp_assert_signature("${ARGV}" desc)

    # If debug, ensure that at least one arg was passed and each arg is a desc
    if(CMAKEPP_LANG_DEBUG_MODE)
        if(NOT ${ARGC} GREATER_EQUAL 1)
            message(FATAL_ERROR "This function expects at least one argument")
        endif()

        foreach(_c_arg_i ${ARGN})
            cpp_assert_type("desc" "${_c_arg_i}")
        endforeach()
    endif()

    foreach(_c_exce_type_i ${ARGN})
        # Get the map of exception handlers
        cpp_get_global(_c_exception_handlers "_CPP_EXCEPTION_HANDLERS_")

        # Create unique function name
        cpp_unique_id("${_c_exce_type_i}")

        # Check if this key already exists in the map
        cpp_map(HAS_KEY "${_c_exception_handlers}" _c_has_key "${_c_exce_type_i}")
        if(_c_has_key)
            # If it exists, append this handler to the list of handlers
            cpp_map(APPEND "${_c_exception_handlers}"
                    "${_c_exce_type_i}" "${${_c_exce_type_i}}")
        else()
            # If it doesn't, add this handler
            cpp_map(SET "${_c_exception_handlers}"
                    "${_c_exce_type_i}" "${${_c_exce_type_i}}")
        endif()

        # Update map of exception handlers for this exception type
        cpp_set_global("_CPP_EXCEPTION_HANDLERS_" "${_exception_handlers}")

        # Return the function name
        set("${_c_exce_type_i}" "${${_c_exce_type_i}}" PARENT_SCOPE)
    endforeach()
endfunction()

#[[[
# Raises an exception.
# 
# This command raises an exception of the specified type. This will call
# the exception handler for that type if it is declared.
#
# :param exec_type: The exception type to be raised
# :type exec_type: desc
# :param exec_message: The exception message
# :type exec_message: optional desc
# 
# Example Usage
# =============
#
# .. code-block:: cmake
#
#    cpp_raise(my_exec_type)
#
# An exception message may be optionally added via calling with additonal parameters.
# 
# .. code-block:: cmake
#
#    cpp_raise(my_exec_type "My exception message")
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with at least one argument and that
# the argument is of type desc.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(cpp_raise _r_exce_type)
    cpp_assert_signature("${ARGV}" desc args)

    # Get the map of exception handlers and attempt to get the handler for
    # this type from the map
    cpp_get_global(_r_exception_handlers "_CPP_EXCEPTION_HANDLERS_")
    cpp_map(GET "${_r_exception_handlers}" _r_handlers_list "${_r_exce_type}")
    if("${_r_handlers_list}" STREQUAL "")
        # If the list is empty, check if the ALL_EXCEPTIONS handler was set, if
        # so, use it. Otherwise throw an error indicating an uncaught exception
        cpp_map(GET "${_r_exception_handlers}" _r_handlers_list "ALL_EXCEPTIONS")
        if("${_r_handlers_list}" STREQUAL "")
            message(FATAL_ERROR "Uncaught ${_r_exce_type} exception: ${ARGN}")
        else()
            list(GET _r_handlers_list -1 _r_fxn_2_call)
            cpp_call_fxn("${_r_fxn_2_call}" "${_r_exce_type}" "${ARGN}")
        endif()
    else()
        # If the list is not empty get last / deepest handler and call it
        list(GET _r_handlers_list -1 _r_fxn_2_call)
        cpp_call_fxn("${_r_fxn_2_call}" "${ARGN}")
    endif()
endfunction()

#[[[
# Denotes that we are starting a try block.
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

#[[[
# Ends a try-catch block
#
# This command ends a try-catch block and removes the exception handlers for the
# specified types.
#
# :param \*args: The exception types to declare handlers for.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Example Usage
# =============
#
# .. code-block::
# 
#    cpp_end_try_catch(my_exce_type)
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with one or more desc arguments.
#]]
function(cpp_end_try_catch)
    # If debug, ensure that at least one arg was passed and each arg is a desc
    if(CMAKEPP_LANG_DEBUG_MODE)
        if(NOT ${ARGC} GREATER_EQUAL 1)
            message(FATAL_ERROR "This function expects at least one argument")
        endif()

        foreach(_etc_arg_i ${ARGN})
            cpp_assert_type("desc" "${_etc_arg_i}")
        endforeach()
    endif()

    foreach(_etc_exce_type_i ${ARGN})
        # Get the handlers for this type
        cpp_get_global(_etc_exception_handlers "_CPP_EXCEPTION_HANDLERS_")
        cpp_map(GET "${_etc_exception_handlers}" _etc_handlers_list "${_etc_exce_type_i}")

        # Remove the last handler for this exception type from the list
        list(LENGTH _etc_handlers_list _etc_len)
        math(EXPR _etc_len_sub_1 "${_etc_len} - 1")
        list(SUBLIST _etc_handlers_list 0 "${_etc_len_sub_1}" _etc_new_handlers_list)

        # Update the list of handlers for this type
        cpp_map(SET "${_etc_exception_handlers}" "${_etc_exce_type_i}" "${_etc_new_handlers_list}")
    endforeach()
endfunction()
