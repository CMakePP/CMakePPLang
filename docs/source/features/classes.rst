.. Copyright 2023 CMakePP
..
.. Licensed under the Apache License, Version 2.0 (the "License");
.. you may not use this file except in compliance with the License.
.. You may obtain a copy of the License at
..
.. http://www.apache.org/licenses/LICENSE-2.0
..
.. Unless required by applicable law or agreed to in writing, software
.. distributed under the License is distributed on an "AS IS" BASIS,
.. WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
.. See the License for the specific language governing permissions and
.. limitations under the License.

.. _features-classes:

*******
Classes
*******

CMakePPLang enables users to define classes and create instances of 
the classes. Classes in CMakePPLang can contain attributes and functions.
CMakePPLang also supports inheritance. Examples of using classes are provided
in :ref:`examples-classes`. A basic overview of the features of classes are
provided below.

.. _features-classes-definition:

Class Definition
================

Class definitions start with ``cpp_class(MyClass)`` where ``MyClass`` is what
you want to name the class. CMakePPLang handles the class name, ``MyClass``
case-insensitively, so ``myclass`` and ``MYCLASS`` will also refer to the
same class created through ``cpp_class(MyClass)``. Class definitions are
ended with ``cpp_end_class()``. The following is an example of an empty
class definition:

.. literalinclude:: /../../tests/docs/source/features/classes/class_definition.cmake
   :lines: 10-16
   :dedent: 8

Optionally, users can provide the name of the class being defined to the
``cpp_end_class`` function as well:

.. literalinclude:: /../../tests/docs/source/features/classes/class_definition.cmake
   :lines: 23-29
   :dedent: 8

.. _features-classes-constructors-and-instantiation:

Constructors and Instantiation
==============================

Classes can be instantiated in a variety of ways.

.. _features-classes-default-constructor:

Default Constructor
-------------------

Once a class is declared, an instance of that class can be created by using the
default constructor for the class. No constructor definition is required. All
attributes of the class will simply take their default value. An instance of a
class ``MyClass`` with the variable name ``my_instance`` can be created using
the default constructor for the class with the following:

.. literalinclude:: /../../tests/docs/source/features/classes/class_definition.cmake
   :lines: 44-45
   :dedent: 8

.. _features-classes-custom-constructor:

Custom Constructor
------------------

Users can define custom constructors to do the initial setup of their class
upon construction. Below is an example of a class with a custom constructor
and instantiation of that class:

.. literalinclude:: /../../tests/docs/source/features/classes/class_definition.cmake
   :lines: 52-63
   :dedent: 8

Multiple constructors can be defined for a class as long as they have different
signatures. The CMakePP language will automatically find the implementation 
whose signature matches the parameters passed in and execute it.

.. _features-classes-kwargs-constructor:

KWARGS Constructor
------------------

Another way to instantiate a class is using the **KWARGS constructor**. This
constructor allows users to pass in attribute values that will be automatically
assigned for the newly constructed instance. Say we have the following class
with some attributes:

.. literalinclude:: /../../tests/docs/source/features/classes/class_definition.cmake
   :lines: 70-77
   :dedent: 8

Then we can use the **KWARGS constructor** to set the values of those attributes
upon construction using the following:

.. literalinclude:: /../../tests/docs/source/features/classes/class_definition.cmake
   :lines: 79-80
   :dedent: 8

Here the ``attr_a`` would take the value of ``1``, ``attr_b`` would take the
value of ``2;3;4``, and ``attr_c`` would take the value of ``5;6``.

.. _features-classes-attributes:

Attributes
==========

CMakePP classes can contain **attributes**. These attributes take default values
that are declared when the class is defined. An instance of a class can have
its attributes retrieved and modified from within the class or from without the
class.

.. _features-classes-attributes-typing:

Typing of Attributes
--------------------

Attributes of CMakePP classes of a class are **loosely typed**. No type is
declared when declaring an attribute, and attributes can be assigned a value of
any type, regardless of the type of their initial value.

.. _features-classes-declaring-attributes:

Declaring Attributes
--------------------

Attributes are added to class using the ``cpp_attr(MyClass my_attr my_value)``
statement where ``MyClass`` is the name of the class, ``my_attr`` is the name of
the attribute, and ``my_value`` is the initial value of the attribute. The
following is an example of a class with two attributes:

.. literalinclude:: /../../tests/docs/source/features/classes/class_attributes.cmake
   :lines: 10-18
   :dedent: 8

.. _features-classes-getting-setting-attributes:

Getting and Setting Attributes
------------------------------

The attributes of a class are accessed by using the ``GET`` and ``SET``
keywords.The value of an attribute is set using:

.. code-block:: cmake

  # Set the value of "my_attr" to "my_value"
  MyClass(SET "${my_instance}" my_attr my_value)

Here ``my_instance`` is the name of the instance whose attribute you want to
set, ``my_attr`` is where the name of the attribute you want to set, and
``my_value`` is the value you want to set the attribute to.

