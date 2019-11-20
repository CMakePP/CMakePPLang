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

#include(cmakepp_core/serialization/deserialize_value)
include(cmakepp_core/serialization/detail_/serialize_value)

#[[[ Public API for serializing a value to JSON.
#
# :param _cs_result: The name for the variable which will hold the result.
# :type _cs_result: desc
# :param _cs_value: The value we are serializing.
# :type _cs_value: str
# :returns: ``_cs_result`` will be set to the JSON serialized form of
#           ``_cs_value``.
# :rtype: desc*
#]]
macro(cpp_serialize _cs_result _cs_value)
    _cpp_serialize_value("${_cs_result}" "${_cs_value}")
endmacro()
