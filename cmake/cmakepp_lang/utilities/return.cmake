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
# Syntactic sugar for returning a value from a function
#
# CMake allows you to return variables by adding them to the parent namespace.
# The best way to do this is to have the caller provide the function with an
# identifier in which to save the result. Assume some function ``A`` called a
# function ``B``, which is now returning a value ``x``, the ``cpp_return``
# function wraps the boilerplate associated with ensuring ``x`` is available in
# ``A``'s namespace and also returns control back to ``A`` (*i.e.*, any
# code following the ``cpp_return`` call in ``B`` will not be executed).
#
# This works for any number of return values.
#
# .. warning::
#
#    Extreme care needs to be taken when using this function in a macro as it
#    always returns control to one scope up. Since macros do not create new
#    scope this function will return through all macros on the stack until a
#    function is reached. As a rule-of-thumb, never call this function from a
#    macro.
#
# :param \*args: Identifiers which needs to be set in the parent namespace.
# :type \*args: list[desc]
#
# .. note::
#
#   This function is a macro to avoid creating another scope. If another scope
#   is created, then the ``cpp_return`` function could not act in the caller's
#   scope, *i.e.*, the caller would still have to call ``set`` and ``return``.
#
# Example Usage
# =============
#
# The following shows how to write a function which has multiple return points.
#
# .. code-block:: cmake
#
#    function(fxn_name return_identifier)
#        set(${return_identifier} "some value")
#        if(x)
#            set(${return_identifier} "another value")
#            cpp_return(${return_identifier})
#        endif()
#        cpp_return(${return_identifier})
#    endfunction()
#
# The following shows how to write a function which returns multiple values:
#
# .. code-block:: cmake
#
#    function(fxn_name return_id_1 return_id_2)
#        set("${return_id_1}" "return_value_1")
#        set("${return_id_2}" "return_value_2")
#        cpp_return("${return_id_1}" "${return_id_2}")
#    endfunction()
#]]
macro(cpp_return)
    foreach(_cr_rv ${ARGN})
        set("${_cr_rv}" "${${_cr_rv}}" PARENT_SCOPE)
    endforeach()
    return()
endmacro()
