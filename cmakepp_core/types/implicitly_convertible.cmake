include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/utilities/return)

#[[[ Used to determine if CMakePP allows implicit casts between two types.
#
# CMakePP is a strongly-typed language which allows for few implicit
# conversions. For types ``T`` and ``U``, CMakePP allows implicit conversion
# from ``T`` to ``U`` in the following circumstances:
#
# 1. ``T`` is the same as ``U``,
# 2. ``U`` is ``str``, or
# 3. ``U`` is a base class of ``T``.
#
# :param _cic_result: Name for the variable which will hold the result.
# :type _cic_result: desc
# :param _cic_to_type: The type we are trying to convert to (``U`` in the
#                      description)
# :type _cic_to_type: type
# :param _cic_from_type: The type we are trying to convert from (``T`` in the
#                        description)
# :type _cic_from_type: type
# :returns: ``_cic_result`` will be set to ``TRUE`` if ``_cic_from_type`` can be
#           converted to ``_cid_to_type``.
# :rtype: bool*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG: Used to determine if CMakePP is being run in debug
#                          mode.
#
# If CMakePP is in debug mode this function will ensure that the arguments
# provided are of the correct types. These error checks are only done in debug
# mode.
#]]
function(cpp_implicitly_convertible _cic_result _cic_to_type _cic_from_type)
    cpp_assert_signature("${ARGV}" desc type type)

    # The if-else tree is all the ways that RHS can be implicitly cast to LHS
    set("${_cic_result}" TRUE)

    if("${_cic_to_type}" STREQUAL "${_cic_from_type}")
        cpp_return("${_cic_result}")
    elseif("${_cic_to_type}" STREQUAL "str")
        cpp_return("${_cic_result}")
    # Need a derived from clause
    endif()

    # Reaching here means that RHS can NOT be implicitly cast to LHS
    set("${_cic_result}" FALSE PARENT_SCOPE)
endfunction()