Attributes can be retrieved in one of two ways. The first way is to retrieve
attributes one at a time. That can be done using the following call to ``GET``:

.. code-block:: cmake

  # Retrieve the value of "my_attr" and store it in "my_result"
  MyClass(GET "${my_instance}" my_result my_attr)

Here ``my_instance`` is the name of the instance whose attribute you want to
access, ``my_result`` is where the value will be stored, and ``my_attr`` is
the name of the attribute being accessed.

Another way to get multiple attributes is to get multiple at a time and have
them returned using a prefix. This is done with a call like the following

.. code-block:: cmake

    # Get attrs and store them at _pre_attr_a, _pre_attr_b, and _pre_attr_c
    MyClass(GET "${my_instance}" _pre attr_a attr_b attr_c)

Here ``my_instance`` is the name of the instance whose attributes you want to
access, ``_pre`` is prefix that will be prepended to each attributes name to
create the variable name where the attributes will be stored in the current
scope, and ``attr_a``, ``attr_b``, and ``attr_c`` are the name of the attributes
being accessed.

.. _features-classes-member-functions:

Member Functions
================

CMakePP classes can contain **member functions**. These functions are similar to
regular CMake functions. The main differences being that they:

* belong to a CMakePP class and can only be called using an instance of that
  class
* have a **signature** that defines the types of the parameters that the
  function expects
* can be **overloaded** with multiple implementations for different signatures

.. _features-classes-defining-member-functions:

Defining Member Functions
-------------------------

Member functions are declared in the same way as normal CMake functions with
the addition of the ``cpp_member`` decorator to declare the **signature** of the
function (the name of the function and the types of the arguments it takes).
Member function definitions are structured in the following way:

.. literalinclude:: /../../tests/docs/source/features/classes/define_member_function.cmake
   :lines: 6-21
   :dedent: 4

The structure of the above function definition contains the following pieces:

1. ``cpp_member(my_fxn MyClass type_a type_b)``-- The CMakePP class member
   declaration. This decorator defines a function named ``my_fxn`` for the class
   ``MyClass``. It also indicates the number and type of parameters that the
   function takes in. In this case there are two parameters of the types
   ``type_a`` and ``type_b``.
2. ``function("${my_fxn}" self param_a param_b)``-- A CMake function declaration
   the defines a function with the name ``${my_fxn}``, sets ``self`` as the
   variable name used to reference the class instance the function was called
   with, and ``param_a`` and ``param_b`` as the variables name used to access
   the parameters passed into the function. These parameters correspond to the
   types in the ``cpp_member`` decorator.

3. The function body.

4. ``endfunction()``-- The end of the CMake function definition.

.. note::

  The reason that the ``function`` command gets the dereferenced value of
  ``my_fxn`` here is because the ``cpp_member`` decorator sets the value of
  ``my_fxn`` to a name / symbol that the CMakePP language uses to find the
  actual CMake function when a call is made to the member function ``my_fxn``
  through a CMakePP class.

  This may be a bit confusing. All you need to remember is that the
  ``cpp_member`` decorator gets the string name of the member function you want to
  declare and the ``function`` statement that follows it gets the dereferenced
  value of that name (``"${my_fxn}"`` in this case).

.. _features-classes-calling-member-functions:

Calling Member Functions
------------------------

The function ``my_fxn`` belonging to a class ``MyClass`` as defined above can
be called using:

.. code-block:: cmake

  MyClass(my_fxn "${my_instance}" "value_a" "value_b")

Here ``my_instance`` is the name of an instance of ``MyClass`` and ``"value_a"``
and ``"value_b"`` are the parameter values being passed to the function.

.. _features-classes-overloading-functions:

Function Overloading
--------------------

The CMakePP language allows for function overloading. This means users can 
define more than one implementation to a function. Each implementation simply 
needs to have a unique signature.

For example, we could declare a function ``what_was_passed_in`` with two
implementations: one that takes a single int and one that takes two ints. This
can be done in the following way:

.. literalinclude:: /../../tests/docs/source/features/classes/function_overloading.cmake
   :lines: 3-17

.. _features-classes-function-overload-resolution:

Function Overload Resolution
----------------------------

When calling a function that has multiple implementations, you simply need to
call the function with with argument(s) that match the signature of the
implementation you are trying to invoke. CMakePP will automatically find the
implementation whose signature matches the parameters passed in and execute it
(a process called **function overload resolution**). For example, we could call
the above implementations in the following way:

.. literalinclude:: /../../tests/docs/source/features/classes/function_overloading.cmake
   :lines: 22-29, 32-35
   :dedent: 4

.. note::

  If no function with a signature that matches the given parameters can be
  found, the CMakePP language will throw an error indicating this.

.. _features-classes-inheritance:

Inheritance
===========

