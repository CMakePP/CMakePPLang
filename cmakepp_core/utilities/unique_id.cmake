include_guard()
include(cmakepp_core/utilities/return)

#[[[ Generates a unique identifier.
#
# This function will create a unique identifier which can be used, for example,
# as the "this" pointer for an object. The uniqueness of the identifier relies
# on mangling the time (with second resolution) and a random string. Thus the
# result should be unique so long as the same random string is not generated
# during the same second.
#
# :param _cui_id: The name to for the variable which will hold the result.
# :type _cui_id: desc
# :returns: ``_cui_id`` will be set to the generated unique id.
# :rtype: desc*
#]]
function(cpp_unique_id _cui_id)
    # Get seconds since UNIX epoch (requires CMake version >= 3.6)
    string(TIMESTAMP _cui_time "%s")

    string(RANDOM _cui_prefix)
    string(TOLOWER "${_cui_prefix}_${_cui_time}" "${_cui_id}")
    cpp_return("${_cui_id}")
endfunction()
