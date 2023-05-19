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
# Creates a pretty, human-readable representation of a function's signature.
#
# This function will combine a function's name, and the types of its arguments,
# to create a string representation of the function declaration.
#
# :param result: Name of the variable which will hold the result.
# :type result: desc
# :param fxn_name: The unmangled name of the function whose signature we
#                        are printing.
# :type fxn_name: desc
# :param \*args: The types of the arguments to ``fxn_name``.
# :returns: ``result`` will be set to a human-readable, string
#           representation of this particular overload of ``fxn_name``.
# :rtype: desc
#]]
function(cpp_print_fxn_sig _pfs_result _pfs_fxn_name)
    cpp_assert_signature("${ARGV}" desc desc args)

    # Set result to "fxn_name(" and note we have not printed any arg types yet
    set("${_pfs_result}" "${_pfs_fxn_name}(")
    set(_pfs_arg_printed FALSE)

    # Loop over the provided argument types
    foreach(_pfs_arg_i ${ARGN})

        # If not the first arg we need a comma before adding another arg
        if(_pfs_arg_printed)
            set("${_pfs_result}" "${${_pfs_result}}, ")
        endif()

        # Add the current arg and note we have added at least 1 arg to result
        string(APPEND "${_pfs_result}" "${_pfs_arg_i}")
        set(_pfs_arg_printed TRUE)
    endforeach()

    # Put the closing ")" onto the result and return
    set("${_pfs_result}" "${${_pfs_result}})" PARENT_SCOPE)
endfunction()
