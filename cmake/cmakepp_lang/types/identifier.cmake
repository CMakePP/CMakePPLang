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

include(cmakepp_lang/types/literals)

#[[[
# If a string matches this regular expression,
# then it is a valid CMakePP identifier. This
# regular expression allows a superset of those matched
# by the CMake lexer for the Identifier token, seen in the
# `CMake source code <https://github.com/Kitware/CMake/blob/5a79ea2799e27dc78d71ad71cbf7009416e98076/Source/LexerParser/cmListFileLexer.in.l#L134-L139>`_.
#
# Unfortunately, CMake is very loose with its definition of an identifier.
# Command invocations must follow the above-linked regex,
# but it is entirely valid to name a CMake function or macro whatever you
# want, you just can't directly call it and must use :code:`cmake_language(CALL)`.
# Additionally, the set of valid variable and target names is a superset
# of valid command invocations: they can contain hyphens, the plus and slash characters (only variables support slashes),
# and the dot character directly, and with
# `policy CMP0053 <https://cmake.org/cmake/help/v3.27/policy/CMP0053.html#policy:CMP0053>`_
# any non-alphanumeric (or semicolon) character that is escaped
# is valid in variable names (but not target names).
#
# Moreover, the restrictions on target names are only valid when
# `Policy CMP0037 <https://cmake.org/cmake/help/v3.27/policy/CMP0037.html>`_
# is set to the NEW behavior. In the OLD behavior, which is still the default as of
# version 3.27.6, any string is a valid target identifier, but may cause
# obscure bugs if it doesn't follow the restrictions set by the NEW behavior.
#
# Put frankly, it's a mess, and trying to keep track of which ruleset a possible
# identifier should be compared against is an exercise in futility.
# Thus, the approach taken by CMakePP is to have a single regex that
# matches variable names, using the NEW behavior of Policy CMP0053 (but not allowing
# non-escaped slashes to prevent confusion with paths).
# Coincidentally, this means command and target names (using the restricted behavior)
# will also match, and thus :code:`fxn` and :code:`target` can be subtypes of :code:`identifier`.
#
# To explain the regex itself: there are no additional restrictions on the first character
# like there are for other languages. Any character in the identifier must be alphanumeric,
# a number, an underscore, a hyphen, a dot, or it must be non-alphanumeric and non-semicolon
# and be escaped by an immediately-preceding backslash.
#]]
set(CMAKEPP_IDENTIFIER_REGEX [[^([a-zA-Z0-9_.-]|\\[^A-Za-z0-9;])+$]] CACHE INTERNAL "Used to decide whether a string is an identifier.")

#[[[
# Determines if the provided string can lexically be cast to a identifier.
#
# This function will compare the provided string against a regex to
# determine if it is valid as an identifier.
#
# :param return: Name of the variable used to hold the return.
# :type return: desc
# :param str2check: The string we are checking for its bool-ness
# :type str2check: str
# :returns: ``return`` will contain ``TRUE`` if ``str2check`` is
#           a valid identifier and ``FALSE`` otherwise.
# :rtype: bool
# :var CMAKEPP_IDENTIFIER_REGEX: If a string matches this regex, then it is valid.
#
# Example Usage
# =============
#
# The following code snippet shows how to use ``cpp_is_bool`` to determine if
# the provided variable is a boolean.
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/identifier)
#    set(var2check a_variable)
#    cpp_is_identifier(result "${var2check}")
#    message("var2check is a valid identifier: ${result}")  # will print TRUE
#
# Error Checking
# ==============
#
# ``cpp_is_identifier`` will ensure that it has been called with exactly two
# arguments.
#]]
function(cpp_is_identifier _ii_return _ii_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_bool accepts exactly 2 arguments")
    endif()


    # Needed to put the regex in cache so it was available no matter when this module
    # was included, since otherwise it would only be available in the same
    # directory scope as CMakePP
    string(REGEX MATCH "$CACHE{CMAKEPP_IDENTIFIER_REGEX}" _ii_matches "${_ii_str2check}")

    if(NOT "${_ii_matches}" STREQUAL "")
        set("${_ii_return}" TRUE PARENT_SCOPE)
        return()
    endif()

    # Getting here means it did not match
    set("${_ii_return}" FALSE PARENT_SCOPE)
endfunction()
