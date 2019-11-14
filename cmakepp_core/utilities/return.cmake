include_guard()

#[[[ Syntactic sugar for returning a value from a function
#
# CMake allows you to return variables by adding them to the parent namespace.
# The best way to do this is to have the caller provide the function with an
# identifier in which to save the result. Assume some function ``A`` called a
# function ``B``, which is now returning a value ``x``, the ``cpp_return``
# function wraps the boilerplate associated with ensuring ``x`` is available in
# ``A``'s namespace and also returns control back to ``A`` (*i.e.*, any
# code following the ``cpp_return`` call in ``B`` will not be executed).
#
# .. warning::
#
#    Extreme care needs to be taken when using this function in a macro as it
#    always returns control to one scope up. Since macros do not create new
#    scope this function will return through all macros on the stack until a
#    function is reached. As a rule-of-thumb, never call this function from a
#    macro.
#
# :param _cr_rv: The identifier which needs to be set in the parent namespace.
# :type _cr_rv: identifier
#
# Example Usage:
# ==============
#
# The following shows how to write a function which has multiple
#
# .. code-block:: cmake
#
#    function(fxn_name return_identifier)
#        set(${return_identifier} "some value"
#        if(x)
#            set(${return_identifier} "anoter value")
#            cpp_return(${return_identifier})
#        endif()
#        cpp_return(${return_indentifier})
#    endfunction()
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
    return()
endmacro()
