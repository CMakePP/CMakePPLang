include_guard()
include(cmakepp_lang/object/add_fxn)
include(cmakepp_lang/object/attrs)
include(cmakepp_lang/object/call)
include(cmakepp_lang/object/copy)
include(cmakepp_lang/object/ctor)
include(cmakepp_lang/object/equal)
include(cmakepp_lang/object/get_meta_attr)
include(cmakepp_lang/object/get_symbol)
include(cmakepp_lang/object/serialize)
include(cmakepp_lang/object/singleton)

#[[[ Holds an instance of the ``obj`` class.
#
# All instances of the ``obj`` class are identical and static (well strictly
# speaking a malicious user could modify them). Thus for efficiency we make a
# single instance of the ``obj`` class and have all derived classes alias it.
# For all intents and purposes this makes the object class a singleton. That
# said aside from ``cpp_class()`` needing this variable
# (``__CMAKEPP_LANG_OBJECT_SINGLETON__``) to hold an ``obj`` instance no part of
# CMakePP actually requires there to only be one ``obj`` instance in play at any
# time.
#]]
_cpp_object_singleton(__CMAKEPP_LANG_OBJECT_SINGLETON__)


macro(_cpp_object _o_mode _o_this)
     cpp_sanitize_string(_o_nice_mode "${_o_mode}")
     if("${_o_nice_mode}" STREQUAL "get")
         _cpp_object_get_attr("${_o_this}" ${ARGN})
     elseif("${_o_nice_mode}" STREQUAL "set")
         _cpp_object_set_attr("${_o_this}" ${ARGN})
    else()
        _cpp_object_call("${_o_this}" "${_o_mode}" ${ARGN})
    endif()
endmacro()
