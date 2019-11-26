include_guard()
include(cmakepp_core/class/attr)
include(cmakepp_core/class/detail_/class_guts)
include(cmakepp_core/class/end_class)
include(cmakepp_core/class/member)

#[[ Declares a user-defined type.
#
# The ``cpp_class`` function is used to start the declaration of a user-defined
# type. The type's declaration starts with ``cpp_class`` and ends with
# ``cpp_end``. All objects automatically inherit from ``Object``.
#
# :param _cc_type: The name of the user-defined type.
# :type _cc_type: desc
# :param *args: The base classes this type inherits from.
#
# .. note::
#
#    ``cpp_class`` is a macro so that the ``cpp_class`` command can abort
#    registering the class if CMakePP already knows about the class. This is
#    because the actual process of registering the class is somewhat expensive.
#]]
macro(cpp_class _cc_type)
    _cpp_class_guts(__cc_src_file "${_cc_type}" ${ARGN})
    if(__cc_src_file)
        include("${_cc_src_file}")
        return()
    endif()
endmacro()

