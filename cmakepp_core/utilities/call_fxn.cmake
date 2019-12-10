include_guard()

#[[[ Calls a function who's name is provided at runtime.
#
# CMake does not allow you to dynamically determine the name of a function. For
# example one can NOT do ``${name_of_fxn}(<args...>)`` or any other variation
# which retrieves part of the function's name from a variable. The ``cpp_call``
# macro allows us to circumvent this limitation at the cost of some I/O.
#
# :param _ccf_fxn2call: The name of the function to call.
# :type _ccf_fxn2call: desc
# :param *args: The arguments to forward to the function.
#
# .. note::
#
#    ``cpp_call_fxn`` is a macro to avoid creating a new scope. If a new scope
#    was created it would be necessary to forward returns, which would
#    signifiantly complicate the implementation.
#]]
macro(cpp_call_fxn _ccf_fxn2call)
    file(
        WRITE
        "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxn_calls/${_ccf_fxn2call}.cmake"
        "${_ccf_fxn2call}(${ARGN})"
    )
    include(
        "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxn_calls/${_ccf_fxn2call}.cmake"
    )
endmacro()
