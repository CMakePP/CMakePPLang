include_guard()
include(cmakepp_core/object/attributes)

#[[[ Encapsulates setting the type of an object.
#
# The type of an object is the type of the most derived class. The type is set
# by the derived class's ctor using this function.
#
# :param _ost_object: The object whose type is being set.
# :type _ost_object: obj
# :param _cost_type: The type of the object.
# :type _cost_type: class
#
#]]
function(_cpp_object_set_type _ost_this _ost_type)
    cpp_object_set_attr("${_ost_this}" _cpp_type "${_ost_type}")
endfunction()
