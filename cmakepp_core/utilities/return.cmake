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
# :type _cr_rv: desc
#
# ..note::
#
#   This function is a macro to avoid creating another scope. If another scope
#   is created, then the ``cpp_return`` function could not act in the caller's
#   scope, *i.e.*, the caller would still have to call ``set`` and ``return``.
#
# Example Usage:
# ==============
#
# The following shows how to write a function which has multiple return points.
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
#]]
macro(cpp_return _cr_rv)
    set("${_cr_rv}" "${${_cr_rv}}" PARENT_SCOPE)
    return()
endmacro()
