include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Generates the signature for the wrapper function
#
# This function will generate the signature for the wrapper function, which
# ultimately looks something like:
#
# .. code-block:: cmake
#
#    macro(<name> __cpp_fxn_arg_0__ __cpp_fxn_arg_1__ ...)
#
# :param _cws_contents: Name to use for the variable which will hold the result.
# :type _cws_contents: desc
# :param _cws_name: The name of the function.
# :type _cws_name: desc
# :param *args: The types of the positional arguments to the wrapped function.
# :returns: ``_cws_contents`` will contain the signature for the wrapper
#           function.
# :rtype: desc*
#
# .. note::
#
#    This function is not intended for use outside ``_cpp_generate_wrapper``. It
#    exists only to increase readability and facilitate unit testing.
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that inputs have the
# correct types. This error check is only done if CMakePP is run in debug mode.
#]]
function(_cpp_generate_signature _cgs_contents _cgs_name)
    cpp_assert_signature("${ARGV}" desc desc args)

    # Start the signature off
    set("${_cgs_contents}" "macro(${_cgs_name}")

    # Add placeholder positional arguments for each type that is not "args"
    set(_cgs_counter 0)
    foreach(_cgs_arg_i ${ARGN})
        if("${_cgs_arg_i}" STREQUAL "args")
            break()
        endif()

        string(APPEND "${_cgs_contents}" " __cpp_fxn_arg_${_cgs_counter}__")
        math(EXPR _cgs_counter "${_cgs_counter} + 1")
    endforeach()

    # Add the closing ")" and return the result
    set("${_cgs_contents}" "${${_cgs_contents}})" PARENT_SCOPE)
endfunction()
