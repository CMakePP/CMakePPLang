include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/types/types)

#[[[ Determines if an element appears in a set-like object.
#
# This function is meant to function like Python's ``in`` operation. Basically
# it encapsulates the process of checking if ``x`` is in ``y``. What "is in"
# means depends on the types of ``x`` and ``y``. For example if ``y`` is a list,
# then "is in" checks to see if ``x`` is an item in that list. Alternatively if
# ``y`` is a string then this function will check if ``x`` is a substring of
# ``y``.
#
# :param _cc_result: Name for the variable to hold the result.
# :type _cc_result: desc
# :param _cc_item: The item whose inclusion in ``_cc_list`` is in question.
# :type _cc_item: str
# :param _cc_list: The collection we are looking for ``_cc_item`` in.
# :type _cc_list: str
# :returns: ``_cc_result`` will be set to ``TRUE`` if ``_cc_item`` is in
#           ``_cc_list`` and ``FALSE`` otherwise.
# :rtype: bool*
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
function(cpp_contains _cc_result _cc_item _cc_list)
    cpp_assert_type(desc "${_cc_result}")
    cpp_get_type(_cc_list_type "${_cc_list}")

    if("${_cc_list_type}" STREQUAL "list")
        if("${_cc_item}" IN_LIST _cc_list)
            set("${_cc_result}" TRUE PARENT_SCOPE)
        else()
            set("${_cc_result}" FALSE PARENT_SCOPE)
        endif()
    elseif("${_cc_list_type}" STREQUAL "desc")
        string(FIND "${_cc_list}" "${_cc_item}" _cc_pos)
        if("${_cc_pos}" STREQUAL "-1")
            set("${_cc_result}" FALSE PARENT_SCOPE)
        else()
            set("${_cc_result}" TRUE PARENT_SCOPE)
        endif()
    endif()
endfunction()
