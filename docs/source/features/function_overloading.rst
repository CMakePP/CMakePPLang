********************
Function Overloading
********************

CMakePP allows for function overloading. This means users can define more than
one implementation to a function. Each implementation simply needs to have a
unique signature.

For example we could declare a function ``what_was_passed_in`` with two
implemtations (one that takes a single int and one that takes two ints) in the
following way:

.. code-block:: cmake

  cpp_class(MyClass)

  # Define first implementation
  cpp_member(what_was_passed_in MyClass int)
  function(${what_was_passed_in} self x)
      message("${x} was passed in.")
  endfunction()

  # Define second implementation
  cpp_member(what_was_passed_in MyClass int int)
  function(${what_was_passed_in} self x y)
      message("${x} and ${y} were passed in.")
  endfunction()

  cpp_end_class()

When calling a function that has multiple implementations, you simply need to
call the function with with argument(s) that match the signature of the
implementation you are trying to invoke. CMakePP will automatically find the
implementation whose signature matches the parameters passed in and execute it.

For example, we could call the above implementations in the following way:

.. code-block:: cmake

  # Create instance of MyClass
  MyClass(CTOR my_instance)

  # Call first implementation
  MyClass(what_was_passed_in ${my_instance} 1)

  # Outputs: 1 was passed in.

  # Call second implementation
  MyClass(what_was_passed_in ${my_instance} 2 3)

  # Outputs: 2 and 3 were passed in.

.. note::

  An error will be thrown if no function with a signature that matches the given
  parameters can be found.
