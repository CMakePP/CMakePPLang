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
# CMakePPLang defines the basic extensions of the CMake language which
# comprise the CMakePP language, adding object-oriented functionality
# and quality of life features in a backwards-compatible way to CMake.
# Including this file will include the entire public API of CMakePPLang.
#]]

include_guard()

include(cmakepp_lang/algorithm/algorithm)
include(cmakepp_lang/asserts/asserts)
include(cmakepp_lang/class/class)
include(cmakepp_lang/exceptions/exceptions)
include(cmakepp_lang/map/map)
include(cmakepp_lang/object/object)
include(cmakepp_lang/serialization/serialization)
include(cmakepp_lang/types/types)
include(cmakepp_lang/utilities/utilities)
