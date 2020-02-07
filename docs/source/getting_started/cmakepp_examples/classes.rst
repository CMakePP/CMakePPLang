*******
Classes
*******

This page provides examples of using CMakePP classes.

Write a Basic Class
===================

We'll begin by writing a simple class ``Automobile`` that only contains one
attribute named ``color`` that takes the default value ``red``:

.. code-block:: cmake

  # Begin class definition
  cpp_class(Automobile)

    # Define an attribute "color" with the default value "red"
    cpp_attr(Automobile color red)

  # End class definition
  cpp_end_class()

Now we can instantiate a ``Automobile`` object called ``my_auto``, access its
color attribute, and print out that value:

.. code-block:: cmake

  # Create an instance of the class called "my_auto"
  Automobile(CTOR my_auto)

  # Access the "color" attribute and save it to the var "my_autos_color"
  Automobile(GET ${my_auto} my_autos_color color)

  # Print out the value of the var "my_autos_color"
  message("The color of my_auto is: ${my_autos_color}")

  # Output: The color of my_auto is: red

We can also set the value of the attribute:

.. code-block:: cmake

  # Set a new value for the "color" attribute
  Automobile(SET ${my_auto} color blue)

  # Access the "color" attribute again and save it to the var "my_autos_color"
  Automobile(GET ${my_auto} my_autos_color color)

  # Print out the value of the var "my_autos_color"
  message("The color of my_auto is: ${my_autos_color}")

  # Output: The color of my_auto is: blue

Add a Member Function
=====================

Next we will add a function to our class. The function will be named ``start``
and will simply print a message indicating that our ``Automobile`` has started
its engine. The updated class definition with this new function added is:

.. code-block:: cmake

  # Begin class definition
  cpp_class(Automobile)

    # Define an attribute "color" with the value "red"
    cpp_attr(Automobile color red)

    # Define a function "start" that prints a message
    cpp_member(start Automobile)
    function(${start} self)
      message("Vroom! I have started my engine.")
    endfunction()

  # End class definition
  cpp_end_class()

After creating an instance of the ``Automobile`` class named ``my_auto`` (as we
did in the previous example) we can call our function using the following:

.. code-block:: cmake

  # Call the function using our Automobile instance
  Automobile(start ${my_auto})

  # Output: Vroom! I have started my engine.

Add a Function That Takes an Argument
=====================================

Now we will add a function called ``drive`` that takes two arguments, an ``int``
and a ``str`` and prints a message using those two arguments. We can do that by
adding the following to our class:

.. code-block:: cmake

  # Define a function "drive" that takes an int and a str and prints a message
  cpp_member(drive Automobile int str)
  function(${drive} self distance_km destination)
      message("I just drove ${distance_km} km to ${destination}!")
  endfunction()

Using our Automobile instance ``my_auto`` we can call the function in the
following way:

.. code-block:: cmake

  # Call the function and pass two arguments
  Automobile(drive ${my_auto} 10 "London")

  # Output: I just drove 10 km to London!

.. note::

   CMakePP will throw an error if it cannot find a function whose signature
   matches the call you are trying to make. In other words, the name of the
   function you are calling and the types of arguments you are passing in must
   match the function name and argument types in the function defintion.

Add a Function That References an Attribute
===========================================

Functions can access attributes of the class they are a member of. We will add
an attribute ``km_driven`` to our class. We can then add a function
``describe_self`` that prints a message describing the color of the car and
how far it has driven. This can be accomplished by adding the following to our
class definition:

.. code-block:: cmake

  # Define an attribute "km_driven" that takes a starting value of 0
  cpp_attr(Automobile km_driven 0)

  # Define a function "describe_self" that references attributes of the class
  cpp_member(describe_self Automobile)
  function(${describe_self} self)

      # Access the attributes of the class and store them into local vars
      Automobile(GET ${self} my_color color)
      Automobile(GET ${self} my_km_driven km_driven)

      # Print out a message
      message("I am an automobile, I am ${my_color}, and I have driven ${my_km_driven} km.")

  endfunction()

This function can be accessed in the same way as previous examples:

.. code-block:: cmake

  # Call the function using the instance "my_auto"
  Automobile(describe_self ${my_auto})

  # Output: I am an automobile, I am red, and I have driven 0 km.

Return a Value from a Function
==============================

We will often want to return values from functions so that we can store those
values for later use. We can modify the ``describe_self`` function we just
wrote to return a value instead of printing a message.

