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

## Code factorization for reporting a string as invalid JSON
#
# As we deserialize a JSON string we are constantly checking to make sure that
# the string is valid JSON. If it is not we raise an error. The purpose of this
# function is to ensure that that error is uniformly printed.
#
# :param buffer: An identifier whose contents is not valid JSON
function(_cpp_json_error _cje_buffer)
    _cpp_error("${${_cje_buffer}} is not valid JSON.")
endfunction()
