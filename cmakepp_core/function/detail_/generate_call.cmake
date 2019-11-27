include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Generates the call to the user-defined, wrapped function
#
# This function will generate the call to the wrapped function, which ultimately
# looks something like:
#
# .. code-block:: cmake
#
#    <mangled_name>("${__cpp_fxn_arg_0__}" "${__cpp_fxn_arg_1__}" ...)
#
# where ``<mangled_name>`` is the value of ``_cws_mangled_name`` and the various
# arguments are placeholder names for fowarding the arguments from the wrapper
# to the wrapped function.
#
# :param _cgc_contents: Name to use for the variable which will hold the result.
# :type _cgc_contents: desc
# :param _cgc_mangled_name: The mangled name of the function we are calling.
# :type _cws_mangled_name: desc
# :param *args: The types of the arguments to the function we are wrapping.
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
# If CMakePP is run in debug mode this function will ensure that all inputs have
# the correct types. This error checking is only performed in debug mode.
#]]
function(_cpp_generate_call _cgc_contents _cgc_mangled_name)
    cpp_assert_signature("${ARGV}" desc desc args)

    set("${_cgc_contents}" "${_cgc_mangled_name}(")
    set(_cgc_counter 0)
    foreach(_cgc_arg_i ${ARGN})
        if("${_cgc_arg_i}" STREQUAL "args")
            string(APPEND "${_cgc_contents}" [[ ${ARGN}]])
            break()
        endif()
        string(
           APPEND "${_cgc_contents}"
           [[ "${__cpp_fxn_arg_]] "${_cgc_counter}" [[__}"]]
        )
        math(EXPR _cgc_counter "${_cgc_counter} + 1")
    endforeach()

    set("${_cgc_contents}" "${${_cgc_contents}})" PARENT_SCOPE)
endfunction()
