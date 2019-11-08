include_guard()

#[[[ Syntactic sugar for returning a value from a function
#
# CMake allows you to return variables by adding them to the parent namespace.
# The best way to do this is to have the caller provide the function with an
# identifier to save the result to. This function wraps the common case where
# internally the function saves the result to a local variable with the same
# name as the callee provided for the result. Without the ``cpp_return``
# function this common pattern looks something like:
#
# .. code-block:: cmake
#
#    function(fxn_name return_identifier)
#        set(${return_identifier} "the value")
#        set(${return_identifier} "${${return_identifier}}" PARENT_SCOPE
#    endfunction()
#
# With the ``cpp_return`` function the above becomes:
#
# .. code-block:: cmake
#
#    function(fxn_name return_identifier)
#        set(${return_identifier} "the value")
#        cpp_return(${return_identifier})
#    endfunction()
#
# While the new code still has the same number of lines, it is our opinion that
# the new code is easier to read and the intent is more clear.
#
# :param _cr_rv: The identifier which needs to be set in the parent namespace.
# :type _cr_rv: identifier
#
# ..note::
#
#   This function is a macro to avoid creating another scope. Assume that some
#   function ``A`` called some function ``B`` and ``B`` is calling
#   ``cpp_return`` to return a value to ``A``. If we had used ``function``
#   than ``rv`` will be set in the scope of ``B``and NOT in the scope of ``A``.
#   ``B`` would thus have to also do ``set(${rv} ${${rv}} PARENT_SCOPE)``
#   defeating the purpose of this function.
#]]
macro(cpp_return _cr_rv)
    set("${_cr_rv}" "${${_cr_rv}}" PARENT_SCOPE)
endmacro()
