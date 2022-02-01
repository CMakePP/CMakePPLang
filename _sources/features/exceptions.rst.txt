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

A basic try-catch block for an exception type named ``FileNotFound`` looks like
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

    # Add two exception handlers
    cpp_catch(FileNotFound ConnectionFailure)
    function("${FileNotFound}" message)
        message("FileNotFound Exception Occured")
        message("Details: ${message}")
    endfunction()
    function("${ConnectionFailure}" message)
        message("ConnectionFailure Exception Occured")
        message("Details: ${message}")
    endfunction()

    # Begin the try block
    cpp_try()
        # Raise a FileNotFound Exception
        cpp_raise(FileNotFound "The file doesn't exist!")
        # Raise a ConnectionFailure Exception
        cpp_raise(ConnectionFailure "The file doesn't exist!")
    cpp_end_try_catch(FileNotFound)

Nested Try-Catch Blocks
=======================

If a try-catch block for an exception type is nested within a try-catch block
of the same exception type, the handler declared by the deepest try-catch
block will be called:

.. code-block:: cmake

    # Declare an exception handler for the outer try-catch block
    cpp_catch(FileNotFound)
    function("${FileNotFound}" message)
        message("Outer FileNotFound Handler")
        message("Details: ${message}")
    endfunction()

    # Begin outer try block
    cpp_try()

        # Declare an exception handler for the inner try-catch block
        cpp_catch(FileNotFound)
        function("${FileNotFound}" message)
            message("Inner FileNotFound Handler")
            message("Details: ${message}")
        endfunction()

        # Begin the inner try block
        cpp_try()
            # Raise an exception (calling the inner handler)
            cpp_raise(FileNotFound "The file doesn't exist!")
        cpp_end_try_catch(FileNotFound)

    cpp_end_try_catch(FileNotFound)

Adding Exception Handler for All Exceptions
===========================================

A general exception handler that catches all exceptions that don't have a
specific handler declared for their exception type can be declared by using the
``ALL_EXCEPTIONS`` keyword in the try-catch block:

.. code-block:: cmake

    # Add general exception handler that catches all exceptions
    cpp_catch(ALL_EXCEPTIONS)
    function("${ALL_EXCEPTIONS}" exce_type message)
        message("ALL_EXCEPTIONS handler for exception type: ${exce_type}")
        message("Exception details: ${message}")
    endfunction()

    # Raise exception for exception type with no declared handler
    cpp_raise(FileNotFound "The file doesn't exist!")

    # Remove the exception handler
    cpp_end_try_catch(ALL_EXCEPTIONS)
