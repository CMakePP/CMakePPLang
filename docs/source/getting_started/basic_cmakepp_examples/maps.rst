====
Maps
====

---------------------
Creating an Empty Map
---------------------

We can construct a map with no initial key-value pairs in the following way:

.. code-block:: cmake

  # Construct an empty map called "my_map"
  cpp_map(CTOR my_map)

----------------------------
Storing and Accessing Values
----------------------------

We can then store new values and access those values in the following way:

.. code-block:: cmake

  # Set some new values
  cpp_map(SET "${my_map}" myKeyA myValueA)
  cpp_map(SET "${my_map}" myKeyB myValueB)

  # Access the values and store them in "resultA" and "resultB"
  cpp_map(GET "${my_map}" resultA myKeyA)
  cpp_map(GET "${my_map}" resultB myKeyB)

  # Print the values out
  message("resultA: ${resultA}")
  message("resultB: ${resultB}")

  # Output:
  # resultA: myValueA
  # resultB: myValueB

----------------------------------
Creating a Map with Initial Values
----------------------------------

We can also create a map with initial values by passing key-value pairs to the
constructor in the following way:

.. code-block:: cmake

  # Construct a map with initial key value pairs:
  # [myKeyA->myValueA, myKeyB->myValueB]
  cpp_map(CTOR my_map myKeyA myValueA myKeyB myValueB)

  # Access the values and store them in "resultA" and "resultB"
  cpp_map(GET "${my_map}" resultA myKeyA)
  cpp_map(GET "${my_map}" resultB myKeyB)

  # Print the values out
  message("resultA: ${resultA}")
  message("resultB: ${resultB}")

  # Output:
  # resultA: myValueA
  # resultB: myValueB
