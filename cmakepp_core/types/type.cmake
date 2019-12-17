include_guard()
include(cmakepp_core/types/literals)
include(cmakepp_core/utilities/global)

#[[[ Determines if a string is lexically convertible to a type literal.
#
# CMakePP defines a series of type literals for types recognized by CMake and
# for types recognized by CMake and CMakePP. Additionally, users can create
# classes to add even more type literals. This function will determine if an
# identifier is also a type literal.
#
# :param _it_result: Name for the variable which will hold the result.
# :type _it_result: desc
# :param _it_type: The object for which we want to know if it is a type literal.
# :type _it_type: str
# :returns: ``_it_result`` will be set to ``TRUE`` if ``_it_type`` is a type and
#           ``FALSE`` otherwise.
# :rtype: bool*
#
#]]
function(cpp_is_type _it_result _it_type)

    # Check for the "type" meta-attribute
    cpp_get_global(_it_is_class "${_it_type}_type")

    if("${_it_is_class}" STREQUAL "class")
        set("${_it_result}" TRUE PARENT_SCOPE)
    elseif(NOT "${_it_is_class}" STREQUAL "")
        set("${_it_result}" FALSE PARENT_SCOPE)
        return()
    endif()

    # See if its an intrinsic CMake type
    list(FIND CMAKE_TYPE_LITERALS "${_it_type}" _it_index)
    if(NOT "${_it_index}" EQUAL -1)
        set("${_it_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # See if its an intrinsic CMakePP type
    list(FIND CMAKEPP_TYPE_LITERALS "${_it_type}" _it_index)
    if(NOT "${_it_index}" EQUAL -1)
        set("${_it_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    set("${_it_result}" FALSE PARENT_SCOPE)
endfunction()
