# Copyright 2023 CMakePP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_guard()

include(cmakepp_lang/asserts/type)
include(cmakepp_lang/map/has_key)
include(cmakepp_lang/types/types)
include(cmakepp_lang/utilities/return)

#[[[
# Determines if an element appears in a set-like object.
#
# This function is meant to function like Python's ``in`` operation. Basically
# it encapsulates the process of checking if ``x`` is in ``y``. What "is in"
# means depends on the types of ``x`` and ``y``. For example if ``y`` is a list,
# then "is in" checks to see if ``x`` is an item in that list. Alternatively if
# ``y`` is a string then this function will check if ``x`` is a substring of
# ``y``.
#
# :param result: Name for the variable to hold the result.
# :type result: desc
# :param item: The item whose inclusion in ``list`` is in question.
# :type item: str
# :param list: The collection we are looking for ``item`` in.
# :type list: str
# :returns: ``result`` will be set to ``TRUE`` if ``item`` is in
#           ``list`` and ``FALSE`` otherwise.
# :rtype: bool
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Example Usage
# =============
#
# The following snippet shows how to determine if the word ``"hello"`` is in the
# list ``"hello;world"``.
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/logic/contains)
#    set(a_list "hello" "world")
#    cpp_contains(result "hello" "${a_list}")
#    message("The list contains 'hello': ${result}")  # Will print TRUE
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will ensure that it is called
# with the correct number of arguments and that those arguments have the correct
# types. These error checks are only performed if CMakePP is run in debug mode.
#
#]]
function(cpp_contains _c_result _c_item _c_list)
    cpp_assert_signature("${ARGV}" desc str str)

    cpp_type_of(_c_list_type "${_c_list}")

    set(_c_temp_result FALSE)

    if("${_c_list_type}" STREQUAL "map")
        cpp_map_has_key("${_c_list}" _c_temp_result "${_c_item}")
    elseif("${_c_list_type}" STREQUAL "desc") #Substring matching
        string(FIND "${_c_list}" "${_c_item}" _c_pos)
        if(NOT "${_c_pos}" STREQUAL "-1")
            set(_c_temp_result TRUE)
        endif()
    else() # Treat it like a single element list or a list
        if("${_c_item}" IN_LIST _c_list)
            set(_c_temp_result TRUE)
        endif()
    endif()

    set("${_c_result}" "${_c_temp_result}" PARENT_SCOPE)
endfunction()
