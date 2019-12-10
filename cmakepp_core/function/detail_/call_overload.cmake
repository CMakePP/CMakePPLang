include_guard()
include(cmakepp_core/function/detail_/get_mangled_name)
include(cmakepp_core/utilities/call_fxn)

#[[[ Wraps the call to a CMakePP function.
#
# When a user declares a CMakePP function, ``foo`` all CMakePP does is wrap a
# call to this function, with ``_cfco_fxn`` bound to ``foo`` inside a function
# named ``foo``. This function in turn is responsible for determining the
# correct overload to call and then calling it.
#
# :param _cfco_fxn: Name of the function we are calling.
# :type _cfco_fxn: desc
# :param *args: The values of the arguments being provided to the function.
# :returns: Whatever the overload of ``_cfco_fxn`` returns.
#
# .. note::
#
#    ``_cpp_function_call_overload`` is a macro to avoid needing to forward the
#    user's returned values. If ``_cpp_function_call_overload`` were a function
#    then an extra scope would exist between the caller and the callee, which
#    returns would have to be forwarded through.
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# This function will raise an error if no suitable overload of ``_cfco_fxn``
# has been registered, or is in scope. This error check is always performed.
# Additionally, if CMakePP is in debug mode this function will ensure that the
# ``_cfco_fxn`` is of the correct type. The type check is only done in debug
# mode.
#]]
macro(_cpp_function_call_overload _cfco_fxn)
    _cpp_function_get_mangled_name(
            "${_cfco_fxn}" __cfco_${_cfco_fxn}_mn ${ARGN}
    )
    cpp_call_fxn("${__cfco_${_cfco_fxn}_mn}" ${ARGN})
endmacro()
