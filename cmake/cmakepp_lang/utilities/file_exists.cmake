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
# Determines if a provided path points to an existing file.
#
# :param result: Name for variable which will hold the result.
# :type result: desc
# :param file: Path which may be pointing to an existing file.
# :type file: path
# :returns: ``result`` will be set to ``TRUE`` if ``file`` is the
#           absolute path of a file and ``FALSE`` otherwise. Of note if
#           ``file`` is the absolute path to a directory the result is also
#           ``FALSE``.
# :rtype: bool
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_file_exists`` will assert that it has
# been called with two arguments and that those arguments are of the correct
# types.
#]]
function(cpp_file_exists _cfe_result _cfe_file)
    cpp_assert_signature("${ARGV}" desc path)

    if(EXISTS "${_cfe_file}")
        if(IS_DIRECTORY "${_cfe_file}")
            set("${_cfe_result}" FALSE PARENT_SCOPE)
        else()
            set("${_cfe_result}" TRUE PARENT_SCOPE)
        endif()
    else()
        set("${_cfe_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
