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
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/return)

#[[[
# Encapsulates the process of retrieving an object's meta attributes.
#
# Each Object instance has several attributes which are meant purely for use by
# CMakePP to make the Object work. These attributes are special and sequestered
# from the normal instance attributes and termed "meta-attributes". This
# function is designed to encapsulate the process of retrieving a
# meta-attribute's value. If an attribute exists this function will return its
# value, if the attribute does not exist than this function will return the
# empty string. At the moment there is no way to distinguish between a
# meta-attribute set to the empty string and a non-existing meta-attribute.
#
# :param this: The object instance whose meta-attribute is being
#                    retrieved.
# :type this: obj
# :param result: Name for the variable which will hold the value.
# :type result: desc
# :param attr: The name of the meta-attribute we are retrieving.
# :type attr: desc
# :returns: ``result`` will be set to the value of the attribute (if the
#           attribute exists) and the empty string otherwise.
# :rtype: str
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if CMakePP is run in debug mode)
# this function will assert that it has been called with exactly three arguments
# and that those arguments have the correct types. If any assertion fails an
# error will be raised.
#]]
function(_cpp_object_get_meta_attr _ogma_this _ogma_result _ogma_attr)
    cpp_assert_signature("${ARGV}" obj desc desc)

    cpp_get_global(_ogma_state "${_ogma_this}__state")
    cpp_map(GET "${_ogma_state}" "${_ogma_result}" "_cpp_${_ogma_attr}")
    cpp_return("${_ogma_result}")
endfunction()
