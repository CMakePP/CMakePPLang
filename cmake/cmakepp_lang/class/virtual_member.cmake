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

include(cmakepp_lang/asserts/signature)

#[[[
# Registers a class's virtual member function.
#
# This function is used to declare a new virtual member function that has no
# concrete implementation and must be overridden by a derived class.
#
# :param fxn_name: The name of the virtual member function.
# :type fxn_name: desc
#]]
macro(cpp_virtual_member _vm_fxn_name)
    cpp_assert_signature("${ARGV}" desc class)

    function("${${_vm_fxn_name}}")
        message(
            FATAL_ERROR
            "${_vm_fxn_name} is pure virtual and must be overriden by derived class"
        )
    endfunction()
endmacro()
