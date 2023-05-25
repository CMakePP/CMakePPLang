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

.. _examples-classes:

*************
Using Classes
*************

This page provides examples of creating and using classes in the CMakePP 
language.

.. _examples-classes-writing-basic-class:

Writing a Basic Class
=====================

We'll begin by writing a simple class ``Automobile`` that only contains one
attribute named ``color`` that takes the default value ``red``:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/writing_basic_class.cmake
   :lines: 3-10

Now we can instantiate a ``Automobile`` object called ``my_auto``, access its
color attribute, and print out that value:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/writing_basic_class.cmake
   :lines: 15-24
   :dedent: 4

We can also set the value of the attribute:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/writing_basic_class.cmake
   :lines: 28-37
   :dedent: 4

.. note::

   Class names are case-insensitive, so ``Automobile``, ``automobile``, and
   ``AUTOMOBILE`` are all valid ways to refer to the class, as shown in
   the last code snippet above.

See :ref:`features-classes` for more information about CMakePP classes.

.. _examples-classes-member-functions:

Adding a Member Function
========================

Next we will add a function to our class. The function will be named ``start``
and will simply print a message indicating that our ``Automobile`` has started
its engine. The updated class definition with this new function added is:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/member_functions.cmake
   :lines: 3-16

After creating an instance of the ``Automobile`` class named ``my_auto`` (as we
did in the previous example) we can call our function using the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/member_functions.cmake
   :lines: 21-27
   :dedent: 4

See :ref:`features-classes-member-functions` for more information about writing 
class member functions.

.. _examples-classes-function-arguments:

Adding a Function That Takes an Argument
========================================

Now we will add a function called ``drive`` that takes two arguments, an ``int``
and a ``str`` and prints a message using those two arguments. We can do that by
adding the following to our class:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_arguments.cmake
   :lines: 15-19
   :dedent: 4

Using our Automobile instance ``my_auto`` we can call the function in the
following way:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_arguments.cmake
   :lines: 30-33
   :dedent: 4

See :ref:`features-types` for a list and descriptions of data types 
supported by the CMakePP language and :ref:`features-classes-member-functions` 
for more information about writing class member functions.

.. note::

   The CMakePP language will throw an error if it cannot find a function whose 
   signature matches the call you are trying to make. In other words, the name 
   of the function you are calling and the types of arguments you are passing 
   in must match the function name and argument types in the function 
   definition.

.. _examples-classes-function-referencing-attributes:

Adding a Function That References Attributes
============================================

Functions can access attributes of the class they are a member of. We will add
an attribute ``km_driven`` to our class. We can then add a function
``describe_self`` that prints a message describing the color of the car and
how far it has driven. Within our function, we'll use the ``GET`` function, but
this time we'll pass a prefix and a list of attribute names. This call will get
all the attributes and store them in the current, local scope with the prefix
prepended to their name. Here is the function:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_referencing_attributes.cmake
   :lines: 24-35
   :dedent: 4

This function can be accessed in the same way as previous examples:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_referencing_attributes.cmake
   :lines: 46-49
   :dedent: 4

.. _examples-classes-return-value:

Returning a Value from a Function
=================================

We will often want to return values from functions so that we can store those
values for later use. We can modify the ``describe_self`` function we just
wrote to return a value instead of printing a message.

Returning values from a function works differently in CMake than in most
other languages. The best practice is to pass into the function the name of the
variable that you want the return value to be stored in from the parent scope
(we will refer to this name as the **return identifier**). Then, have the function
set the value of the variable with the name specified by the return identifier
in the parent scope using the ``set`` command with the ``PARENT_SCOPE`` option.
This is demonstrated by the following redefinition of ``describe_self``:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_return_value.cmake
   :lines: 24-35
   :dedent: 4

.. note::

  When we use the dereferencing expression in code comments (such as the
  comments containing "${return_id}" above) or documentation, we are referring 
  to the value contained within the variable with the name ``return_id``. In 
  other words, we mean to imply dereferencing the variable and getting its 
  value in the same way that the CMake interpreter would do so.

We can call this function and access its return value using the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_return_value.cmake
   :lines: 46-52
   :dedent: 4

.. _examples-classes-multiple-return-points:

Adding Multiple Return Points to a Function
===========================================

To include multiple return points in a function, CMake provides a `return
function <CMake return>`_ (``return()``) that forces the processing of a
function to stop when it is reached.

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_multiple_return_points_vanilla.cmake
   :lines: 24-45
   :dedent: 4

