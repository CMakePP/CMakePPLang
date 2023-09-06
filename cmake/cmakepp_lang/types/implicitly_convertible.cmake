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
include(cmakepp_lang/class/detail/bases)
include(cmakepp_lang/types/type_of)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/sanitize_string)

#[[[
# Determines if an object of a given type can be passed as a different type.
#
# CMakePP is a strongly-typed language with minimal implicit conversions. This
# function knows of all allowed implicit conversions and should be used to
# determine if it is okay to use one type in place of another.
#
# .. note::
#
#    This function is used to implement ``cpp_assert_signature`` and thus can
#    not rely on ``cpp_assert_signature`` for type-checking.
#
# .. note::
#    Pointer types are treated as being convertible to and from :code:`desc`.
#    Pointer types are invariant currently, meaning one pointer type cannot
#    be used in place of another, even if the base types would be convertible.
#
# :param result: Name to use for the variable which will hold the result.
# :type result: desc
# :param from: The type we are attempting to cast from.
# :type from: type
# :param to: The type we are attempting to cast to.
# :type to: type
# :returns: ``result`` will be set to ``TRUE`` if an instance of
#           ``from`` can be implicitly converted to an instance of
#           ``to`` and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# ``cpp_implicitly_convertible`` will assert that it is called with only three
# arguments, if this is not the case an error will be raised.
#]]
function(cpp_implicitly_convertible _ic_result _ic_from _ic_to)
    if(NOT "${ARGC}" EQUAL 3)
        message(FATAL_ERROR "cpp_implicitly_convertible takes exactly 3 args.")
    endif()

    set(_ic_from_original "${_ic_from}")
    set(_ic_to_original "${_ic_to}")

    # Sanitize types to avoid case-sensitivity
    cpp_sanitize_string(_ic_to "${_ic_to}")
    cpp_sanitize_string(_ic_from "${_ic_from}")

    # Check if they are the same type (which are always implicitly convertible)
    if(_ic_to STREQUAL _ic_from)
        set("${_ic_result}" TRUE PARENT_SCOPE)
        return()
    elseif(_ic_to STREQUAL "str") # Everything is a str
        set("${_ic_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # If from-type is "Class" we are casting from a user-defined class
    cpp_type_of(_ic_from_type "${_ic_from}")
    if(_ic_from_type STREQUAL "class")
        # Casting from "Class" to "type" is okay
        if(_ic_to STREQUAL "type")
            set("${_ic_result}" TRUE PARENT_SCOPE)
            return()
        else()
            # Need to see if from-type is a base class of to-type
            _cpp_class_get_bases("${_ic_from}" _ic_bases)
            list(FIND _ic_bases "${_ic_to}" _ic_index)
            if(_ic_index EQUAL -1) # Not in list, so not a base class
                set("${_ic_result}" FALSE PARENT_SCOPE)
            else() # In the list, so a base class
                set("${_ic_result}" TRUE PARENT_SCOPE)
            endif()
        endif()
        return()
    endif()

    # Getting here means from-type and to-type are not the same type, we are
    # not converting to a str, and from-type is not a user-defined class. In
    # turn this means there are only a few edge-cases where we actually
    # allow an implicit conversion. We check for those now
    set("${_ic_result}" FALSE PARENT_SCOPE)

    # These are the edge-cases that make it an okay conversion
    if(_ic_to STREQUAL "list")  # Any one object is a one-element list
        set("${_ic_result}" TRUE PARENT_SCOPE)
    # We checked if the type of from_type was a class, but missed if from_type
    # itself was class
    elseif(_ic_from STREQUAL "class")
        if(_ic_to STREQUAL "type")
            set("${_ic_result}" TRUE PARENT_SCOPE)
        endif()
    # Check if we're converting desc to pointer type or from pointer to desc
    elseif((_ic_from_original STREQUAL "desc" AND _ic_to_original MATCHES ".+[*]") OR (_ic_from_original MATCHES ".+[*]" AND _ic_to_original STREQUAL "desc"))
        set("${_ic_result}" TRUE PARENT_SCOPE)

    elseif(_ic_from_original MATCHES ".+[*]" AND _ic_to_original MATCHES ".+[*]")
        string(REGEX REPLACE "[*]$" "" _ic_from_ptr_deref "${_ic_from_original}")
        string(REGEX REPLACE "[*]$" "" _ic_to_ptr_deref "${_ic_to_original}")
        cpp_implicitly_convertible(_ic_convertible_ptr_deref "${_ic_from_ptr_deref}" "${_ic_to_ptr_deref}")
        set("${_ic_result}" "${_ic_convertible_ptr_deref}" PARENT_SCOPE)
    endif()
endfunction()
