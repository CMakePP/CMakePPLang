include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/add_overload)
include(cmakepp_core/class/detail_/mangle_fxn)
include(cmakepp_core/class/detail_/register_member)

#[[[ Public API for adding a member function to a class.
#
# This function is used to declare a member function ``_cm_fxn_name`` as part of
# the class ``_cm_type``. The variadic arguments define the types of the second,
# third, fourth, etc. positional arguments to ``_cm_fxn_name`` (the first
# argument is always the instance the member function is being called on,
# *e.g.*, the "this" pointer in C++ or ``self`` in Python). CMakePP supports
# overloading which means it is possible to add the same function to the same
# class as long as the signatures are different (*i.e.*, they take arguments of
# different types). This function will raise an error if ``_cm_type`` is not
# a known class or if the overload already exists.
#
# :param _cm_fxn_name: The name of the member function which is being added to
#                      the class.
# :type _cm_fxn_name: desc
# :param _cm_type: The type of the class getting the member function. Is also
#                  the type of the first argument to the member function.
# :type _cm_fxn_name: desc
# :param *args: The types of the second, third, fourth, etc. positional
#               arguments to the function. The value ``args`` should be passed
#               if the function takes a variadic number of arguments.
#
#]]
function(cpp_member _cm_fxn_name _cm_type)
    cpp_assert_signature("${ARGV}" desc desc args)

    _cpp_class_register_member("${_cm_type}" "${_cm_fxn_name}")
    _cpp_class_add_overload("${_cm_type}" "${_cm_fxn_name}" ${ARGN})

    _cpp_mangle_fxn(_cm_mangle "${_cm_fxn_name}" "${_cm_type}" ${ARGN})
    set("${_cm_fxn_name}" "${_cm_mangle}" PARENT_SCOPE)
endfunction()
