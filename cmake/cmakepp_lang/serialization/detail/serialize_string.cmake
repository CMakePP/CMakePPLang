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

#[[[
# Serializes a string according to the JSON standard.
#
# This is the catch-all serialization for all CMakePP objects that do not have a
# serialize routine and are not Map or List instances. A string in JSON is
# simply the value enclosed in double quotes.
#
# :param return: Name for the variable which will hold the returned value.
# :type return: desc
# :param value: The value we are serializing.
# :type value: str
# :returns: ``return`` will be set to JSON serialized form of ``value``.
# :rtype: desc
#
# Error Checking
# ==============
#
# This function is considered an implementation detail of ``cpp_serialize`` and
# does not perform any error checking.
#]]
function(_cpp_serialize_string _ss_return _ss_value)
    set("${_ss_return}" "\"${_ss_value}\"" PARENT_SCOPE)
endfunction()
