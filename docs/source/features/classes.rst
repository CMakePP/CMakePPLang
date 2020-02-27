*******
Classes
*******

CMakePP enables users to define classes and create instances of the classes.
Classes in CMakePP can contain attributes and functions. CMakePP also
supports inheritance. Examples of using classes are provided in the
:ref:`using-classes` the section. A basic overview of the features of classes
are provided below.

Class Definition
================

Class definitions start with ``cpp_class(MyClass)`` where ``MyClass`` is what
you want to name the class. Class definitions are ended with
``cpp_end_class()``. The following is an example of an empty class definition:

.. code-block:: cmake

  # Begin class definition of class MyClass
  cpp_class(MyClass)

    # Class attribute and functions go here

  # End class definition
  cpp_end_class()

Instantiation
=============

Once a class is declared, an instance of that class can be created. For example
an instance of a class ``MyClass`` with the variable name ``my_instance`` can be
created using the following:

.. code-block:: cmake

  # Create an instance of MyClass with the name "my_instance"
  MyClass(CTOR my_instance)

Attributes
==========

CMakePP classes can contain **attributes**. These attributes take default values
that are declared when the class is defined. An instance of a class can have
its attributes retrieved and modified from within the class or from without the
class.

Typing of Attributes
--------------------

Attributes of CMakePP classes of a class are **loosely typed**. No type is
declared when declaring an attribute, and attributes can be assigned a value of
any type, regardless of the type of their initial value.

Declaring Attributes
--------------------

Attributes are added to class using the ``cpp_attr(MyClass my_attr my_value)``
statement where ``MyClass`` is the name of the class, ``my_attr`` is the name of
the attribute, and ``my_value`` is the initial value of the attribute. The
following is an example of a class with two attributes:

.. code-block:: cmake

  cpp_class(MyClass)

    # Declare an attribute "color" with the default value "red"
    cpp_attr(MyClass color red)

    # Declare an attribute "size" with the default value "10"
    cpp_attr(MyClass size 10)

  cpp_end_class()

Getting and Setting Attributes
------------------------------

The attributes of a class are accessed by using the ``GET`` and ``SET``
keywords. The value of an attribute is retrieved using:

.. code-block:: cmake

  # Retrieve the value of "my_attr" and store it in "my_result"
  MyClass(GET "${my_instance}" my_result my_attr)

Here ``my_instance`` is the name of the instance whose attribute you want to
access, ``my_result`` is where the value will be stored, and ``my_attr`` is
the name of the attribute being accessed.

The value of an attribute is set using:

.. code-block:: cmake

  # Set the value of "my_attr" to "my_value"
  MyClass(SET "${my_instance}" my_attr my_value)

Here ``my_instance`` is the name of the instance whose attribute you want to
set, ``my_attr`` is where the name of the attribute you want to set, and
``my_value`` is the value you want to set the attribute to.

Member Functions
================

CMakePP classes can contain **member functions**. These functions are similar to
regular CMake functions. The main differences being that they:

* belong to a CMakePP class and can only be called using an instance of that
  class
* have a **signature** that defines the types of the parameters that the
  function expects
* can be **overloaded** with multiple implementations for different signatures

Defining Member Functions
-------------------------

Member functions are declared in the same way as normal CMake functions with
the addition of the ``cpp_member`` statement to declare the **signature** of the
function (the name of the function and the types of the arguments it takes).
Member function definitions are structured in the following way:

.. code-block:: cmake

  cpp_class(MyClass)

    cpp_member(my_fxn MyClass type_a type_b)
    function("${my_fxn}" self param_a param_b)

      # The body of the function

      # ${self} can be used to access the instance of MyClass
      # the function is being called with

      # ${param_a} and ${param_b} can be used to access the
      # values of the parameters passed into the function

    endfunction()

  cpp_end_class()

The structure of the above function definition contains the following pieces:

1. ``cpp_member(my_fxn MyClass type_a type_b)``-- The CMakePP class member
   declaration. This statement defines a function named ``my_fxn`` for the class
   ``MyClass``. The statement also indicates the number and type of parameters
   that the function takes in. In this case there are two parameters of the
   types ``type_a`` and ``type_b``.
2. ``function("${my_fxn}" self param_a param_b)``-- A CMake function declaration
   the defines a function with the name ``${my_fxn}``, sets ``self`` as the
   variable name used to reference the class instance the function was called
   with, and ``param_a`` and ``param_b`` as the variables name used to access
   the parameters passed into the function. These parameters correspond to the
   types in the ``cpp_member`` statement.

3. The function body.

4. ``endfunction()``-- The end of the CMake function definition.

.. note::

  The reason that the ``function`` command gets the dereferenced value of
  ``my_fxn`` here is because the ``cpp_member`` command sets the value of
  ``my_fxn`` to a name / symbol that the CMakePP language uses to find the
  actual CMake function when a call is made to the member function ``my_fxn``
  through a CMakePP class.

  This may be a bit confusing. All you need to remember is that the
  ``cpp_member`` command gets the string name of the member function you want to
  declare and the ``function`` statement that follows it gets the dereferenced
  value of that name (``"${my_fxn}"`` in this case).

Calling Member Functions
------------------------

The function ``my_fxn`` belonging to a class ``MyClass`` as defined above can
be called using:

.. code-block:: cmake

  MyClass(my_fxn "${my_instance}" "value_a" "value_b")

Here ``my_instance`` is the name of an instance of ``MyClass`` and ``"value_a"``
and ``"value_b"`` are the parameter values being passed to the function.

Function Overloading
--------------------

CMakePP allows for function overloading. This means users can define more than
one implementation to a function. Each implementation simply needs to have a
unique signature.

For example we could declare a function ``what_was_passed_in`` with two
implementations: one that takes a single int and one that takes two ints. This
can be done in the following way:

