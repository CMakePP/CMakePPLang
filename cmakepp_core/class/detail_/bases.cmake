include_guard()
include(cmakepp_core/utilities/global)

#[[[ Encapsulates the logic for retrieving the base classes of a user-defined
#    type.
#
# The type system needs to know which base classes a user-defined class can be
# implicitly converted to. This function encapsulates the logic of retrieving
# that list to avoid a direct coupling to how that list is stored.
#
# .. note::
#
#    This function is used by ``cpp_implicitly_convertible`` and thus is inside
#    the type-checking machinery which can not have its type checked by
#    ``cpp_assert_signature``. Also worth noting this function is currently a
#    macro because all it does is set a variable for the caller, thus we save a
#    call to ``cpp_return``.
#
# :param _cgb_this: The class instance we are retrieving the bases of.
# :type _cgb_this: class
# :param _cgb_bases: An identifier to which the list of base classes will be
#                    assigned.
# :param _cgb_bases: desc
# :returns: ``_cgb_bases`` will be set to the list of base classes that the
#           user-defined type stored in ``_cgb_this`` derives from. This is not
#           the list of base classes that the ``Class`` class derives from.
# :rtype: [type]
#
#]]
macro(_cpp_class_get_bases _cgb_this _cgb_bases)
    cpp_get_global("${_cgb_bases}" "${_cgb_this}__bases")
endmacro()

#[[[ Encapsulates the logic for setting the base classes of a user-defined
#    type.
#
# The type system needs to know which base classes a user-defined class can be
# implicitly converted to. This function encapsulates the logic of setting that
# list to avoid a direct coupling to how that list is stored.
#
#
# :param _csb_this: The class instance we are setting the bases of.
# :type _csb_this: class
# :param _csb_bases: An identifier containing the list of base classes.
# :param _csb_bases: [type]*
#
# Error Checking
# ==============
#
# Unlike ``_cpp_class_get_bases``, ``_cpp_class_set_bases`` is not actually used
# by the type-checking machinery and thus can rely on that machinery for
# type-checking.
#]]
function(_cpp_class_set_bases _csb_this _csb_bases)
    include(cmakepp_core/asserts/signature)
    cpp_assert_signature("${ARGV}" class list)
    cpp_set_global("${_csb_this}__bases" "${${_csb_bases}}")
endfunction()
