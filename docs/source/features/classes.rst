*******
Classes
*******

CMakePP enables users to define classes and create instances of the classes.
Classes in CMakePP can contain attributes and functions. CMakePP also
supports inheritance. Examples of using classes are provided in
:ref:`using-classes` the section. A basic overview of the features is provided
below.

Class Definition
================

Class definitions start with ``cpp_class(MyClass)`` where ``MyClass`` is what
you want to name the class. Class definitions are ended with ``cpp_end_class()``
(after all the class's attributes and functions have been added).

Instantiation
=============

Once a class is declared, an instance of that class can be created. An instance
of a class ``MyClass`` with the name ``my_instance`` is created using
``MyClass(CTOR my_instance)``.

Attributes
==========

CMakePP classes can contain attributes of any type. Attributes of a class are
loosely typed. No type is declared when declaring an attribute and attributes
can be assigned a value of any type, regardless of the type of their initial
value.

Attributes are added to class using ``cpp_attr(MyClass my_attr my_value)`` where
``MyClass`` is the name of the class, ``my_attr`` is the name of the attribute,
and ``my_value`` is the initial value of the attribute.

Functions
=========

CMakePP classes can contain member functions. Member functions are declared
in the same way as normal CMake functions with the addition of a ``cpp_member``
statement to declare which class the function belongs to and the types of
arguments the function takes.

Function definitions contain the following parts (listed in order):

1. ``cpp_member(my_fxn MyClass type_a type_b)`` where ``my_fxn`` is the name of
   the function, ``MyClass`` is the name of the class the function is being added
   to, and ``type_a`` and ``type_b`` are the types of the first and second
   parameters, respectively.
2. ``function(${my_fxn} self param_a param_b)`` Where ``my_fxn`` is the name of
   the function and ``param_a`` and ``param_b`` are the names of the parameters
   of the function (these parameter names correspond to their respective type
   declarations in the function signature in line above)
3. The body of the function.
4. ``endfunction()`` to end the function definition.

A function belonging to a class ``MyClass`` is called using
``MyClass(my_fxn ${my_instance} param_a param_b)`` where ``my_fxn`` is the name
of the function, ``my_instance`` is the name of an instance of the class, and
``param_a`` and ``param_b`` are the parameters being passed to the function.
CMakePP will look for a function with a name and signature that matches the
call being made. If it finds one, it will execute the function. If it does not,
it will throw an error indicating that no suitable function could be found.

Attribute Access
================

The attributes of a class are accessed via the command using the ``GET`` and
``SET`` keywords. The value of an attribute is retrieved using
``MyClass(GET ${my_instance} my_result my_attr)`` where ``my_instance`` is the
name of the instance, ``my_result`` is where the value will be stored, and
``my_attr`` is the name of the attribute being accessed.

Inheritance
===========

CMakePP classes support inheritance. A class can inherit from one or more
parent classes.

Attribute Inheritance
---------------------

A class that inherits from a parent class inherits all of the parent class's
attributes as well as the default values of those attributes. The default values
can be overridden by simply declaring an attribute of the same name in the
derived class with a new default value.

Function Inheritance
--------------------

A class that inherits from a parent class inherits all of the functions defined
in that parent class. The inherited functions can be overriden with a new
implementation in the derived class by adding a function definition with a
signature that matches the signature of the function in the parent class that is
to be overridden.

Using a Derived Class
---------------------

The attributes and functions of an instance of a derived class can be accessed
through the parent class as well as the derived class. For example if we have
class ``SubClass`` that inherits from ``ParentClass`` we could access the
attributes and functions of of ``SubClass`` with any of the following
statements:

.. code-block:: cmake

  # Access attributes through derived class and parent class
  # Access my_attr of an istance of subclass and store it in my_result
  SubClass(GET ${my_subclass_instance} my_result my_attr)
  ParentClass(GET ${my_subclass_instance} my_result my_attr)

  # Call functions through derived class and parent class
  # Call the member function my_fxn of the subclass
  SubClass(my_fxn ${my_subclass_instance})
  ParentClass(my_fxn ${my_subclass_instance})

Multiple Class Inheritance
--------------------------

A class can inherit from multiple classes. If the parent classes have
attributes or functions that have the same name, CMakePP will resolve in
the following way:

- CMakePP will check for the attribute or function in the first parent class
  passed into the ``cpp_class`` macro where the subclass is defined.
- If the attribute / function is found there it will use that
  attribute / function.
- If the attribute / function is not found, it will search in the next parent
  class that was passed into the ``cpp_class`` macro.
- CMakePP will continue searching the next parent class until the attribute /
  function is found or it runs out of parent classes to search (upon which
  an error will be thrown).

For example, if a subclass called ``SubClass`` is defined using
``cpp_class(SubClass Parent1 Parent2)``, CMakePP will search for
attributes / functions in ``Parent1`` first and then ``Parent2``.
