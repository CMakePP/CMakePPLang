################################################################################
#                        Copyright 2018 Ryan M. Richard                        #
#       Licensed under the Apache License, Version 2.0 (the "License");        #
#       you may not use this file except in compliance with the License.       #
#                   You may obtain a copy of the License at                    #
#                                                                              #
#                  http://www.apache.org/licenses/LICENSE-2.0                  #
#                                                                              #
#     Unless required by applicable law or agreed to in writing, software      #
#      distributed under the License is distributed on an "AS IS" BASIS,       #
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
#     See the License for the specific language governing permissions and      #
#                        limitations under the License.                        #
################################################################################

include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/serialization/detail_/serialize_value)

#[[[ Serializes a CMakePP array into JSON.
#
# This function will serialize the provided CMakePP array into JSON format.
# This is done by recursively serializing all elements of the array.
#
# :param _csa_return: The name to use for the variable to hold the result.
# :type _csa_return: desc
# :param _cs_value: The array we are serializing.
# :type _csa_value: array
# :returns: ``_csa_return`` will be set to the JSON serialized form of
#           ``_csa_value``.
# :rtype: desc*
#]]
function(_cpp_serialize_obj _cso_return _cso_value)
    cpp_assert_signature("${ARGV}" desc obj)
    get_property(_cso_state GLOBAL PROPERTY "${_cso_value}")
    _cpp_serialize_value(_cso_temp "${_cso_state}")
    set("${_cso_return}" "{ \"obj\" : ${_cso_temp} }" PARENT_SCOPE)
endfunction()
