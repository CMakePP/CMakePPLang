include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Encapsulates the logic for retrieving the class registry.
#
# The class registry is a singleton which maps user-defined types to their APIs.
# This function is responsible for encapsulating the logic associated with
# creating it (if it does not already exist) and then returning it the caller.
#
# :param _cgcr: The name of the variable to use to hold the registry.
# :type _cgcr: desc
# :returns: ``_cgcr_registry`` will be set to the class registry.
# :rtype: map*
#]]
function(_cpp_get_class_registry _cgcr_registry)
    cpp_assert_type(desc "${_cgcr_registry}")
    get_property("${_cgcr_registry}" GLOBAL PROPERTY __CPP_CLASS_REGISTRY__)

    if("${${_cgcr_registry}}" STREQUAL "")
        cpp_map(CTOR "${_cgcr_registry}")
        set_property(GLOBAL PROPERTY __CPP_CLASS_REGISTRY__ "${_cgcr_registry}")
    endif()
    cpp_return("${_cgcr_registry}")
endfunction()
