include_guard()
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/serialization/serialization)

#[[[ Serializes an object into JSON format.
#
# This function is the default implementation for serializing an object. Derived
# classes are free to override it with their own implementations. This
# implementation simply treats the object as a map with a single key-value pair
# comprised of the "this" pointer (as the key) and the serialized state of the
# object as the value.
#
# :param _os_this: The object we are serializing.
# :type _os_this: obj
# :param _os_result: Name for the identifier which will hold the serialized
#                    value.
# :type _os_result: desc
# :returns: ``_os_result`` will be set to the JSON serialized representation of
#           ``_os_this``.
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is) this function will assert
# that the caller has provided exactly two arguments and that those arguments
# have the correct types. If any assertion fails an error is raised.
#
# :var cmakepp_lang_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype cmakepp_lang_DEBUG_MODE: bool
#]]
function(_cpp_object_serialize _os_this _os_result)
    cpp_assert_signature("${ARGV}" obj desc)

    cpp_get_global(_os_state "${_os_this}__state")
    set(_os_temp "{ \"${_os_this}\" :")
    _cpp_serialize_map(_os_buffer "${_os_state}")
    string(APPEND _os_temp " ${_os_buffer} }")
    set("${_os_result}" "${_os_temp}" PARENT_SCOPE)
endfunction()

#[[[ Prints an object to standard out.
#
# This function is code factorization for serializing an object and printing the
# serialized form to standard out.
#
# :param _op_this: The object we are printing to standard out.
# :type _op_this: obj
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is) this function will ensure
# that it was called with a single argument and that the argument is implicitly
# convertible to an Object. If either of these assertions fail an error will be
# raised.
#
# :var cmakepp_lang_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype cmakepp_lang_DEBUG_MODE: bool
#]]
function(_cpp_object_print _op_this)
    cpp_assert_signature("${ARGV}" obj)

    _cpp_object_serialize("${_op_this}" _op_result)
    message("${_op_result}")
endfunction()
