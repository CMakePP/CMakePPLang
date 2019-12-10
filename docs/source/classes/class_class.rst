***************
The Class Class
***************

There are two parts to a class: the API and the state. In CMakePP the ``Class``
class stores the class's API and the ``Object`` class stores its state. This
page walks through the behind the scene details of the ``Class`` class.

A Base Class
============

For sake of argument, let's say the user is declaring a class ``Foo``, which
does not inherit from any other class and has a single member function ``fxn1``.
This looks something like:

.. code-block:: cmake

   include(cmakpp_core/class/class)

   cpp_class(Foo)

       cpp_member(fxn1 Foo int bool)
       function(${fxn1} this arg0 arg1)
           # Implement fxn1
       endfunction()

   cpp_end_class(Foo)

There's two major tricks at play. First, ``cpp_class(Foo)`` and
``cpp_member(fxn1 Foo int bool)`` actually return values in ``Foo`` and
``fxn1``. After ``cpp_class(Foo)``, ``Foo`` holds a singleton object of type
``Class`` which defines the API for an object of type ``Foo``. After
``cpp_member(fxn1 Foo int bool)``, ``fxn1`` will be set to a mangled name unique
to ``Foo``'s ``fxn1`` member function (the illusion is slightly broken by the
fact that the user must dereference ``fxn1`` to define it). In the case of
``Foo``, ``fxn1`` evaluates to something like ``__fxn1_foo_int_bool__``.
The contents of the mangling are such that this particular definition of
``fxn1`` can be distinguished from other ``fxn1`` overloads which may occur in
``Foo`` or other classes in ``Foo``'s class hierarchy.

The second trick is that ``cpp_end_class(Foo)`` actually generates
implementation files for the ``Foo`` class and brings them into scope. These
files define the ``cpp_foo`` macro and the ``_cpp_foo_ctor`` function.

.. code-block:: cmake

   macro(cpp_foo _cpp_foo_mode _cpp_foo_obj)
       if("${_cpp_foo_mode}" STREQUAL "ctor")
           _cpp_foo_ctor(${ARGN})
           return()
       endif()

       _cpp_object_get_type(__cpp_foo_type "${ARGV1}")
       if(NOT "${__cpp_foo_type}" STREQUAL "foo")
            _cpp_downcast_call("cpp_${_cpp_foo_type}(${_cpp_foo_mode} ${ARGN})")
       elseif("${_cpp_foo_mode}" STREQUAL "fxn1")

           _cpp_foo_fxn1("${_cpp_foo_obj}" ${ARGN})
       endif()
   endmacro()

.. code-block:: cmake

   function(_cpp_foo_ctor _cpp_foo_obj)
       _cpp_object_ctor("${_cpp_foo_obj}")
       cpp_return("${_cpp_foo_obj}")
   endfunction()

