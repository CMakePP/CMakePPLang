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
include(cmakepp_lang/types/bool)
include(cmakepp_lang/types/cmakepp_type)
include(cmakepp_lang/types/float)
include(cmakepp_lang/types/fxn)
include(cmakepp_lang/types/int)
include(cmakepp_lang/types/list)
include(cmakepp_lang/types/literals)
include(cmakepp_lang/types/path)
include(cmakepp_lang/types/target)
include(cmakepp_lang/types/type)
include(cmakepp_lang/utilities/global)

#[[[
# Returns the type literal for the provided object.
#
# This function encapsulates the process of determining the type of an object.
# It is capable of determining the type of intrinsic CMake objects (integers,
# booleans, etc.), intrinsic CMakePP objects (Object, Class, and Map), and
# user-defined classes.
#
# :param result: Name for the variable which will hold the result.
# :type result: desc
# :param obj: The object we want the type of.
# :type obj: str
# :returns: ``result`` will be set to the type literal corresponding to
#           ``obj``'s type.
# :rtype: type
#
# Error Checking
# ==============
#
# ``cpp_type_of`` will ensure that the caller has provided only 2 arguments and,
# if the caller has provided a different amount, will raise an error.
#]]
function(cpp_type_of _to_result _to_obj)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_type_of takes exactly 2 arguments.")
    endif()

    # If _to_obj is "" it's a desc (catch it now to avoid corner cases later)
    if("${_to_obj}" STREQUAL "")
        set("${_to_result}" "desc" PARENT_SCOPE)
        return()
    endif()

    # Determine if the object is a CMakePP object, and if so get its type
    _cpp_get_cmakepp_type(_to_is_cmakepp_obj "${_to_result}" "${_to_obj}")

    if("${_to_is_cmakepp_obj}")
        set("${_to_result}" "${${_to_result}}" PARENT_SCOPE)
        return()
    endif()

    # Try the literal types known to the runtime
    # (only need CMake literals as CMakePP literals would have been caught)
    foreach(_to_type_i ${CMAKE_TYPE_LITERALS})

        if(_to_type_i STREQUAL "bool")
            cpp_is_bool(_to_is_type_i "${_to_obj}")
        elseif(_to_type_i STREQUAL "float")
            cpp_is_float(_to_is_type_i "${_to_obj}")
        elseif(_to_type_i STREQUAL "fxn")
            cpp_is_fxn(_to_is_type_i "${_to_obj}")
        elseif(_to_type_i STREQUAL "genex")
            set(_to_is_type_i FALSE)
        elseif(_to_type_i STREQUAL "int")
            cpp_is_int(_to_is_type_i "${_to_obj}")
        elseif(_to_type_i STREQUAL "list")
            cpp_is_list(_to_is_type_i "${_to_obj}")
        elseif(_to_type_i STREQUAL "path")
            cpp_is_path(_to_is_type_i "${_to_obj}")
        elseif(_to_type_i STREQUAL "target")
            cpp_is_target(_to_is_type_i "${_to_obj}")
        elseif(_to_type_i STREQUAL "type")
            cpp_is_type(_to_is_type_i "${_to_obj}")
        else()
            message(FATAL_ERROR "No dispatch for type ${_to_type_i}")
        endif()

        if("${_to_is_type_i}")
            set("${_to_result}" "${_to_type_i}" PARENT_SCOPE)
            return()
        endif()

    endforeach()



    # Pointer detection, if we want to enforce true pointer type checking
    # Needs more work though
    if(DEFINED "${_to_obj}")
        cpp_type_of(_to_ptr_type "${${_to_obj}}")
        set("${_to_result}" "${_to_ptr_type}*")
        set("${_to_result}" "${_to_ptr_type}*" PARENT_SCOPE)
        return()
    endif()

    # Only choice left is desc
    set("${_to_result}" desc PARENT_SCOPE)
endfunction()
