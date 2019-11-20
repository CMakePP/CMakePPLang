include_guard()

#[[[ Generates a unique identifier.
#
# This function will create a unique identifier which can be used, for example,
# as the "this" pointer for an object.
#
# :param _cui_id: The name to for the variable which will hold the result.
# :type _cui_id: desc
# :returns: ``_cui_id`` will be set to the generated unique id.
# :rtype: desc*
#]]
function(cpp_unique_id _cui_id)
    string(TIMESTAMP _cui_time "%s")
    string(RANDOM _cui_prefix)
    set("${_cui_id}" "${_cui_prefix}_${_cui_time}" PARENT_SCOPE)
endfunction()
