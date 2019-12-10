include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/asserts/type)
include(cmakepp_core/utilities/return)

#[[[ Creates a mangled identifier for this particular overload.
#
# This function is used to wrap the logic used to mangle the function's name,
# and the types of the arguments into one symbol. The symbol which results will
# always be all lowercase regardless of what cases are used for the function's
# name, or the types. Although it is subject to change at any time, so you
# should not rely on it, the current mangling scheme is:
#
# .. code-block:: cmake
#
#    __<function_name>_<type_0>_<type_1>_..._<type_N-1>__
#
# where ``<function_name>`` is the value of ``_cmf_fxn_name`` and the various
# types
#
# :param _cmf_result: The name for the variable which will hold the result.
# :type _cmf_result: desc
# :param _cmf_fxn_name: The non-mangled name of the function. Restrictions on
#                       the valid names are the same as for CMake functions.
# :type _cmf_fxn_name: desc
# :returns: ``_cmf_result`` will be set to the mangled name of the function.
# :rtype: desc*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is run in debug
#                               mode.
#
# If CMakePP is run in debug mode, then this function will ensure that the first
# two arguments provided to it are both of type ``desc``. It also will ensure
# that each variadic argument is the name of a valid type. These error checks
# are only done in debug mode.
#]]
function(_cpp_mangle_fxn _cmf_result _cmf_fxn_name)
    cpp_assert_signature("${ARGV}" desc desc args)

    # Starts it off with the "__" and the function's name
    set("${_cmf_result}" "__${_cmf_fxn_name}")

    # Now we concatenate the types into the symbol
    foreach(_cmf_type_i ${ARGN})
        cpp_assert_type(type "${_cmf_type_i}")
        string(APPEND "${_cmf_result}" "_${_cmf_type_i}")
    endforeach()

    # Make it lower case and put the trailing "__" on it
    string(TOLOWER "${${_cmf_result}}__" "${_cmf_result}")
    cpp_return("${_cmf_result}")
endfunction()
