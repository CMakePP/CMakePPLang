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
# Since CMakePPLang is strongly typed and CMake is not, various functions are
# needed to determine which CMakePPLang type is contained in a CMake variable.
# This file provides an easy way for the user to include these functions for
# each type, as well as other functions necessary to support this strong
# typing.
#]]

include_guard()

include(cmakepp_lang/types/bool)
include(cmakepp_lang/types/cmakepp_type)
include(cmakepp_lang/types/float)
include(cmakepp_lang/types/fxn)
include(cmakepp_lang/types/implicitly_convertible)
include(cmakepp_lang/types/int)
include(cmakepp_lang/types/is_callable)
include(cmakepp_lang/types/list)
include(cmakepp_lang/types/literals)
include(cmakepp_lang/types/path)
include(cmakepp_lang/types/target)
include(cmakepp_lang/types/type)
include(cmakepp_lang/types/type_of)