Alternatively, we can employ the ``cpp_return`` macro to create multiple return
points in a function. Additionally ``cpp_return`` also provides us with a more
concise way to return a value to the parent scope.

When we want to return from a function and return a value to the variable with
the name ``${return_id}`` to the parent scope we just need to do the following:

1. Set the value of the variable with the name ``${return_id}`` in the current
   scope to the value we want to return
2. Call ``cpp_return(${return_id})``

This will set the value of the variable with the name ``${return_id}`` in the
parent scope to that value it had in the function's scope as well as return
control to the parent scope.

Suppose we wanted our ``describe_self`` function to take in an option that
specifies whether or not it should indicate the color of itself in the
description it returns. We could accomplish this by redefining the function
as follows:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_multiple_return_points.cmake
   :lines: 24-49
   :dedent: 4

We can call the function in the following way:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_multiple_return_points.cmake
   :lines: 60-65, 68-72
   :dedent: 4

.. _examples-classes-function-overloading:

Overloading a Function
======================

We can overload a function by adding a function of the same name with a
different signature. For example, we can overload our function ``start`` by
adding a new function definition with the same name that takes one argument
instead of no arguments. This can be done by adding the following to our class
definition:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_overloading.cmake
   :lines: 18-22
   :dedent: 4

Now we can call the new function by passing in arguments with the correct types
to match the signature of the new function we wrote. In this case we need to
pass in one integer to match the new signature:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/function_overloading.cmake
   :lines: 66-70, 73-76
   :dedent: 4

.. _examples-classes-constructor-user-defined:

Adding a User-Defined Constructor
=================================

The CMakePP language allows users to define multiple custom constructors for 
classes. This is done using the ``cpp_constructor`` command. Here we add a 
constructor that takes a new color to our ``Automobile`` class:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/constructor_user_defined.cmake
   :lines: 12-16
   :dedent: 4

Multiple constructors can be added to a class. Calls to constructors will use
function resolution in the same way the member function calls do. That is when a
call is made to a constructor, the CMakePP language will attempt to find a 
constructor that matches the signature of that call and then call that 
constructor. If no matching constructor is found, an error will be thrown. The 
only exception to this is when a call is made to the constructor of a class and 
no arguments are passed. In that case, the CMakePP language will just call the 
default constructor for the class:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/constructor_user_defined.cmake
   :lines: 69-75, 78-84
   :dedent: 4

.. _examples-classes-constructor-kwargs:

Using the KWARGS Constructor
============================

The CMakePP language allows users to call a **KWARGS Constructor**. This 
constructor enables users to automatically set the values of attributes of the 
class upon construction. No constructor needs to be defined to use this 
feature. We just need to use the ``KWARGS`` keyword as the third argument to 
the call and provide a list consisting of the name of each attribute we want to 
set followed immediately by the value or values we want to set. Suppose our 
automobile class has three attributes: ``color``, ``num_doors``, and 
``owners``, along with a ``describe_self`` method to print these values:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/constructor_kwargs.cmake
   :lines: 3-34

Then we could set these upon construction using the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/constructor_kwargs.cmake
   :lines: 40-48
   :dedent: 4

This would set the value of ``color`` to ``red``, ``num_doors`` to ``4``, and
``owners`` to ``Alice;Bob;Chuck``.

.. _examples-classes-derived-class:

Writing a Derived Class
=======================

The CMakePP language supports inheritance which enables us to write 
**subclasses** that are derived from (or *inherit from*) a base class. 
Subclasses inherit all attributes and functions from their base class. However, 
subclasses can override the definitions of functions in their base classes. 
They can also override the default values of attributes that are set in the 
base class.

We can demonstrate this by creating a new ``Car`` class that is derived from our
``Automobile`` class. Our ``Car`` class will contain a new attribute
``num_doors`` and will override the ``describe_self`` method to provide a more
precise description. We can define the class by writing the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/derived_class.cmake
   :lines: 40-62

We can now create an instance of our derived ``Car`` class and access its
methods (and the methods inherited from its base class) through the ``Car``
class:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/derived_class.cmake
   :lines: 69-77, 80-83
   :dedent: 8

Alternatively we can access the methods of the ``Car`` class through
its base class ``Automobile``:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/derived_class.cmake
   :lines: 94-98, 102-105
   :dedent: 8

.. _examples-classes-multiple-inheritance:

Inheriting from Multiple Classes
================================

.. _examples-classes-multiple-inheritance-basics:

The Basics
----------

