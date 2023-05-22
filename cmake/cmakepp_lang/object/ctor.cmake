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
include(cmakepp_lang/types/cmakepp_type)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/return)
include(cmakepp_lang/utilities/sanitize_string)

#[[[
# Constructs a new instance of the specified type.
#
# This function constructs a new instance of the specified type. This should not
# be confused with creating a new, default initialized Object instance which is
# done with the ``_cpp_object_singleton`` function. The resulting instance will
# be initialized to the default state for the specified type.
#
# :param this: Name for the variable which will hold the resulting instance.
# :type this: desc
# :param type: The most-derived type of the object we are creating.
# :type type: type
# :param \*args: The initial instances of each direct base class on which this
#                instance should be built.
# :return: ``this`` will be set to the newly created instance.
# :rtype: obj
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode (and only if CMakePP is being run in
# debug mode) this function will assert that it has been called with the correct
# number and types of arguments. If an assertion fails an error will be raised.
#]]
function(_cpp_object_ctor _oc_this _oc_type)
    cpp_assert_signature("${ARGV}" desc type args)

    cpp_map(CTOR _oc_fxns)
    cpp_map(CTOR _oc_attrs)
    cpp_map(CTOR _oc_sub_objs)

    foreach(_oc_sub_obj_i ${ARGN})
        _cpp_object_get_meta_attr("${_oc_sub_obj_i}" _oc_type_i "my_type")
        cpp_map(SET "${_oc_sub_objs}" "${_oc_type_i}" "${_oc_sub_obj_i}")
    endforeach()

    cpp_sanitize_string(_oc_type "${_oc_type}")
    cpp_map(CTOR _oc_state  _cpp_attrs "${_oc_attrs}"
                            _cpp_fxns "${_oc_fxns}"
                            _cpp_sub_objs "${_oc_sub_objs}"
                            _cpp_my_type "${_oc_type}"
    )

    cpp_unique_id("${_oc_this}")
    cpp_set_global("${${_oc_this}}__state" "${_oc_state}")
    _cpp_set_cmakepp_type("${${_oc_this}}" "${_oc_type}")
    cpp_return("${_oc_this}")
endfunction()
