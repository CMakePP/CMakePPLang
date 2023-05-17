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
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/serialization/detail/serialize_value)

#[[[
# Public API for serializing a value to JSON.
#
# When a caller outside of the serialization submodule needs an object
# serialized they should go through this API. This API wraps the (usually)
# recursive procedure required to serialize a complicated object factoring out
# the pieces that only need to be done once.
#
# :param _s_result: The name for the variable which will hold the result.
# :type _s_result: desc
# :param _s_value: The value we are serializing.
# :type _s_value: str
# :returns: ``_s_result`` will be set to the serialized form of``_s_value``.
# :rtype: desc
#]]
function(cpp_serialize _s_result _s_value)
    cpp_assert_signature("${ARGV}" desc str)
    _cpp_serialize_value(_s_serialized "${_s_value}")
    set("${_s_result}" "${_s_serialized}" PARENT_SCOPE)
endfunction()
