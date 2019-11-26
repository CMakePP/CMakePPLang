include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/class/detail_/get_overloads)
include(cmakepp_core/class/detail_/mangle_fxn)
include(cmakepp_core/utilities/print_fxn_sig)

#[[[ Adds an overload to a class's member function.
#
# This function will add an overload of the member function ``_ccho_fxn_name``
# to the class ``_ccho_type``. The signature of such a function always minimally
# looks like ``_ccho_fxn_name(_ccho_type ...)``. The first argument to the
# function is always ``this`` or ``self`` (respectively depending on whether you
# want to think about member functions in C++ or Python terms), *i.e*, the
# instance the member function is being called on. The ellipses are the types of
# the remaining positional arguments to the function. Different permutations of
# the positional arguments constitute different overloads. If the overload
# already exists, this function will override the previous implementation with
# the implemenation for this class.
#
#
# :param _ccho_type: The type of the class we are adding the overload to.
# :type _ccho_type: desc
# :param _ccho_fxn_name: The name of the function we are overloading.
# :type _ccho_fxn_name: desc
# :param *args: The types of the arguments we are creating an overload for.
#               ``_ccho_type`` will automatically be prepended to ``*args`` to
#               form the final signature. Thus ``*args`` should only be the
#               types of inputs beyond the instance the member is being called
#               on.
#
#]]
function(_cpp_class_add_overload _ccho_type _ccho_fxn_name)
    cpp_assert_signature("${ARGV}" desc desc args)
    # Will fail if class or function have not been registered
    _cpp_class_get_overloads(
        _ccho_overloads "${_ccho_type}" "${_ccho_fxn_name}"
    )
    _cpp_mangle_fxn(_ccho_mangle "${_ccho_fxn_name}" "${_ccho_type}" ${ARGN})
    cpp_array(CTOR _ccho_args ${ARGN})
    cpp_map(SET "${_ccho_overloads}" "${_ccho_args}" "${_ccho_mangle}")
endfunction()
