*****************************
Writing a Basic CMakePP Class
*****************************

.. code-block:: cmake

   include(cpp/cpp)

   cpp_class(MyFirstClass)

       cpp_member(a_member_fxn MyFirstClass int bool)
       function("${a_member_fxn}" self an_int a_bool)
           message("An int and a bool: ${an_int}, ${a_bool}")
       endfunction()

   cpp_end_class()


   MyFirstClass(CTOR an_instance)
   MyFirstClass(A_MEMBER_FXN "${an_instance}" 1 TRUE)
   # Prints: "An int and a bool: 1, TRUE"
