include_guard()
include(cmakepp_core/types/get_type)
include(cmakepp_core/serialization/serialization)

#[[[ Pretty prints a list of objects.
#
# In CMake pretty much the only way to debug is with print statements. This
# function wraps a native CMake print statement so that it becomes object-aware.
# More specifically this function will serialize objects to JSON and print them
# in JSON format.
#
# :param *args: The objects to print out.
#]]
function(cpp_print_objects)
    foreach(_cpo_obj ${ARGN})
        cpp_get_type(_cpo_type "${_cpo_obj}")
        cpp_serialize(_cpo_serial "${_cpo_obj}")
        message("Type: '${_cpo_type}'\nValue: ${_cpo_serial}")
    endforeach()
endfunction()
