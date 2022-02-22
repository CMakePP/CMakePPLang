.. _using-classes:

*************
Using Classes
*************

This page provides examples of using CMakePP classes.

Writing a Basic Class
=====================

We'll begin by writing a simple class ``Automobile`` that only contains one
attribute named ``color`` that takes the default value ``red``:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_writing_basic_class.cmake
   :lines: 1-8

Now we can instantiate a ``Automobile`` object called ``my_auto``, access its
color attribute, and print out that value:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_writing_basic_class.cmake
   :lines: 10-19

We can also set the value of the attribute:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_writing_basic_class.cmake
   :lines: 21-30

See :ref:`features-classes` for more information about CMakePP classes.

Adding a Member Function
========================

Next we will add a function to our class. The function will be named ``start``
and will simply print a message indicating that our ``Automobile`` has started
its engine. The updated class definition with this new function added is:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_member_function.cmake
   :lines: 1-14

After creating an instance of the ``Automobile`` class named ``my_auto`` (as we
did in the previous example) we can call our function using the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_member_function.cmake
   :lines: 16-22

See :ref:`features-classes-member-functions` for more information about writing class 
member functions.

Adding a Function That Takes an Argument
========================================

Now we will add a function called ``drive`` that takes two arguments, an ``int``
and a ``str`` and prints a message using those two arguments. We can do that by
adding the following to our class:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_taking_argument.cmake
   :lines: 13-17
   :dedent:

Using our Automobile instance ``my_auto`` we can call the function in the
following way:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_taking_argument.cmake
   :lines: 25-28

See :ref:`features-types` for a list and descriptions of data types 
supported by CMakePPLang and :ref:`features-classes-member-functions` for 
more information about writing class member functions.

.. note::

   CMakePP will throw an error if it cannot find a function whose signature
   matches the call you are trying to make. In other words, the name of the
   function you are calling and the types of arguments you are passing in must
   match the function name and argument types in the function definition.

Adding a Function That References Attributes
============================================

Functions can access attributes of the class they are a member of. We will add
an attribute ``km_driven`` to our class. We can then add a function
``describe_self`` that prints a message describing the color of the car and
how far it has driven. Within our function, we'll use the ``GET`` function, but
this time we'll pass a prefix and a list of attribute names. This call will get
all the attributes and store them in the current scope with the prefix
prepended to their name. Here is the function:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_that_references_attributes.cmake
   :lines: 22-33
   :dedent:

This function can be accessed in the same way as previous examples:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_that_references_attributes.cmake
   :lines: 41-44

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

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_that_returns_value.cmake
   :lines: 22-33
   :dedent:

.. note::

  When we use the dereferencing expression in code comments (such as the
  comments containing "${return_id}" above) or documentation, we are referring to
  the value contained within the variable with the name ``return_id``. In other
  words, we mean to imply dereferencing the variable and getting its value in
  the same way that the CMake interpreter would do so.

We can call this function and access its return value using the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_that_returns_value.cmake
   :lines: 41-47

Adding Multiple Return Points to a Function
===========================================

We can employ the ``cpp_return`` macro to create multiple return points in a
function. Additionally ``cpp_return`` also provides us with a more concise way
to return a value to the parent scope.

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

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_multiple_return_points.cmake
   :lines: 22-47
   :dedent:

We can call the function in the following way:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_adding_function_multiple_return_points.cmake
   :lines: 55-65

Overloading a Function
======================

We can overload a function by adding a function of the same name with a
different signature. For example, we can overload our function ``start`` by
adding a new function definition with the same name that takes one argument
instead of no arguments. This can be done by adding the following to our class
definition:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_function_overloading.cmake
   :lines: 16-20
   :dedent:

Now we can call the new function by passing in arguments with the correct types
to match the signature of the new function we wrote. In this case we need to
pass in one integer to match the new signature:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_function_overloading.cmake
   :lines: 61-69

Adding a User-Defined Constructors
==================================

CMakePP allows users to define multiple custom constructors for classes. This is
done using the ``cpp_constructor`` command. Here we add a constructor that takes
two integers to our ``Automobile`` class:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_constructor_user_defined.cmake
   :lines: 10-13
   :dedent:

Multiple constructors can be added to a class. Calls to constructors will use
function resolution in the same way the member function calls do. That is when a
call is made to a constructor, CMakePP will attempt to find a constructor that
matches the signature of that call and then call that constructor. If no
matching constructor is found, an error will be thrown. The only exception to
this is when a call is made to the constructor of a class and no arguments are
passed. In that case, CMakePP will just call the default constructor for the
class.

Using the KWARGS Constructor
============================

