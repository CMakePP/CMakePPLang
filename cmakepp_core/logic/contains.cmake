include_guard()
include(cmakepp_core/asserts/type)

#[[[ Determines if a list contains an item.
#
# This function is used to determine if the specified item is included in the
# provided list.
#
# :param _cc_result: Name for the variable to hold the result.
# :type _cc_result: desc
# :param _cc_item: The item whose inclusion in the list is in question.
# :type _cc_item: str
# :param _cc_list: The list we are looking for ``_cc_item`` in.
# :type _cc_list: list
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

    # IN_LIST was added in CMake 3.3
    if("${_cc_item}" IN_LIST _cc_list)
        set("${_cc_result}" TRUE PARENT_SCOPE)
    else()
        set("${_cc_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
