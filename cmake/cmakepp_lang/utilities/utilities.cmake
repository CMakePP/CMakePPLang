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
# Provides an easy way for the user to include the quality-of-life utility
# functions that CMakePPLang provides to the user.
#]]

include_guard()

include(cmakepp_lang/asserts/assert)
include(cmakepp_lang/utilities/call_fxn)
include(cmakepp_lang/utilities/compare_lists)
include(cmakepp_lang/utilities/directory_exists)
include(cmakepp_lang/utilities/enable_if_debug)
include(cmakepp_lang/utilities/file_exists)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/pack_list)
include(cmakepp_lang/utilities/print_fxn_sig)
include(cmakepp_lang/utilities/return)
include(cmakepp_lang/utilities/unique_id)
