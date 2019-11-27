include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/function/detail_/generate_assert)
include(cmakepp_core/function/detail_/generate_call)
include(cmakepp_core/function/detail_/generate_header)
include(cmakepp_core/function/detail_/generate_signature)
include(cmakepp_core/function/detail_/mangle_fxn)
include(cmakepp_core/utilities/return)

#[[[ Writes the wrapper function to a file.
#
# CMakePP functions are implemented by wrapping the user's function in a
# function which contains some boilerplate. This function is responsible for
# generating the wrapping function and writing the implementation out.
#
# :param _cgw_file_prefix: The directory where the generated implementation
#                          should go. The name of the file will be the
#                          mangled function's name concatenated with ``.cmake``.
# :type _cgw_file_prefix: path
# :param _cgw_name: The public name of the function used to call the wrapper.
#                   The name of the function will also be used as the name of
#                   the variable holding the return.
# :type _cgw_name: desc
# :param *args: The types of the positional arguments.
# :returns: ``_cgw_name`` will be set to the mangled name of the function, which
#           is what the caller should use to declare their function.
# :rtype: desc*
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will ensure that all
# inputs have the correct types. Additionally, this function will ensure that
# all variadic arguments are valid CMakePP types. These error checks are only
# done if CMakePP is run in debug mode.
#]]
function(_cpp_generate_wrapper _cgw_file_prefix _cgw_name)
    cpp_assert_signature("${ARGV}" path desc args)

    # Get the contents of the file that don't need the mangled name
    _cpp_generate_header(_cgw_head)
    _cpp_generate_signature(_cgw_sig "${_cgw_name}" ${ARGN})
    _cpp_generate_assert(_cgw_assert ${ARGN})

    # Mangle the name, overwriting _cgw_name
    _cpp_mangle_fxn("${_cgw_name}" "${_cgw_name}" ${ARGN})

    # Get the last piece of the file which needs the mangled name
    _cpp_generate_call(_cgw_call "${${_cgw_name}}" ${ARGN})

    # Write the file out
    file(
        WRITE "${_cgw_file_prefix}/${${_cgw_name}}.cmake"
        "${_cgw_head}${_cgw_sig}\n${_cgw_assert}\n${_cgw_call}\nendmacro()"
    )

    # Return the mangled name
    cpp_return("${_cgw_name}")
endfunction()
