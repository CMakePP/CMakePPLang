include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/unique_id)

#[[[ Creates a new instance of the Object base class.
#
# :param _coc_result: Name to use for the identifier which will hold the result.
# :type _coc_result: desc
# :returns: ``_coc_result`` will be set to the newly created Object instance.
# :rtype: obj*
#]]
function(_cpp_object_ctor _coc_result)
    cpp_assert_signature("${ARGV}" desc args)

    cpp_map(CTOR _coc_fxns)            # This will be the vtable for functions
    cpp_map(CTOR _coc_attrs)           # This will be the vtable for attributes
    cpp_array(CTOR _coc_bases obj ${ARGN})  # List of base classes
    cpp_map(CTOR _coc_state attrs "${_coc_attrs}"
                            fxns  "${_coc_fxns}"
                            src_file "${CMAKE_CURRENT_LIST_DIR}"
                            types "${_coc_bases}"

    )
    cpp_unique_id("${_coc_result}")

    set_property(GLOBAL PROPERTY "${${_coc_result}}" "${_coc_state}")
    set_property(GLOBAL PROPERTY "${${_coc_result}}_type" "obj")
    cpp_return("${_coc_result}")
endfunction()
