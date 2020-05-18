******************
Exception Handling
******************

CMakePP provides commands for handling exceptions. Users can use the
``cpp_catch`` command to declare an exception type and a handler function for
that exception type. Users can then use the ``cpp_try`` to initiate a try block
and ``cpp_end_try_catch`` to end a try block. Anywhere within that try block,
an exception can be thrown using the ``cpp_raise`` command.

Basic Try-Catch Block
=====================

A basic Try-Catch Block for an exception type named ``FileNotFound`` looks like
this:

.. code-block:: cmake

    # Add an exception handler
    cpp_catch(FileNotFound)
    function("${FileNotFound}" message)
        message("FileNotFound Exception Occured")
        message("Details: ${message}")
    endfunction()

    # Begin the try block
    cpp_try()
        # If an error occurs, raise an exception and pass along details
        cpp_raise(FileNotFound "The file doesn't exist!")
    cpp_end_try_catch(FileNotFound)

Handling Multiple Types of Exceptions
=====================================

Multiple exception handlers for different types of exceptions can be declared:

.. code-block:: cmake

    # Set the value of my_key to my_value
    cpp_map(SET "${my_map}" my_key my_value)

Nested Try-Catch Blocks
=======================

Example showing nested exception handler:

.. code-block:: cmake

    # Access the value at my_key and store it in my_result
    cpp_map(GET "${my_map}" my_result my_key)