CMakePP classes support inheritance. A class can inherit from one or more
parent classes. Classes that inherit from another class are referred to as
**derived classes**.

.. _features-classes-attribute-inheritance:

Attribute Inheritance
---------------------

A class that inherits from a parent class inherits all of the parent class's
attributes as well as the default values of those attributes. The default values
can be overridden by declaring an attribute of the same name in the
derived class with a new default value.

.. _features-classes-function-inheritance:

Function Inheritance
--------------------

A class that inherits from a parent class inherits all of the functions defined
in that parent class. The inherited functions can be overridden with a new
implementation in the derived class by adding a function definition with a
signature that matches the signature of the function in the parent class.

.. _features-classes-creating-derived-class:

Creating a Derived Class
------------------------

To create a derived class, we need a parent class that our derived class will
inherit from. We will use the following parent class:

.. literalinclude:: /../../tests/docs/source/features/classes/derived_class.cmake
   :lines: 3-21

To create a class called ``ChildClass`` that derives from ``ParentClass`` we
just need to pass ``ParentClass`` as a parameter into the ``cpp_class``
statement we use to declare ``ChildClass``. This looks like:

.. literalinclude:: /../../tests/docs/source/features/classes/derived_class.cmake
   :lines: 23-27

We can define ``ChildClass`` that:

* Keeps the inherited default value for the attribute ``size``
* Keeps the inherited implementation for the function ``another_fxn``
* Overrides the ``color`` attribute
* Overrides the member function ``my_fxn``
* Declares a new attribute ``name``
* Declares and a new member function ``new_fxn``

This can be done with the following:

.. literalinclude:: /../../tests/docs/source/features/classes/derived_class.cmake
   :lines: 29-49

.. _features-classes-using-derived-class:

Using a Derived Class
---------------------

We can create an instance of our derived class using the following:

.. literalinclude:: /../../tests/docs/source/features/classes/derived_class.cmake
   :lines: 54-55
   :dedent: 4

The **inherited** attributes and functions of the parent class can be accessed
through the derived class as well as the parent class:

.. literalinclude:: /../../tests/docs/source/features/classes/derived_class.cmake
   :lines: 57-63
   :dedent: 4

The **overidden** attributes and functions in the derived class can be through
the derived class as well as well as the parent class:

.. literalinclude:: /../../tests/docs/source/features/classes/derived_class.cmake
   :lines: 65-71
   :dedent: 4

The **newly declared** attributes and functions in the derived class that are
not present in the parent class can be accessed through the derived class as
well as the parent class:

.. literalinclude:: /../../tests/docs/source/features/classes/derived_class.cmake
   :lines: 73-81
   :dedent: 4

.. _features-classes-multiple-class-inheritance:

Multiple Class Inheritance
--------------------------

A class can inherit from multiple classes. If the parent classes both have
attributes or functions that have the same name, the CMakePP language will 
resolve in the following way:

1. CMakePP will check for the attribute or function in the first parent class
   passed into the ``cpp_class`` macro where the subclass is defined.
2. If the attribute / function is found there it will use that
   attribute / function.
3. If the attribute / function is not found, it will search in the next parent
   class that was passed into the ``cpp_class`` macro.
4. CMakePP will continue searching subsequent parent classes until the
   attribute / function is found or it runs out of parent classes to search
   (upon which an error will be thrown).

For example, if a derived class called ``ChildClass`` is defined using:

.. code-block:: cmake

  cpp_class(ChildClass ParentClass1 ParentClass2)

Then CMakePP will search for attributes / functions in ``ParentClass1`` first
and then ``ParentClass2``.

.. _features-classes-pure-virtual-member-functions:

Pure Virtual Member Functions
-----------------------------

The CMakePP language allows users to define **pure virtual member functions**. 
These are virtual functions with no implementation that can be overridden with 
an implementation in a derived class. We can create ``ParentClass`` with a
virtual member function ``my_virtual_fxn`` with the following:

.. literalinclude:: /../../tests/docs/source/features/classes/pure_virtual_member_functions.cmake
   :lines: 3-9

Now we can create a class that derives from ``ParentClass`` and overrides
``my_virtual_fxn`` called ``ChildClass``:

.. literalinclude:: /../../tests/docs/source/features/classes/pure_virtual_member_functions.cmake
   :lines: 11-19

The overridden implementation can be called with an instance of ``ChildClass``:

.. literalinclude:: /../../tests/docs/source/features/classes/pure_virtual_member_functions.cmake
   :lines: 24-27
   :dedent: 4

or using ``ParentClass`` with a ``ChildClass`` instance:

.. literalinclude:: /../../tests/docs/source/features/classes/pure_virtual_member_functions.cmake
   :lines: 31-33
   :dedent: 4

.. warning::

    If a call is made to the ``my_virtual_fxn`` function for an instance of
    ``ParentClass``, CMakePP will throw an error indicating that this function
    is virtual and must be overridden in a derived class.
