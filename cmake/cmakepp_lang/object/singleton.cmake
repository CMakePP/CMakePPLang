include_guard()
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/object/object)
include(cmakepp_lang/utilities/return)

#[[[ Returns a new default constructed Object instance.
#
# This function creates a new default constructed Object instance. This instance
# is only an Object instance (contrast this with derived class instances created
# using ``_cpp_object_ctor``). All instances of the Object class have identical
# state and thus for efficiency reasons it makes sense to have a single Object
# instance that all derived class instances alias.
#
# :param _os_this: Name for the variable which will hold the new instance.
# :type _os_this: desc
# :returns: ``_os_this`` will be set to the newly created Object instance.
# :rtype: obj
#
# .. note::
#
#    This command is a macro so that the member function definitions permeate
#    into the caller's scope.
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if CMakePP is run in debug mode)
# this function will ensure that it was called with exactly one argument and
# that the one argument is of type ``desc``. If either of these asserts fails an
# error will be raised.
#
# :var cmakepp_lang_DEBUG_MODE: Used to determine if CMakePP is being run in
#                              debug mode or not.
# :vartype cmakepp_lang_DEBUG_MODE: bool
#]]
macro(_cpp_object_singleton _os_this)
    cpp_assert_signature("${ARGV}" desc)

    # Create the object singleton using the default CTOR
    _cpp_object_ctor("${_os_this}" "obj")

    # Add the default CTOR, equal, and serialize functions to object
    _cpp_object_add_fxn("${${_os_this}}" ctor desc)
    function("${ctor}" __oc_this)
        # Do nothing
    endfunction()

    _cpp_object_add_fxn("${${_os_this}}" equal obj desc obj)
    function("${equal}" __oe_this __oe_result __oe_other)
        _cpp_object_equal("${__oe_this}" "${__oe_result}" "${__oe_other}")
        cpp_return("${__oe_result}")
    endfunction()

    _cpp_object_add_fxn("${${_os_this}}" serialize obj desc)
    function("${serialize}" __os_this __os_result)
        _cpp_object_serialize("${__os_this}" "${__os_result}")
        cpp_return("${__os_result}")
    endfunction()
endmacro()