CMakePP allows users to call a **KWARGS Constructor**. This constructor enables
users to automatically set the values of attributes of the class upon
construction. No constructor needs to be defined to use this feature. We just
need to use the ``KWARGS`` keyword as the third argument to the call and provide
a list consisting of the name of each attribute we want to set followed
immediately by the value or values we want to set. Suppose our automobile class
has three attributes: ``color``, ``num_doors``, and ``owners``. Then we could
set these upon construction using the following:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/classes_constructor_kwargs.cmake
   :lines: 40
   :dedent:

This would set the value of ``color`` to ``red``, ``num_doors`` to ``4``, and
``owners`` to ``Alice;Bob;Chuck``.

Writing a Derived Class
=======================

CMakePP supports inheritance which enables us to write **subclasses** that are
derived from (or *inherit from*) a base class. Subclasses inherit all attributes
and functions from their base class. However, subclasses can override the
definitions of functions in their base classes. They can also override the
default values of attributes that are set in the base class.

We can demonstrate this by creating a new ``Car`` class that is derived from our
``Automobile`` class. Our ``Car`` class will contain a new attribute
``num_doors`` and will override the ``describe_self`` method to provide a more
precise description. We can define the class by writing the following:

.. code-block:: cmake

  # Begin class definition
  cpp_class(Car Automobile)
    # Override the default value of the color attribute
    cpp_attr(Automobile color green)

    # Add a new attribute to the subclass
    cpp_attr(Car num_doors 4)

    # Override the "describe_self" method of the Automobile class
    cpp_member(describe_self Car str)
    function("${describe_self}" self result_id)
        Car(GET "${self}" my_color color)
        Car(GET "${self}" my_km_driven km_driven)
        Car(GET "${self}" my_num_doors num_doors)
        set("${result_id}" "I am a car with ${my_num_doors} doors, I am ${my_color}, and I have driven ${my_distance_km} km." PARENT_SCOPE)
    endfunction()

  # End class definition
  cpp_end_class()

We can now create an instance of our derived ``Car`` class and access its
methods (and the methods inherited from its base class) through the ``Car``
class:

.. code-block:: cmake

  # Create an instance of the derived class "Car"
  Car(CTOR my_car)

  # Access the overridden method "describe_self" through the derived class
  Car(describe_self "${my_car}" car_result)
  message("${car_result}")

  # Output: I am a car with 4 doors, I am green, and I have driven 0 km.

  # Access the inherited method "start" through the derived class
  Car(start "${my_car}")

  # Output: Vroom! I have started my engine.

Alternatively we can access the methods of the ``Car`` class through
its base class ``Automobile``:

.. code-block:: cmake

  # Access the overridden method "describe_self" through the base class
  Automobile(describe_self "${my_car}" auto_result)
  message("${auto_result}")

  # Output: I am a car with 4 doors, I am red, and I have driven 0 km.

  # Access the inherited method "start" through the base class
  Automobile(start "${my_car}")

  # Output: Vroom! I have started my engine.

Inheriting from Multiple Classes
================================

The Basics
----------

A class can inherit from multiple parent classes. Suppose we have defined the
following classes to represent **electric vehicles** and **trucks**:

.. code-block:: cmake

  # The ElectricVehicle class
  cpp_class(ElectricVehicle)

    # Attribute for storing battery percentage
    cpp_attr(ElectricVehicle battery_percentage 100)

    # Function for starting the vehicle
    cpp_member(drive ElectricVehicle)
    function("${drive}" self)
        message("I am driving.")
    endfunction()

  cpp_end_class()

  # The Truck class
  cpp_class(Truck)

    # Attribute for storing towing capacity
    cpp_attr(Truck towing_cap_lbs 3500)

    # Function for driving the truck
    cpp_member(tow Truck)
    function("${tow}" self)
        message("I am towing.")
    endfunction()

  cpp_end_class()

If we want to create a class to represent an electric truck, we can create a
new class ``ElectricTruck`` that inherits from both of these classes:

.. code-block:: cmake

  # Define a subclass that inherits from both parent classes
  cpp_class(ElectricTruck ElectricVehicle Truck)

    # This is an empty class that inherits methods and attributes from its parent classes

  cpp_end_class()

Then we can create an instance of ``ElectricTruck`` like we would any other
class:

.. code-block:: cmake

  # Create instance of the subclass
  ElectricTruck(CTOR my_inst)

We can then access the attributes that are defined in each of the parent classes
like we would any other attribute:

