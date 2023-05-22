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
include(cmakepp_lang/types/is_callable)
include(cmakepp_lang/utilities/return)

#[[[
# Encapsulates the process of looking up the symbol for a given signature.
#
# This function will search the current instance, as well as all of its
# base class instances looking for a member function which can be called with
# the provided signature. If a suitable overload exists this function will
# return the corresponding symbol. Otherwise it will return ``FALSE``.
#
# :param this: The Object instance whose member functions are being
#              considered.
# :type this: obj
# :param result: Name for the variable which will hold the result.
# :type result: desc
# :param sig: A list whose first element is the name of the function and
#             whose remaining elements are the types of each positional
#             argument.
# :type sig: list*
# :returns: ``result`` will be set to the symbol of the member function
#           matching the provided signature (if a suitable match exists) or
#           ``FALSE`` if there is no suitable overload.
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
# this function will assert that it is called with exactly three arguments and
# that these three arguments have the correct types. If any of these assertions
# fail an error will be raised.
#]]
function(_cpp_object_get_symbol _ogs_this _ogs_result _ogs_sig)
    cpp_assert_signature("${ARGV}" obj desc desc)

    _cpp_object_get_meta_attr("${_ogs_this}" _ogs_fxns "fxns")
    cpp_map(KEYS "${_ogs_fxns}" _ogs_symbols)

    foreach(_ogs_symbol_i ${_ogs_symbols})
        cpp_map(GET "${_ogs_fxns}" _ogs_fxn_i "${_ogs_symbol_i}")
        cpp_is_callable(_ogs_good _ogs_fxn_i "${_ogs_sig}")
        if("${_ogs_good}")
            set("${_ogs_result}" "${_ogs_symbol_i}" PARENT_SCOPE)
            return()
        endif()
    endforeach()

    _cpp_object_get_meta_attr("${_ogs_this}" _ogs_sub_objects "sub_objs")
    cpp_map(KEYS "${_ogs_sub_objects}" _ogs_bases)

    foreach(_ogs_base_i ${_ogs_bases})
        cpp_map(GET "${_ogs_sub_objects}" _ogs_base_state "${_ogs_base_i}")
        _cpp_object_get_symbol(
            "${_ogs_base_state}" _ogs_has_symbol "${_ogs_sig}"
        )
        if(_ogs_has_symbol)
            set("${_ogs_result}" "${_ogs_has_symbol}" PARENT_SCOPE)
            return()
        endif()
    endforeach()

    set("${_ogs_result}" FALSE PARENT_SCOPE)
endfunction()
