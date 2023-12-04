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

include(cmakepp_lang/object/object)
include(cmakepp_lang/map/map)
include(cmakepp_lang/asserts/asserts)

#[[[
# Flattens the attributes from an objects subobjects into that objects
# attributes.
#
# This function removes all the attributes from an object's subobjects and
# adds them to that object.
#
# :param this: The objects whose attributes will be flattened.
# :type this: obj
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was called
# with exactly one argument and that that argument is an object. If this
# assertion fails an error will be raised. These checks are only performed if
# CMakePP is run in debug mode.
#]]
function(_cpp_flatten_attrs _fa_this)
    cpp_assert_signature("${ARGV}" obj)

    # Get subobjects map and the keys of that map (the subobj types)
    _cpp_object_get_meta_attr("${_fa_this}" _fa_subobjs "sub_objs")
    cpp_map(KEYS "${_fa_subobjs}" _fa_subobj_types)

    # Get attributes of _fa_this
    _cpp_object_get_meta_attr("${_fa_this}" _fa_this_attrs "attrs")

    # Loop over each subobject
    foreach(_fa_subobj_type_i ${_fa_subobj_types})
        cpp_map(GET "${_fa_subobjs}" _fa_subobj_i "${_fa_subobj_type_i}")

        # Recursively flatten this subobj's attributes
        _cpp_flatten_attrs("${_fa_subobj_i}")

        # Get the subobj attribute names and values
        _cpp_object_get_meta_attr("${_fa_subobj_i}" _fa_subobj_attrs "attrs")
        cpp_map(KEYS "${_fa_subobj_attrs}" _fa_subobj_attr_keys)

        # If this subobj has any attributes, add them to _fa_this and remove
        # them from the subobj
        list(LENGTH _fa_subobj_attr_keys _fa_subobj_attr_keys_len)
        if(_fa_subobj_attr_keys_len GREATER 0)

            # Loop over each attribute
            foreach(_fa_attr_key_i IN LISTS _fa_subobj_attr_keys)
                # If this doesn't already have this attr, add it
                cpp_map(HAS_KEY "${_fa_this_attrs}" _fa_this_has_key "${_fa_attr_key_i}")
                if(NOT "${_fa_this_has_key}")
                    # Grab the default value, if any, and add
                    # the attribute along with its default to _fa_this
                    cpp_map(GET "${_fa_subobj_attrs}" _fa_subobj_attr_i "${_fa_attr_key_i}")
                    _cpp_object_set_attr("${_fa_this}" "${_fa_attr_key_i}"
                                         "${_fa_subobj_attr_i}")
                endif()

                # Remove the attribute from the subobjs attributes
                cpp_map(REMOVE "${_fa_subobj_attrs}" "${_fa_attr_key_i}")
            endforeach()
        endif()
    endforeach()
endfunction()
