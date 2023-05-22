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

include(cmakepp_lang/types/implicitly_convertible)
include(cmakepp_lang/types/type_of)
include(cmakepp_lang/asserts/assert)
include(cmakepp_lang/utilities/enable_if_debug)

#[[[
# Tests that the provided object can be implicitly cast to the provided type.
#
# If CMakePP is run in debug mode, this function will throw an error if the
# provided object is not implicitly convertible to the provided type. If CMakePP
# is not being run in debug mode, then this function is a no-op.
#
# :param type: The type that the type of the object must be implicitly
#              convertible to.
# :type type: type
# :param obj: The object whose type must be implicitly convertible to
#             ``type``.
# :type obj: str
# 
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# In addition to asserting that the provided object's type is implicitly
# convertible to the provided type. This function will also ensure that the
# caller has only provided two arguments and that ``type`` is actually a
# type. These additional error checks are also only done when CMakePP is run in
# debug mode.
#]]
function(cpp_assert_type _at_type _at_obj)
    cpp_enable_if_debug()
    # Check the signature of this call
    cpp_type_of(_at_type_type "${_at_type}")
    cpp_implicitly_convertible(_at_convertible "${_at_type_type}" "type")
    cpp_assert(
        "${_at_convertible}" "${_at_type_type} is convertible to type"
    )

    if(NOT "${ARGC}" EQUAL 2)
        message(
            FATAL_ERROR
            "Function takes 2 argument(s), but ${ARGC} was/were provided."
        )
    endif()

    cpp_type_of(_at_obj_type "${_at_obj}")
    cpp_implicitly_convertible(_at_convertible "${_at_obj_type}" "${_at_type}")
    cpp_assert(
        "${_at_convertible}" "${_at_obj_type} is convertible to ${_at_type}"
    )
endfunction()