.. code-block:: cmake

  cpp_class(MyClass)

    # Define first implementation
    cpp_member(what_was_passed_in MyClass int)
    function("${what_was_passed_in}" self x)
        message("${x} was passed in.")
    endfunction()

    # Define second implementation
    cpp_member(what_was_passed_in MyClass int int)
    function("${what_was_passed_in}" self x y)
        message("${x} and ${y} were passed in.")
    endfunction()

  cpp_end_class()

Function Overload Resolution
----------------------------

When calling a function that has multiple implementations, you simply need to
call the function with with argument(s) that match the signature of the
implementation you are trying to invoke. CMakePP will automatically find the
implementation whose signature matches the parameters passed in and execute it
(a process called **function overload resolution**). For example, we could call
the above implementations in the following way:

.. code-block:: cmake

  # Create instance of MyClass
  MyClass(CTOR my_instance)

  # Call first implementation
  MyClass(what_was_passed_in "${my_instance}" 1)

  # Outputs: 1 was passed in.

  # Call second implementation
  MyClass(what_was_passed_in "${my_instance}" 2 3)

  # Outputs: 2 and 3 were passed in.

.. note::

  If no function with a signature that matches the given parameters can be
  found, CMakePP will throw an error indicating this.

Inheritance
===========

CMakePP classes support inheritance. A class can inherit from one or more
parent classes. Classes that inherit from another class are referred to as
**derived classes**.

Attribute Inheritance
---------------------

A class that inherits from a parent class inherits all of the parent class's
attributes as well as the default values of those attributes. The default values
can be overridden by simply declaring an attribute of the same name in the
derived class with a new default value.

Function Inheritance
--------------------

A class that inherits from a parent class inherits all of the functions defined
in that parent class. The inherited functions can be overridden with a new
implementation in the derived class by adding a function definition with a
signature that matches the signature of the function in the parent class.

Creating a Derived Class
------------------------

To create a derived class, we need a parent class that our derived class will
inherit from. We will use the following parent class:

.. code-block:: cmake

  cpp_class(ParentClass)

    # Declare some attributes with default values
    cpp_attr(ParentClass color red)
    cpp_attr(ParentClass size 10)

    # Declare a function taking some parameters
    cpp_member(my_fxn ParentClass type_a type_b)
    function("${my_fxn}" self param_a param_b)
      # Function body
    endfunction()

    # Declare a function taking no parameters
    cpp_member(another_fxn ParentClass)
    function("${another_fxn}" self)
      # Function body
    endfunction()

  cpp_end_class()

To create a class called ``ChildClass`` that derives from ``ParentClass`` we
just need to pass ``ParentClass`` as a parameter into the ``cpp_class``
statement we use to declare ``ChildClass``. This looks like:

.. code-block:: cmake

  cpp_class(ChildClass ParentClass)

    # Derived class definition

  cpp_end_class()

We can define ``ChildClass`` that:

* Keeps the inherited default value for the attribute ``size``
* Keeps the inherited implementation for the function ``another_fxn``
* Overrides the ``color`` attribute
* Overrides the member function ``my_fxn``
* Declares a new attribute ``name``
* Declares and a new member function ``new_fxn``

This can be done with the following:

.. code-block:: cmake

  cpp_class(ChildClass ParentClass)

    # Override the default value "color" attribute
    cpp_attr(ChildClass color blue)

    # Add a new attribute "name" belonging to ChildClass
    cpp_attr(ChildClass name "My Name")

    # Override the "my_fxn" function
    cpp_member(my_fxn ChildClass type_a type_b)
    function("${my_fxn}" self param_a param_b)
      # Function body with different implementation
    endfunction()

    # Add a new function "new_fxn" belonging to ChildClass
    cpp_member(new_fxn ChildClass)
    function("${new_fxn}" self)
      # Function body
    endfunction()

  cpp_end_class()

Using a Derived Class
---------------------

We can create an instance of our derived class using the following:

.. code-block:: cmake

  # Create an instance of ChildClass
  ChildClass(CTOR child_instance)

The **inherited** attributes and functions of the parent class can be accessed
through the derived class as well as the parent class:

.. code-block:: cmake

  # Access an inherited attribute through the derived class and parent class
  ChildClass(GET "${child_instance}" my_result size)
  ParentClass(GET "${child_instance}" my_result size)

  # Access an inherited function through the derived class and parent class
  ChildClass(another_fxn "${child_instance}")
  ParentClass(another_fxn "${child_instance}")

The **overidden** attributes and functions in the derived class can be through
the derived class as well as well as the parent class:

.. code-block:: cmake

  # Access an overridden attribute through the derived class and parent class
  ChildClass(GET "${child_instance}" my_result color)
  ParentClass(GET "${child_instance}" my_result color)

  # Access an overridden function through the derived class and parent class
  ChildClass(my_fxn "${child_instance}" "value_a" "value_b")
  ParentClass(my_fxn "${child_instance}" "value_a" "value_b")

The **newly declared** attributes and functions in the derived class that are
not present in the parent class can be accessed through the derived class as
well as the parent class:

.. code-block:: cmake

  # Access a newly declared attribute that is present in ChildClass and not
  # ParentClass through the derived class and parent class
  ChildClass(GET "${child_instance}" my_result name)
  ParentClass(GET "${child_instance}" my_result name)

  # Access a newly declared function that is present in ChildClass and not
  # ParentClass through the derived class and parent class
  ChildClass(new_fxn "${child_instance}")
  ParentClass(new_fxn "${child_instance}")

Multiple Class Inheritance
--------------------------

A class can inherit from multiple classes. If the parent classes both have
attributes or functions that have the same name, CMakePP will resolve in
the following way:

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
