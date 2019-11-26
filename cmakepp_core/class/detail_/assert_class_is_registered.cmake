include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/get_class_registry)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Asserts that a class is registered.
#
# This is code factorization for ensuring that a class has been registered with
# the class registry. It should be called before retreiving the class's state
# (the map holding the names/overloads of its functions, its attributes, etc.)
# from the registry. This function will only perform an error check if CMakePP
# is run in debug mode.
#
# :param _cacir_type: The class which should be registered.
# :type _cacir_type: desc
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode or
#                               not.
#]]
function(_cpp_assert_class_is_registered _cacir_type)
    cpp_enable_if_debug()
    cpp_assert_signature("${ARGV}" desc)
    _cpp_get_class_registry(_cacir_registry)
    cpp_map(HAS_KEY _cacir_has_key "${_cacir_registry}" "${_cacir_type}")
    if(NOT "${_cacir_has_key}")
        set(
            _cacir_msg
            "Can not retrieve member functions for type: ${_cacir_type}"
        )
        message(
                FATAL_ERROR
                "${_cacir_msg}. Did you call 'cpp_class(${_cacir_type})' first?"
        )
    endif()
endfunction()
