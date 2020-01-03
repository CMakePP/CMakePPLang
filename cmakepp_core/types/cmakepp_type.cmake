include_guard()
include(cmakepp_core/utilities/global)

#[[[ Encapsulates the process of getting a CMakePP object's type.
#
# CMakePP introduces several additional built-in types as well as the ability
# for users to define their own types. This function encapsulates the logic
# to determine if an object is a CMakePP type, and if it is, how to determine
# that type.
#
# :param _gct_is_cpp_obj: Identifier for the variable which will hold whether or
#                         not ``_gct_obj`` is a CMakePP object.
# :type _gct_is_cpp_obj: desc
# :param _gct_type: Identifier to hold the type of ``_gct_obj`` if it is indeed
#                   a CMakePP object.
# :type _gct_type: desc
# :param _gct_obj: The object for which we want to know if it is a CMakePP
#                  object, and if it is, what is its type.
# :type _gct_obj: str
#
# :returns: ``_gct_is_cpp_obj`` will be set to ``TRUE`` if ``_gct_obj`` is a
#           CMakePP built-in type or a user-defined type and ``FALSE``
#           otherwise. If ``_gct_is_cpp_obj`` is ``TRUE`` than ``_gct_type``
#           will be set to the type of ``_gct_obj``. If ``_gct_is_cpp_obj`` is
#           ``FALSE`` than ``_gct_type`` will be set to the empty string.
# :rtype: (bool, type) or (bool, desc)
#
# .. note::
#
#    This function is used as part of the type-checking machinery and can not
#    rely on ``cpp_assert_signature`` to check its input types. It is a macro to
#    avoid the need to call ``cpp_return`` to forward the return.
#
# Error Checking
# ==============
#
# ``_cpp_get_cmakepp_type`` will ensure that it was provided three arguments. If
# it was not provided exactly three arguments an error will be raised.
#
#]]
macro(_cpp_get_cmakepp_type _gct_is_cpp_obj _gct_type _gct_obj)
    if(NOT "${ARGC}" EQUAL 3)
        message(FATAL_ERROR "_cpp_get_cmakepp_type takes exactly 3 arguments.")
    endif()

    cpp_get_global("${_gct_type}" "${_gct_obj}__type")
    if("${${_gct_type}}" STREQUAL "")
        set("${_gct_is_cpp_obj}" FALSE)
    else()
        set("${_gct_is_cpp_obj}" TRUE)
    endif()
endmacro()

#[[[ Encapsulates the process of setting a CMakePP object's type.
#
# CMakePP introduces several additional built-in types as well as the ability
# for users to define their own types. This function encapsulates the logic
# for setting a CMakePP object's type.
#
# .. note::
#
#   That before calling this function the "this"-pointer will simply be a
#   description. It is this function which makes the CMakePP runtime recognize
#   the "this"-pointer as actually-being of the specified type.
#
# :param _sct_this: The "this"-pointer for the CMakePP object we are setting the
#                   type of.
# :type _sct_this: desc
# :param _sct_type: The type we are making ``_sct_this``.
# :type _sct_type: type
#
# Error Checking
# ==============
#
# ``_cpp_set_cmakepp_type`` will assert that it is called with exactly two
# arguments, and if it is not, will raise an error.
#]]
function(_cpp_set_cmakepp_type _sct_this _sct_type)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "_cpp_set_cmakepp_type takes exactly 2 arguments.")
    endif()

    cpp_set_global("${_sct_this}__type" "${_sct_type}")
endfunction()