Returning values from a function works differently in CMake than in most
other languages. The best practice is to pass into the function the name of the
variable that you want the return value to be stored in in the parent scope
(we'll refer to this name as the **return identifier**). Then have the function
set the value of the variable with the name specified by the return identifier
in the parent scope using the ``set`` command with the ``PARENT_SCOPE`` option.
This is demonstrated by the following redefinition of ``describe_self``:

.. code-block:: cmake

  # Redefine "describe_self" to take in a return identifier
  cpp_member(describe_self Automobile str)
  function(${describe_self} self return_id)

      # Access the attributes of the class and store them into local vars
      Automobile(GET ${self} my_color color)
      Automobile(GET ${self} my_km_driven km_driven)

      # Set the value of the var with the name ${return_id} in the parent scope
      set(${return_id} "I am an automobile, I am ${my_color}, and I have driven ${my_km_driven} km." PARENT_SCOPE)

  endfunction()

.. note::

  When we use the dereferencing expression in code comments (such as the
  comments containing "${return_id}" above) or documentaton, we are referring to
  the value contained within the variable with the name ``return_id``. In other
  words, we mean to imply dereferencing the variable and getting its value in
  the same way that the CMake intepretter would do so.

We can call this function and access its return value using the following:

.. code-block:: cmake

  # Call the function and store its result in "my_result"
  Automobile(describe_self ${my_auto} my_result)

  # Print out the value of "my_result"
  message(${my_result})

  # Output: I am an automobile, I am red, and I have driven 0 km.

Add Multiple Return Points to a Function
=========================================

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

.. code-block:: cmake

  # Redefine "describe_self" to have multiple return points
  cpp_member(describe_self Automobile str bool)
  function(${describe_self} self return_id include_color)

    # Access the km_driven attribute
    Automobile(GET ${self} my_km_driven km_driven)

    if(include_color)
      # Access the color attribute
      Automobile(GET ${self} my_color color)

      # Set the value of the var with the name ${return_id} in the current scope
      set(${return_id} "I am an automobile, I am ${my_color}, and I have driven ${my_km_driven} km.")

      # Return the value and exit the function
      cpp_return(${return_id})
    endif()

    # This only executes if include_color is false
    # Set the value of the var with the name ${return_id} in the current scope
    set(${return_id} "I am an automobile and I have driven ${my_km_driven} km.")

    # Return the value and exit the function
    cpp_return(${return_id})

  endfunction()

We can call the function in the following way:

.. code-block:: cmake

  # Call the function and specify that color should be included
  Automobile(describe_self ${my_auto} my_result TRUE)
  message(${my_result})

  # Output: I am an automobile, I am red, and I have driven 0 km.

  # Call the function and specify that color should NOT be included
  Automobile(describe_self ${my_auto} my_result FALSE)
  message(${my_result})

  # Output: I am an automobile and I have driven 0 km.

Overload a Function
===================

We can overload a function by adding a function of the same name with a
different signature. For example, we can overload our function ``start`` by
adding a new function definition with the same name that takes one argument
instead of no arguments. This can be done by adding the following to our class
definition:

.. code-block:: cmake

  # Overload the "start" function
  cpp_member(start Automobile int)
  function(${start} self distance_km)
      message("Vroom! I started my engine and I just drove ${distance_km} km.")
  endfunction()

Now we can call the new function by passing in arguments with the correct types
to match the signature of the new function we wrote. In this case we need to
pass in one integer to match the new signature:

.. code-block:: cmake

  # Call the new function implementation
  Automobile(start ${my_auto} 10)

  # Output: Vroom! I started my engine and I just drove 10 km.

  # We can still call the original function implementation as well
  Automobile(start ${my_auto})

  # Output: Vroom! I started my engine.

Add a User-Defined Constructor
==============================

**TODO Create example when feature is implemented**

Add Multiple Constructors
=========================

**TODO Create example when feature is implemented**

Write a Derived Class
=====================

CMakePP supports inheritance which enables us to write **subclasses** that
inherit from a base class. Subclasses inherit all attributes and functions from
their base class. However, subclasses can override the definitions of functions
in their base classes. They can also override the default values of attributes
that are set in the base class.

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
    function(${describe_self} self result_id)
        Car(GET ${self} my_color color)
        Car(GET ${self} my_km_driven km_driven)
        Car(GET ${self} my_num_doors num_doors)
        set(${result_id} "I am a car with ${my_num_doors} doors, I am ${my_color}, and I have driven ${my_distance_km} km." PARENT_SCOPE)
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
  Car(describe_self ${my_car} car_result)
  message(${car_result})

  # Output: I am a car with 4 doors, I am green, and I have driven 0 km.

  # Access the inherited method "start" through the derived class
  Car(start ${my_car})

  # Output: Vroom! I have started my engine.

Alternatively we can access the methods of the ``Car`` class through
its base class ``Automobile``:

.. code-block:: cmake

  # Access the overridden method "describe_self" through the base class
  Automobile(describe_self ${my_car} auto_result)
  message(${auto_result})

  # Output: I am a car with 4 doors, I am red, and I have driven 0 km.

  # Access the inherited method "start" through the base class
  Automobile(start ${my_car})

  # Output: Vroom! I have started my engine.

Add A Pure Virtual Member Function
==================================

**TODO Create example when feature is implemented**
