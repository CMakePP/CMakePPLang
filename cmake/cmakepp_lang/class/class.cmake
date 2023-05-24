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

#[[[ @module
# Defines the public API for creating and managing a CMakePPLang 
# user-defined class.
#]]

include_guard()
include(cmakepp_lang/class/attr)
include(cmakepp_lang/class/class_decl)
include(cmakepp_lang/class/member)
include(cmakepp_lang/class/register_ctor)
include(cmakepp_lang/class/virtual_member)
include(cmakepp_lang/utilities/check_conflicting_types)