.. code-block:: cmake

  # Access the attributes of each parent class through the ElectricTruck class
  ElectricTruck(GET "${my_inst}" result1 battery_percentage)
  message("Battery percentage: ${result1}%")
  ElectricTruck(GET "${my_inst}" result2 towing_cap_lbs)
  message("Towing capactiy: ${result2} lbs")

  # Output:
  # Battery percentage: 100%
  # Towing capactiy: 3500 lbs

We can access the functions defined in each of the parent classes as well:

.. code-block:: cmake

  # Access the functions of each parent class through the ElectricTruck class
  ElectricTruck(drive "${my_inst}")
  ElectricTruck(tow "${my_inst}")

  # Output:
  # I am driving.
  # I am towing.

Inheriting from Multiple Classes with Conflicting Attribute and Function Names
------------------------------------------------------------------------------

Inheriting from multiple classes creates the possibility of inheriting from
two or more classes that all have an attribute of the same name or a function
with the same signature. Suppose our ``ElectricVehicle`` and ``Truck`` classes
were defined with the following:

.. code-block:: cmake

  # Define the ElectricVehicle class
  cpp_class(ElectricVehicle)

    # Attribute for storing the power source of the electric vehicle
    cpp_attr(ElectricVehicle power_source "100 kWh Battery")

    # Function for starting the vehicle
    cpp_member(start ElectricVehicle)
    function("${start}" self)
        message("I have started silently.")
    endfunction()

  cpp_end_class()

  # Define the Truck class
  cpp_class(Truck)

    # Attribute for storing the power source of the truck
    cpp_attr(Truck power_source "20 Gallon Fuel Tank")

    # Function for starting the truck
    cpp_member(start Truck)
    function("${start}" self)
        message("Vroom! I have started my engine.")
    endfunction()

  cpp_end_class()

Notice that both classes have an attribute named ``power_source`` and a function
named ``start``. Again, we can create a subclass of these two classes using the
following:

.. code-block:: cmake

  # Define a subclass that inherits from both parent classes
  cpp_class(ElectricTruck ElectricVehicle Truck)

    # This is an empty class that inherits methods and attributes from its parent classes

  cpp_end_class()

Now if we attempt to access the ``power_source`` attribute or call the ``start``
function, CMakePP will search the parent classes in the order that they were
passed to the ``cpp_class`` macro. That is, CMakePP will first look in the
``ElectricVehicle`` class for the attribute or function and, if it does not
find the attribute for function there, CMakePP will then move on to the
``Truck`` class.

So, if we create an instance of ``ElectricTruck`` and attempt to access
``power_source`` and call ``start`` we'll get the following:

.. code-block:: cmake

  # Create instance of the subclass
  ElectricTruck(CTOR my_inst)

  # Access the power_source attribute
  ElectricTruck(GET "${my_inst}" result power_source)
  message("Power source: ${result}")

  # Output
  # Power source: Battery
  # I have started silently.

Alternatively, we could define our subclass with
``cpp_class(ElectricTruck Truck ElectricVehicle)``. Note that the we now placed
``Truck`` in front of ``ElectricVehicle`` so CMakePP would look in ``Truck``
first when searching for attributes and functions. If we made the same calls as
above, the following output would be generated:

.. code-block:: cmake

  # Output
  # Power source: Fuel Tank
  # Vroom! I have started my engine.

Adding A Pure Virtual Member Function
=====================================

CMakePP allows users to define pure virtual member functions in base classes.
These functions have no concrete implementation but can be overriden by
implementations in derived classes. Let's start by defining a ``Vehicle`` class
with a virtual member function ``describe_self``:

.. code-block:: cmake

    # Define the Vehicle class
    cpp_class(Vehicle)

        # Add a virtual member function to be overridden by derived classes
        cpp_member(describe_self Vehicle)
        cpp_virtual_member(describe_self)

    cpp_end_class()

Now we can define a ``Truck`` class that is derived from the ``Vehicle`` class
that overrides ``describe_self`` with an implementation:

.. code-block:: cmake

    # Define the Truck class
    cpp_class(Truck Vehicle)

        cpp_member(describe_self Truck)
        function("${describe_self}" self)
            message("I am a truck!")
        endfunction()

    cpp_end_class()

Now we can create an instance of the ``Truck`` class and call the
``describe_self`` function:

.. code-block:: cmake

    # Create an instance of the Truck class and call describe_self
    Truck(CTOR my_inst)
    Truck(describe_self "${my_inst}")

    # Output: I am a truck!

.. warning::

    If a call is made to the ``describe_self`` function for an instance of the
    ``Vehicle`` class, CMakePP will throw an error indicating that this function
    is virtual and must be overridden in a derived class.

.. TODO finish examples of overriding objects methods
.. .. _overriding-object-methods:
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
