include_guard()

#[[[ Properly escapes a CMake list for passing as part of a list.
#
# This function wraps the process of escaping the semicolons in a list so that
# the list can be used as part of a list.
#
# :param _pl_list: The identifier holding the list which will be escaped.
# :type _pl_list: identifier
# :returns: The string representation of the list, with semicolons escaped. The
#           result is available via ``_pl_list``.
# :rtype: str
#
# Example Usage:
# ==============
#
# The following snippet shows how to escape a list in order to make a list of
# lists.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/utilities/protect_list)
#    set(a_list 1 2 3)
#
#    set(list_of_lists "${a_list};${a_list}")
#    list(LENGTH list_of_lists without_protection)
#
#    protect_list(a_list)
#    set(list_of_lists "${a_list};${a_list}")
#    list(LENGTH list_of_lists with_protection)
#
#    message("${without_protection} vs. ${with_protection}")
#
# The resulting message is ``6 vs. 2`` demonstrating that without the protection
# CMake concatenates the lists instead of forming a list of lists.
#]]
macro(protect_list _pl_list)
    string(REGEX REPLACE ";" "\\\;" ${_pl_list} "${${_pl_list}}")
endmacro()