A class can inherit from multiple parent classes. Suppose we have defined the
following classes to represent **electric vehicles** and **trucks**:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_basics.cmake
   :lines: 3-15

and

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_basics.cmake
   :lines: 17-29

If we want to create a class to represent an electric truck, we can create a
new class ``ElectricTruck`` that inherits from both of these classes:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_basics.cmake
   :lines: 31-36

Then we can create an instance of ``ElectricTruck`` like we would any other
class:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_basics.cmake
   :lines: 43-44
   :dedent: 8

We can then access the attributes that are defined in each of the parent classes
like we would any other attribute:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_basics.cmake
   :lines: 46-54
   :dedent: 8

We can access the functions defined in each of the parent classes as well:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_basics.cmake
   :lines: 65-66, 68, 70-73
   :dedent: 8

.. _examples-classes-multiple-inheritance-conflicting:

Inheriting from Multiple Classes with Conflicting Attribute and Function Names
------------------------------------------------------------------------------

Inheriting from multiple classes creates the possibility of inheriting from
two or more classes that all have an attribute of the same name or a function
with the same signature. Suppose our ``ElectricVehicle`` and ``Truck`` classes
were defined with the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_conflicting.cmake
   :lines: 3-15

and

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_conflicting.cmake
   :lines: 17-29

Notice that both classes have an attribute named ``power_source`` and a function
named ``start``. Again, we can create a subclass of these two classes using the
following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_conflicting.cmake
   :lines: 36-41
   :dedent: 8

Now if we attempt to access the ``power_source`` attribute or call the 
``start`` function, the CMakePP language will search the parent classes in 
the order that they were passed to the ``cpp_class`` macro. That is, the 
CMakePP language will first look in the ``ElectricVehicle`` class for the 
attribute or function and, if it does not find the attribute for function 
there, the CMakePP language will then move on to the ``Truck`` class.

So, if we create an instance of ``ElectricTruck`` and attempt to access
``power_source`` and call ``start`` we'll get the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_conflicting.cmake
   :lines: 43-52, 55-58
   :dedent: 8

Alternatively, we could define our subclass with
``cpp_class(TruckElectric Truck ElectricVehicle)``. Note that we now placed
``Truck`` in front of ``ElectricVehicle``, so the CMakePP language will would 
look in ``Truck`` first when searching for attributes and functions:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/multiple_inheritance_conflicting.cmake
   :lines: 72-81, 84-87
   :dedent: 8

.. _examples-classes-pure-virtual-member-functions:

Adding A Pure Virtual Member Function
=====================================

The CMakePP Language allows users to define pure virtual member functions in 
base classes. These functions have no concrete implementation, but can be 
overriden by implementations in derived classes. Let's start by defining a 
``Vehicle`` class with a virtual member function ``describe_self``:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/pure_virtual_member_functions.cmake
   :lines: 3-10

Now we can define a ``Truck`` class that is derived from the ``Vehicle`` class
that overrides ``describe_self`` with an implementation:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/pure_virtual_member_functions.cmake
   :lines: 12-20

Now we can create an instance of the ``Truck`` class and call the
``describe_self`` function:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes/pure_virtual_member_functions.cmake
   :lines: 25-30, 33-36
   :dedent: 4

.. warning::

    If a call is made to the ``describe_self`` function for an instance of the
    ``Vehicle`` class, the CMakePP language will throw an error indicating that 
    this function is virtual and must be overridden in a derived class.

.. TODO finish examples of overriding objects methods
.. .. _examples-classes-overriding-object-methods:
..
.. Overriding Equals, Copy, and Serialize
.. ======================================
..
.. User classes can override the ``_cpp_object_equal``, ``_cpp_object_copy``, and
.. ``_cpp_object_serialize`` methods by defining their own implementations of these
.. functions within their class.
..
.. Calls to the ``cpp_equal``, ``cpp_copy``, and ``cpp_serialize`` functions will
.. then use the new, user-defined implementations when executing.

.. We'll show examples of overriding each of these methods below. We'll start
.. by defining with a simple class:
..
.. .. code-block:: cmake
..
..   # class def
..
.. Overriding Equals
.. -----------------
..
.. We can override  ``_cpp_object_equal``
..
.. Overriding Copy
.. ---------------
..
.. We can override  ``_cpp_object_copy``
..
.. Overriding Serialize
.. --------------------
..
.. We can override  ``_cpp_object_serialize``

.. References:

.. _CMake return: https://cmake.org/cmake/help/latest/command/return.html
