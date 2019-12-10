include_guard()
include(cmakepp_core/function/detail_/add_overload)

## The path to the wrapper function template
set(__CPP_FUNCTION_INPUT_FILE__ ${CMAKE_CURRENT_LIST_DIR}/function.cmake.in)

#[[[ Public API for declaring a CMakePP free function.
#
# The ``cpp_function`` function is the public API for declaring CMakePP free
# functions. CMakePP free functions wrap native CMake functions and impart
# strong typing to the function. Users declare their CMakePP free function using
# the ``cpp_function`` function and then use the result as the name of a native
# CMake function. See Example Usage for more details.
#
# :param _cf_name: The name of the CMakePP free function being defined.
# :type _cf_name: desc
# :param *args: The types of the inputs to the function.
# :returns: ``_cf_name`` will be set to the mangled name you should use for
#           the CMake function which implements your CMakePP free function.
# :rtype: desc*
# :var __CPP_FUNCTION_INPUT_FILE__: Used to retrieve the path to the wrapper
#                                   function template file. This variable is set
#                                   automatically by including
#                                   ``function.cmake`` and users need only
#                                   ensure they do not overwrite this variable.
#
# .. note::
#
#    ``cpp_function`` is actually a macro to avoid creating a new scope. This
#    is essential to ensure ``cpp_function`` can ``include`` the wrapper
#    function in the current scope. If ``cpp_function`` was a function then the
#    user would have to remember to include the wrapper function.
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will ensure that the name used
# for the function is of type ``desc``. Additionally, this function will ensure
# that the variadic arguments provided to this function are valid CMakePP types.
#
# Example Usage
# =============
#
# To declare a CMakePP free function which takes an integer and a bool the code
# is:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/function/function)
#    cpp_function(my_fxn int bool)
#    function(${my_fxn} the_int the_bool)
#        message("Provided integer: ${the_int} and boolean: ${the_bool}")
#    endfunction()
#
#    my_fxn(2 TRUE)
#
# The first line includes the machinery for declaring and defining CMakePP
# free functions. The second line declares a CMakePP free function named
# ``my_fxn`` which has two positional arguments. The next three lines of the
# snippet define a normal CMake function ``${my_fxn}``, which takes two
# positional arguments called ``the_int`` and ``the_bool``. ``${my_fxn}`` prints
# the values of the input. The last line demonstrates how to call the resulting
# function.
#]]
macro(cpp_function _cf_name)
    function(cpp_function_write_wrapper _cfww_name)
        set(_cfww_name "${_cfww_name}")
        configure_file(
            "${__CPP_FUNCTION_INPUT_FILE__}"
            "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxns/${_cfww_name}.cmake" @ONLY
        )
    endfunction()
    cpp_function_write_wrapper("${_cf_name}")
    _cpp_function_add_overload("${_cf_name}" ${ARGN})
    include("${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxns/${_cf_name}.cmake")
endmacro()
