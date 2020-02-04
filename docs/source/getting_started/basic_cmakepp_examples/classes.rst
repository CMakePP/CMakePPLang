=======
Classes
=======

---------------------
Writing a Basic Class
---------------------

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

  # Access the "color" attribute and save it to "my_autos_color"
  Automobile(GET "${my_auto}" my_autos_color color)

  # Print out the value of "my_autos_color"
  message("The color of my_auto is: ${my_autos_color}")

  # Output: The color of my_auto is: red

We can also set the value of the attribute:

.. code-block:: cmake

  # Set a new value for the "color" attribute
  Automobile(SET "${my_auto}" color "blue")

  # Access the "color" attribute again and save it to "my_autos_color"
  Automobile(GET "${my_auto}" my_autos_color color)

  # Print out the value of "my_autos_color"
  message("The color of my_auto is: ${my_autos_color}")

  # Output: The color of my_auto is: blue

---------------------------------
Adding a User-Defined Constructor
---------------------------------

**TODO Create example when feature is implemented**

----------------------------
Adding Multiple Constructors
----------------------------

**TODO Create example when feature is implemented**

------------------------
Adding a Member Function
------------------------

Next we will add a function to our class. The function will be named ``start``
and will simply return a message from our ``Automobile`` instance indicating
that it has started its engine. This function will return its value by setting
the value of the variable ``result`` in the parent scope. The updated class
definition is:

.. code-block:: cmake

  # Begin class definition
  cpp_class(Automobile)

    # Define an attribute "color" with the value "red"
    cpp_attr(Automobile color red)

    # Define a function "start" that returns a message
    cpp_member(start Automobile)
    function("${start}" self)
      # Set the value of "result" in the parent scope to our message
      set(result "Vroom! I have started my engine." PARENT_SCOPE)
    endfunction()

  # End class definition
  cpp_end_class()

After creating an instance of the ``Automobile`` class named ``my_auto`` (as we
did in the previous example) we can call our function and access its result in
the following way:

.. code-block:: cmake

  # Call the function using our Automobile instance
  Automobile(start "${my_auto}")

  # Print out the message that the function stored in "result"
  message("${result}")

  # Output: Vroom! I have started my engine.

.. note::

   Setting the value of a variable in the parent scope may seem an odd way to
   return a value from a function, but this is how that is accomplished in
   CMake.

----------------------------------------
Adding a Function That Takes an Argument
----------------------------------------

Now we will add a function called ``drive`` that takes two arguments, an ``int``
and a ``str`` and returns a message using those two arguments. We can do so by
adding the following function to our class:

.. code-block:: cmake

  # Define a function "drive" that takes an int and a str
  cpp_member(drive Automobile int str)
  function("${drive}" self distance_km destination)
      # Set the value of "result" in the parent scope to our message
      set(result "I just drove ${distance_km} km to ${destination}!" PARENT_SCOPE)
  endfunction()

Using our Automobile instance ``my_auto`` we can call the function in the
following way:

.. code-block:: cmake

  # Call the function and pass two arguments
  Automobile(drive "${my_auto}" 10 "London")

  # Print out the message that the function stored in "result"
  message("${result}")

  # Output: I just drove 10 km to London!

.. note::

   CMakePP will complain if the arguments passed to the function do not match
   the signature of the function.


----------------------------------------------
Adding a Function That References an Attribute
----------------------------------------------

Functions can access attributes of the class they are a member of. We will add
an attribute ``km_driven`` to our class. We can then add a function
``describe_self`` that returns a message describing the color of the car and
how far it has driven. This can be accomplished by adding the following to our
class definition:

.. code-block:: cmake

    # Define an attribute "km_driven" that takes a starting value of 0
    cpp_attr(Automobile km_driven 0)

    # Define a function "describe_self" that references attributes of the class
    cpp_member(describe_self Automobile)
    function("${describe_self}" self)
        # Access the attributes of the class and store them into local variables
        Automobile(GET "${self}" my_color color)
        Automobile(GET "${self}" my_distance_km distance_km)
        # Set the value of "result" in the parent scope to our message
        set(result "I am an automobile, I am ${my_color}, and I have driven a total of ${my_distance_km} km." PARENT_SCOPE)
    endfunction()


  # End class definition
  cpp_end_class()

This function can be accessed in the same way as previous examples:

.. code-block:: cmake

  # Call the function using the instance "my_auto"
  Automobile(describe_self "${my_auto}")

  # Print out the message that the function stored in "result"
  message("${result}")

  # Output: I am an automobile, I am blue, and I have driven a total of 0 km.

----------------------
Overloading a Function
----------------------

We can overload a function by adding a function of the same name with a
different signature. We can overload our function "start" by adding a new
function definition with the same name that takes one argument instead of no
arguments. This done by adding the following code to our class:

.. code-block:: cmake

  # Overload the "start" function
  cpp_member(start Automobile int)
  function("${start}" self distance_km)
      set(result "Vroom! I started my engine and I just drove ${distance_km} km." PARENT_SCOPE)
  endfunction()

Now to call the new function we simple have to call "start" and pass in
the correct argument types to match the signature of the new function we wrote:

.. code-block:: cmake

  # Call the new function definition
  Automobile(start "${my_auto}" 10)

  # Print out the message that the function stored in "result"
  message("${result}")

  # Output: Vroom! I started my engine and I just drove 10 km.

  # We can still call the original function definition as well
  Automobile(start "${my_auto}"
  message("${result}")

  # Output: Vroom! I started my engine.

-----------------------
Writing a Derived Class
-----------------------

CMakePP supports inheritance which enables us to write derived *subclasses*
of a class. We can demonstrate this by creating a new ``Car`` class that is
derived from our ``Automobile`` class. Our ``Car`` class will contain a new
attribute ``num_doors`` and will override the ``describe_self`` method to
provide a more precise description. We can define the class by writing the \
following:

.. code-block:: cmake

  # Begin class definition
  cpp_class(Car Automobile)
    # Add a new attribute to the subclass
    cpp_attr(Car num_doors 4)

    # Override the "describe_self" method of the Automobile class
    cpp_member(describe_self Car)
    function("${describe_self}" self)
        # Access the attributes of the class and store them into local variables
        Car(GET "${self}" my_color color)
        Car(GET "${self}" my_distance_km distance_km)
        # Set the value of "result" in the parent scope to our message
        set(result "I am a car with 4 doors, I am ${my_color}, and I have driven a total of ${my_distance_km} km." PARENT_SCOPE)
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
  Car(describe_self "${my_car}")
  message("${result}")

  # Output: I am a car with 4 doors, I am red, and I have driven a total of 0 km.

  # Access the inherited method "start" through the derived class
  Car(describe_self "${my_car}")
  message("${result}")

  # Output: Vroom! I have started my engine.

Alternatively we can access the methods of the ``Car`` class through
its base class ``Automobile``:

.. code-block:: cmake

  # Access the overridden method "describe_self" through the base class
  Automobile(describe_self "${my_car}")
  message("${result}")

  # Output: I am a car with 4 doors, I am red, and I have driven a total of 0 km.

  # Access the inherited method "start" through the base class
  Automobile(describe_self "${my_car}")
  message("${result}")

  # Output: Vroom! I have started my engine.
