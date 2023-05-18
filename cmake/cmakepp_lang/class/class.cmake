include_guard()
include(cmakepp_lang/class/detail/bases)
include(cmakepp_lang/object/object)
include(cmakepp_lang/types/cmakepp_type)
include(cmakepp_lang/utilities/check_conflicting_types)

set(
    __CMAKEPP_LANG_CLASS_TEMPLATE__
    "${CMAKE_CURRENT_LIST_DIR}/detail/class.cmake.in"
)

#[[[
# Creates the new class
#
# This function is factored out of ``cpp_class`` and contains the logic required
# to actually create the class. This logic is factored out primarily to avoid
# contaminating the caller's namespace with intermediate results.
#
# :param type: The name of the class being created.
# :type type: desc
# :param wrapper: Name for variable which will hold the path to the class's
#                 implementation.
# :type wrapper: desc
# :param \*args: The base classes that this class derives from.
# :returns: ``wrapper`` will be set to the absolute file path for the
#           generated module which implements the class.
# :rtype: path
#]]
function(_cpp_class_guts _cg_type _cg_wrapper)
    cpp_sanitize_string(_cg_nice_type "${_cg_type}")
    cpp_check_conflicting_types(
        _cg_conflict _cg_conflicting_type "${_cg_nice_type}"
    )
    if(_cg_conflict)
        message(
            FATAL_ERROR
            "Class name conflicts with a built-in type: "
            "'${_cg_type}' conflicts with built-in '${_cg_conflicting_type}'"
        )
    endif()

    if("${ARGC}" EQUAL 2)
        # No parent classes passed in, only inherit from obj
        set(_cg_bases "obj")
        # Use the obj singleton as the base instance
        set(_cg_base_instances "${__CMAKEPP_LANG_OBJECT_SINGLETON__}")
    else()
        set(_cg_bases "")
        set(_cg_base_instances "")
        foreach(_cg_base_i ${ARGN})
            cpp_get_global(_cg_default_base_i "${_cg_base_i}__state")
            list(APPEND _cg_base_instances "${_cg_default_base_i}")

            cpp_get_global(_cg_base_i_bases "${_cg_base_i}__bases")
            cpp_sanitize_string(_cg_nice_base "${_cg_base_i}")
            list(APPEND _cg_bases "${_cg_base_i_bases}" "${_cg_nice_base}")
        endforeach()
        list(REMOVE_DUPLICATES _cg_bases)
    endif()

    # Set the type before calling any ``Class`` members so we can type check
    _cpp_set_cmakepp_type("${_cg_type}" "class")

    _cpp_object_ctor(_cg_default "${_cg_type}" ${_cg_base_instances})
    _cpp_class_set_bases("${_cg_type}" _cg_bases)
    cpp_set_global("${_cg_type}__state" "${_cg_default}")

    set(
        "${_cg_wrapper}"
        "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/classes/${_cg_type}.cmake"
    )
    configure_file(
       "${__CMAKEPP_LANG_CLASS_TEMPLATE__}" "${${_cg_wrapper}}" @ONLY
    )
    cpp_return("${_cg_wrapper}")
endfunction()

#[[[
# Creates a new class of the specified type.
#
# This command is used to start the declaration of a new user-defined type. The
# resulting user-defined type will automatically inherit from ``Object`` if no
# base classes are provided, otherwise it will inherit from the specified base
# classes (users of this command should never explicitly specify inheritance
# from ``Object``).
#
# :param type: The name of the class whose declaration is being started.
# :type type: desc
# :param \*args: The various base classes that the class should inherit from.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# .. note::
#
#    This command is a macro to ensure that the functions generated by this
#    command are in scope to the caller.
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with at least one argument and that
# the arguments have the correct types.
#]]
macro(cpp_class _c_type)
    cpp_assert_signature("${ARGV}" desc args)
    _cpp_class_guts("${_c_type}" "_${_c_type}_wrapper" ${ARGN})
    include("${_${_c_type}_wrapper}")
endmacro()

#[[[
# Registers a class's member function.
#
# This function is used to declare a new member function.
#
# :param name: The name of the member function. This is the name you will use
#              to invoke the member function.
# :type name: desc
# :param type: The class we are adding the member function to. This is also
#              the type of the "this" pointer.
# :type type: class
# :param \*args: The types of the arguments to the member function. This list
#                should NOT include the type for the this pointer as this will
#                automatically be prepended to this list.
# :returns: ``name`` will be set to the mangled name of the declared
#           function to facilitate implementing it.
# :rtype: desc
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if) this function will assert that
# it is called with the correct number and types of arguments. If any of these
# assertions fail an error will be raised.
#]]
function(cpp_member _m_name _m_type)
    cpp_assert_signature("${ARGV}" desc class args)

    cpp_get_global(_m_state "${_m_type}__state")
    _cpp_object_add_fxn("${_m_state}" "${_m_name}" "${_m_type}" ${ARGN})
    cpp_return("${_m_name}")
endfunction()

#[[[
# Registers a class's virtual member function.
#
# This function is used to declare a new virtual member function that has no
# concrete implementation and must be overridden by a derived class.
#
# :param fxn_name: The name of the virtual member function.
# :type fxn_name: desc
#]]
macro(cpp_virtual_member _vm_fxn_name)
    cpp_assert_signature("${ARGV}" desc class)

    function("${${_vm_fxn_name}}")
        message(
            FATAL_ERROR
            "${_vm_fxn_name} is pure virtual and must be overriden by derived class"
        )
    endfunction()
endmacro()

#[[[
# Registers a class constructor.
#
# This function is used to declare a class constructor.
#
# :param name: The name of the constructor (CTOR by convention). This will be
#              the named used to invoke the member constructor.
# :type name: desc
# :param type: The class we are adding the constructor to.
# :type type: class
# :param \*args: The types of the arguments to the constructor function.
# :returns: ``name`` will be set to the mangled name of the declared
#           constructor to facilitate implementing it.
# :rtype: desc
# 
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if) this function will assert that
# it is called with the correct number and types of arguments. If any of these
# assertions fail an error will be raised.
#]]
function(cpp_constructor _c_name _c_type)
    cpp_assert_signature("${ARGV}" desc class args)

    cpp_get_global(_c_state "${_c_type}__state")
    _cpp_object_add_fxn("${_c_state}" "${_c_name}" "desc" ${ARGN})
    cpp_return("${_c_name}")
endfunction()

#[[[
# Registers a class's attribute.
#
# This function is used to declare a new attribute for a class.
#
# :param type: The name of the class getting the attribute.
# :type type: class
# :param attr: The name of the attribute
# :type attr: desc
# :param \*args: The initial value of the attribute. If no ``*args`` are provided
#                the attribute will be initialized to the empty string.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if) this function will assert that
# it is called with the correct number and types of arguments. If any of these
# assertions fail an error will be raised.
#]]
function(cpp_attr _a_type _a_attr)
    cpp_assert_signature("${ARGV}" class desc args)

    cpp_get_global(_a_state "${_a_type}__state")
    _cpp_object_set_attr("${_a_state}" "${_a_attr}" "${ARGN}")
endfunction()

#[[[
# Denotes that we are done declaring a class.
#
# This function is a no-op that completes the fencing associated with declaring
# a class.
#
# Error Checking
# ==============
#
# None. This function is a no-op and has no errors to check for.
#]]
macro(cpp_end_class)
endmacro()
