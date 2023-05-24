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

include(cmakepp_lang/map/map)

string(ASCII 5 _scl_enquiry)
string(ASCII 6 _scl_acknowledge)
string(ASCII 7 _scl_bell)
string(ASCII 16 _scl_data_link_escape)
string(ASCII 17 _scl_device_control_1)
string(ASCII 18 _scl_device_control_2)
string(ASCII 19 _scl_device_control_3)
string(ASCII 20 _scl_device_control_4)

cpp_map(CTOR special_chars_lookup
    "dquote" "${_scl_enquiry}"
    "dollar" "${_scl_acknowledge}"
    "scolon" "${_scl_bell}"
    "bslash" "${_scl_data_link_escape}"
)
