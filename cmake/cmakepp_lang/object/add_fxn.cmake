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
include(cmakepp_lang/map/map)
include(cmakepp_lang/object/get_meta_attr)
include(cmakepp_lang/utilities/sanitize_string)

#[[[
# Register's a member function with the object.
#
# This function is used to add a member function to an object. The member
# function will override member functions in base classes with the same
# signature and overload member functions with the same name, but different
# signatures.
#
# :param this: The Object instance we are adding the function to.
# :type this: obj
# :param name: The name of the function we are adding.
# :type name: desc
# :param \*args: The types of the arguments to the function.
# :returns: ``name`` will be set to the mangled name of the function which
#           was added. Users should use the mangled name when implementing the
#           function.
# :rtype: desc
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will assert that it was
# called with the correct number and types of arguments. If this is not the case
# an error will be raised. These error checks are only performed if CMakePP is
# being run in debug mode.
#]]
function(_cpp_object_add_fxn _oaf_this _oaf_name)
    cpp_assert_signature("${ARGV}" obj desc args)

    # Get the most-derived type of this object
    _cpp_object_get_meta_attr("${_oaf_this}" _oaf_type "my_type")

    # Sanitize the name of the function, start the mangled name and signature
    cpp_sanitize_string(_oaf_nice_name "${_oaf_name}")
    # _oaf_mn is the mangled function name that must be a valid
    # command name, _oaf_value is the function name and arguments
    # tuple so it must preserve special characters in parameter type identifiers
    # like the pointer asterisk
    set(_oaf_mn "_cpp_${_oaf_type}_${_oaf_nice_name}_")
    set(_oaf_value "${_oaf_nice_name}")

    # Loop over types of arguments, updating name/signature
    foreach(_oaf_arg_i ${ARGN})
        # _oaf_nice_arg_i is used to construct the final mangled
        # function name, so it needs to be sanitized
        cpp_sanitize_string(_oaf_nice_arg "${_oaf_arg_i}")

        # TOLOWER instead of cpp_santize_string because it obliterates the pointer asterisk.
        # _oaf_type_arg is used for the signature checks, so it needs to have
        # the pointer asterisk preserved
        string(TOLOWER "${_oaf_arg_i}" _oaf_type_arg)
        string(APPEND _oaf_mn "${_oaf_nice_arg}_")
        list(APPEND _oaf_value "${_oaf_type_arg}")
    endforeach()

    # Add the function to the vtable
    _cpp_object_get_meta_attr("${_oaf_this}" _oaf_fxns "fxns")
    cpp_map(SET "${_oaf_fxns}" "${_oaf_mn}" "${_oaf_value}")

    # Return the mangled name
    set("${_oaf_name}" "${_oaf_mn}" PARENT_SCOPE)
endfunction()
