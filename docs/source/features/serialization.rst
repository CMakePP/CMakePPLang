.. *************
Serialization
*************

CMakePP provides the ability to serialize objects, maps, and other values into
JSON strings via the ``cpp_serialize`` function. We will start by covering the
serialization of maps, lists, and native CMake types since these are fairly
simple. Lastly, we'll cover the serialization of objects as their serialization
process is a bit more complicated.

The Serialization Function
==========================

The ``cpp_serialize`` function takes two arguments in the following order:

1. The name for the variable which will hold the result **(of type desc)**
2. The value we to be serialized **(of any type)**

Serialization of Maps
=====================

Maps are serialized into JSON dictionaries (otherwise known as associative
arrays).

For example a map created with
``cpp_map(CTOR my_map key_a value_a key_b value_b)`` serializes to
``{ "key_a" : "value_a", "key_b" : "value_b" }``

Serialization of Lists
======================

Lists are serialized into JSON lists.

For example ``"this;is;a;list"`` serializes to
``[ "this", "is", "a", "list" ]``

Serialization of other Native CMake Types
=========================================

All values of other types are serialized into simple JSON strings.

+--------------------+--------------------------+--------------------------+
| Type               | Example                  | Result of Serialization  |
+====================+==========================+==========================+
| Regular String     | ``string``               | ``"string"``             |
+--------------------+--------------------------+--------------------------+
| String with Spaces | ``"string with spaces"`` | ``"string with spaces"`` |
+--------------------+--------------------------+--------------------------+
| Booleans           | ``TRUE``                 | ``"TRUE"``               |
+--------------------+--------------------------+--------------------------+
| Int                | ``123``                  | ``"123"``                |
+--------------------+--------------------------+--------------------------+
| Float              | ``1.23``                 | ``"1.23"``               |
+--------------------+--------------------------+--------------------------+
| Command            | ``add_subdirectories``   | ``"add_subdirectories"`` |
+--------------------+--------------------------+--------------------------+
| Path               | ``/path/to/file.txt``    | ``"/path/to/file.txt"``  |
+--------------------+--------------------------+--------------------------+
| Type               | ``bool``                 | ``"bool"``               |
+--------------------+--------------------------+--------------------------+
| Target             | ``lib``                  | ``"lib"``                |
+--------------------+--------------------------+--------------------------+

.. TODO potentially add generator expressions to this list

Serialization of Objects
========================

CMakePP serializes objects by creating a JSON dictionary with a single
key-value pair.

The key in this pair is the unique identifier that CMakePP uses
to refer to the object (the value of ``${my_obj}`` where ``my_obj`` is the name
of an obj).

The value in the pair is the serialized state of the object. The serialized
state of an **instance of a class** consists of:

1. The instance's **attributes** contained within a dictionary at the key
   ``_cpp_attrs``. Each key in this dictionary is the name of an attribute and
   points to the serialized value of that attribute.
2. The **functions** of the class that this instance belongs to are serialized into
   a dictionary at the key "_cpp_fxns". Each key in this dictionary takes the
   form of ``_cpp_*CLASSNAME*_*FUNCTIONNAME*_*ARGNTYPE*_`` and each points to
   a list of types. This list contains the types present in the functions
   signature (in order).
3. The serialized instances of the classes the instance inherits from in a
   dictionary at the key ``_cpp_sub_objs``. If this instance is of a class
   that does not inherit from another class, this will only contain an
   instance of ``obj``.

Take the following class for example:

.. code-block:: cmake

  cpp_class(Automobile)

      cpp_attr(Automobile color red)
      cpp_attr(Automobile num_doors 4)

      cpp_member(start Automobile)
      function("${start}" self)
          set(result "Vroom! I have started my engine." PARENT_SCOPE)
      endfunction()

      cpp_member(start Automobile int)
      function("${start}" self distance_km)
          set(result "Vroom! I started my engine and I just drove ${distance_km} km!" PARENT_SCOPE)
      endfunction()

      cpp_member(drive Automobile int str)
      function("${drive}" self distance_km destination)
          set(result "I just drove ${distance_km} km to ${destination}!" PARENT_SCOPE)
      endfunction()

  cpp_end_class()

An instance of the ``Automobile`` class serializes into the following JSON
object:

.. code-block:: JSON

  {
    "nuop7_1581040712": {                             # Unique ID of the instance
      "_cpp_attrs": {                                 # Its attributes
        "color": "red",
        "num_doors": "4"
      },
      "_cpp_fxns": {                                  # Its functions
        "_cpp_automobile_start_automobile_": [
          "start",
          "automobile"
        ],
        "_cpp_automobile_start_automobile_int_": [
          "start",
          "automobile",
          "int"
        ],
        "_cpp_automobile_drive_automobile_int_str_": [
          "drive",
          "automobile",
          "int",
          "str"
        ]
      },
      "_cpp_sub_objs": {                              # The classes it inherits from
        "obj": {
          "urqsk_1581040712": {
            "_cpp_attrs": {
            },
            "_cpp_fxns": {
              "_cpp_obj_equal_obj_desc_obj_": [
                "equal",
                "obj",
                "desc",
                "obj"
              ],
              "_cpp_obj_serialize_obj_desc_": [
                "serialize",
                "obj",
                "desc"
              ]
            },
            "_cpp_sub_objs": {
            },
            "_cpp_my_type": "obj"
          }
        }
      },
      "_cpp_my_type": "automobile"
    }
  }
