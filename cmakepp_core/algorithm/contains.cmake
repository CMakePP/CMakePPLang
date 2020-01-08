include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/has_key)
include(cmakepp_core/types/types)
include(cmakepp_core/utilities/return)

#[[[ Determines if an element appears in a set-like object.
#
# This function is meant to function like Python's ``in`` operation. Basically
# it encapsulates the process of checking if ``x`` is in ``y``. What "is in"
# means depends on the types of ``x`` and ``y``. For example if ``y`` is a list,
# then "is in" checks to see if ``x`` is an item in that list. Alternatively if
# ``y`` is a string then this function will check if ``x`` is a substring of
# ``y``.
#
# :param _c_result: Name for the variable to hold the result.
# :type _c_result: desc
# :param _c_item: The item whose inclusion in ``_c_list`` is in question.
# :type _c_item: str
# :param _c_list: The collection we are looking for ``_c_item`` in.
# :type _c_list: str
# :returns: ``_c_result`` will be set to ``TRUE`` if ``_c_item`` is in
#           ``_c_list`` and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will ensure that it is called
# with the correct number of arguments and that those arguments have the correct
# types. These error checks are only performed if CMakePP is run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#
# Example Usage:
# ==============
#
# The following snippet shows how to determine if the word ``"hello"`` is in the
# list ``"hello;world"``.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/logic/contains)
#    set(a_list "hello" "world")
#    cpp_contains(result "hello" "${a_list}")
#    message("The list contains 'hello': ${result}")  # Will print TRUE
#]]
function(cpp_contains _c_result _c_item _c_list)
    cpp_assert_signature("${ARGV}" desc str str)

    cpp_type_of(_c_list_type "${_c_list}")
    set("${_c_result}" FALSE PARENT_SCOPE)

    if("${_c_list_type}" STREQUAL "list")
        if("${_c_item}" IN_LIST _c_list)
            set("${_c_result}" TRUE PARENT_SCOPE)
        endif()
    elseif("${_c_list_type}" STREQUAL "map")
        cpp_map_has_key("${_c_list}" _c_temp "${_c_item}")
        set("${_c_result}" "${_c_temp}" PARENT_SCOPE)
    elseif("${_c_list_type}" STREQUAL "desc")
        string(FIND "${_c_list}" "${_c_item}" _c_pos)
        if(NOT "${_c_pos}" STREQUAL "-1")
            set("${_c_result}" TRUE PARENT_SCOPE)
        endif()
    endif()
endfunction()
