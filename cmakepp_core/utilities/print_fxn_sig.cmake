include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Creates a pretty, human-readable representation of a function's signature.
#
# This function will combine a function's name, and the types of its arguments,
# to create a string representation of the function declaration.
#
# :param _cpfs_result: Name of the variable which will hold the result.
# :type _cpfs_result: desc
# :param _cpfs_fxn_name: The unmangled name of the function whose signature we
#                        are printing.
# :type _cpfs_fxn_name: desc
# :param *args: The types of the arguments to ``_cpfs_fxn_name``.
# :returns: ``_cpfs_result`` will be set to a human-readable, string
#           represenation of this particular overload of ``_cpfs_fxn_name``.
# :rtype: desc*
#]]
function(cpp_print_fxn_sig _cpfs_result _cpfs_fxn_name)
    cpp_assert_signature("${ARGV}" desc desc args)
    set("${_cpfs_result}" "${_cpfs_fxn_name}(")
    set(_cpfs_arg_printed FALSE)
    foreach(_cpfs_arg_i ${ARGN})
        if(_cpfs_arg_printed)
            set("${_cpfs_result}" "${${_cpfs_result}}, ")
        endif()
        set("${_cpfs_result}" "${${_cpfs_result}}${_cpfs_arg_i}")
        set(_cpfs_arg_printed TRUE)
    endforeach()
    set("${_cpfs_result}" "${${_cpfs_result}})" PARENT_SCOPE)
endfunction()
