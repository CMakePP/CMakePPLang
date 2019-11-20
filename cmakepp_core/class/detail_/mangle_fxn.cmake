include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/utilities/return)

#[[[ Creates a mangled identifier for this particular overload.
#
# This function is used to wrap the logic used to mangle the: class's type, the
# function's name, and the types of the arguments into one symbol. The symbol
# which results will always be all lowercase regardless of what cases are used
# for the class's name, the function's name, or the types.
#
# :param _cmf_result: The name for the variable which will hold the result.
# :type _cmf_result: desc
# :param _cmf_fxn_name: The non-mangled name of the function. Restrictions on
#                       the valid names are the same as for CMake functions.
# :type _cmf_fxn_name: desc
# :returns: ``_cmf_result`` will be set to the mangled name of the function.
# :rtype: desc*
#
# .. note::
#
#    This function is meant to be used as an implementation detail for defining
#    the API of member functions for CMakePP classes. Aside from checking the
#    signature of the call, no additional error checking is performed. In
#    particular we do not ensure that ``_cmf_type`` is the name of an existing
#    class, nor do we ensure that the contents of ``*args`` are valid types.
#]]
function(_cpp_mangle_fxn _cmf_result _cmf_fxn_name _cmf_type)
    cpp_assert_signature("${ARGV}" desc desc desc)

    set("${_cmf_result}" "__${_cmf_fxn_name}_${_cmf_type}")

    foreach(_cmf_type_i ${ARGN})
        set("${_cmf_result}" "${${_cmf_result}}_${_cmf_type_i}")
    endforeach()

    string(TOLOWER "${${_cmf_result}}__" "${_cmf_result}")
    cpp_return("${_cmf_result}")
endfunction()
