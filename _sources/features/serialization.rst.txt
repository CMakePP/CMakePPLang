*************
Serialization
*************

The CMakePP language provides the ability to serialize objects, maps, and other
values into JSON strings via the ``cpp_serialize`` function. We will start by 
covering the serialization of maps, lists, and native CMake types since these 
are fairly simple. Finally, we'll cover the serialization of objects as their 
serialization process is a bit more complicated.

The Serialization Function
==========================

The ``cpp_serialize`` function takes two arguments in the following order:

1. The name for the variable which will hold the result **(of type desc)**
2. The value we to be serialized **(of any type)**

Serialization of Maps
=====================

Maps are serialized into JSON dictionaries (otherwise known as associative
arrays).

For example, if we want to serialize a map called ``my_map``, we could do:

.. literalinclude:: /../../tests/docs/source/features/serialization.cmake
   :lines: 8-14
   :dedent: 8

Serialization of Lists
======================

Lists are serialized into JSON lists.

For example, a list can be serialized as follows:

.. literalinclude:: /../../tests/docs/source/features/serialization.cmake
   :lines: 24-30
   :dedent: 8

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

The CMakePP language serializes objects by creating a JSON dictionary with a 
single key-value pair.

The key in this pair is the unique identifier that the CMakePP language uses
to refer to the object (the value of ``${my_obj}`` where ``my_obj`` is the name
of an obj).

The value in the pair is the serialized state of the object. The serialized
state of an **instance of a class** consists of:

1. The instance's **attributes** contained within a dictionary at the key
   ``_cpp_attrs``. Each key in this dictionary is the name of an attribute and
   points to the serialized value of that attribute.
2. The **functions** of the class that this instance belongs to are serialized
   into a dictionary at the key "_cpp_fxns". Each key in this dictionary is a
   function's symbol and points to a list of types. The types in this list are
   the types present in the functions (in order).
3. The serialized instances of the classes the instance inherits from in a
   dictionary at the key ``_cpp_sub_objs``. If this instance is of a class that
   does not inherit from another class, this will only contain an instance of
   ``obj``.

Take the following class for example:

.. literalinclude:: /../../tests/docs/source/features/serialization.cmake
   :lines: 40-60
   :dedent: 8

An instance of the ``Automobile`` class serializes into the following JSON
object:

.. code-block:: JSON

  {
    "<unique_identifier>": {
      "_cpp_attrs": {
        "color": "red",
        "num_doors": "4"
      },
      "_cpp_fxns": {
        "<automobile_start_symbol_1>": [
          "start",
          "automobile"
        ],
        "<automobile_start_symbol_2>": [
          "start",
          "automobile",
          "int"
        ],
        "<automobile_start_symbol_3>": [
          "drive",
          "automobile",
          "int",
          "str"
        ]
      },
      "_cpp_sub_objs": {
        "obj": {
          "<unique_identifier>": {
            "_cpp_attrs": {
            },
            "_cpp_fxns": {
              "<obj_equal_symbol>": [
                "equal",
                "obj",
                "desc",
                "obj"
              ],
              "<obj_serialize_symbol>": [
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

.. note::

  The content of the the angeled brackets is run-dependenent.
