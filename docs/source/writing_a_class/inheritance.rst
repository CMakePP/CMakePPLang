*****************
Basic Inheritance
*****************

.. code-block:: cmake

   include(cpp/cpp)

   cpp_class(BaseClass)

       cpp_member(say_hi BaseClass)
       function("${say_hi}" self)
           message("Hello from base class")
       endfunction()

   cpp_end_class()

   cpp_class(DerivedClass BaseClass)

       cpp_member(say_hi DerivedClass)
       function("${say_hi}" self)
           message("Hello from derived class")
       endfunction()

   cpp_end_class()

   BaseClass(CTOR a_base)
   DerivedClass(CTOR a_derived)

   # Prints: "Hello from base class"
   BaseClass(SAY_HI "${a_base}")

   # Prints: "Hello from derived class"
   BaseClass(SAY_HI "${a_derived}")

   # Error not a DerivedClass
   # DerivedClass(SAY_HI "${a_base}")

   # Prints: "Hello from derived class"
   DerivedClass(SAY_HI "${a_derived}")
