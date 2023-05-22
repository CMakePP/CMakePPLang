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

include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/map/copy)
include(cmakepp_lang/object/copy)
include(cmakepp_lang/types/type_of)
include(cmakepp_lang/utilities/return)

#[[[
# Creates a new object which is a deep copy of an already existing object.
#
# This function will create a deep copy of an existing object regardless of
# what type it is.
#
# :param result: The name of the variable to return the result in.
# :type result: desc
# :param obj2copy: The object we are deep copying
# :type obj2copy: str
# :returns: ``result`` will be set to a deep copy of ``obj2copy``.
# :rtype: str
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will ensure that it has
# been called with exactly two arguments and that those arguments have the
# correct types. If any of these assertions fail, an error will be raised. These
# error checks are done only if CMakePP is being run in debug mode.
#]]
function(cpp_copy _c_result _c_obj2copy)
    #cpp_assert_signature("${ARGV}" desc str)

    cpp_type_of(_c_type "${_c_obj2copy}")
    cpp_implicitly_convertible(_c_is_obj "${_c_type}" "obj")
    if("${_c_type}" STREQUAL "map")
        cpp_map_copy("${_c_obj2copy}" "${_c_result}")
    elseif(_c_is_obj)
        _cpp_object_copy("${_c_obj2copy}" "${_c_result}")
    else()
        set("${_c_result}" "${_c_obj2copy}")
    endif()
    cpp_return("${_c_result}")
endfunction()
