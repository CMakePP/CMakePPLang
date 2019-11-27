include_guard()
include(cmakepp_core/function/detail_/generate_wrapper)

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
# To declare a CMakePP free function which takes three integers the code is:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/function/function)
#    cpp_function(my_fxn int int int)
#    function(${my_fxn} int1 int2 int3)
#        # Do stuff with the integers
#    endfunction()
#
# The first line includes the machinery for declaring and defining CMakePP
# free functions. The second line declares a CMakePP free function named
# ``my_fxn`` which has three positional arguments, each of which is an integer.
# The remainder of the snippet defines a normal CMake function ``${my_fxn}``,
# which takes three positional arguments called ``int1``, ``int2``, and
# ``int3``. When a user calls ``my_fxn(0 1 2)``, ``my_fxn`` type-checks the
# arguments before ultimately forwarding them to the normal CMake function
# ``${my_fxn}``. In the body of the function you can be guaranteed that the
# user has not provided you any additional inputs beyond what your signature
# calls for and that the types of the provided inputs are correct.
#]]
macro(cpp_function _cf_name)
    _cpp_generate_wrapper(
        "${CMAKE_BINARY_DIR}/cpp_functions" "${_cf_name}" ${ARGN}
    )
    include("${CMAKE_BINARY_DIR}/cpp_functions/${${_cf_name}}.cmake")
endmacro()
