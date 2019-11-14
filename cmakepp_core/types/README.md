Types
=====

The `types` directory contains CMake extensions for implementing strong typing
in CMakePP.

Adding New Types
----------------

To add a new intrinsic type `T`:

1. Create a file `detail_/T.cmake`.
   - In `detail_/T.cmake` define ``_cpp_is_T(<result> <string_to_analyze>)`
     - Should determine if `<string_to_analyze>` if of type `T` and return
       `TRUE` if it is and `FALSE` otherwise
2. Add `T` to `CMAKEPP_TYPE_LITERALS` `literals.cmake`
3. Add an "if"-statement to `cpp_get_type` in `cpp_get_type.cmake` for `T`
4. Add a unit test for `detail_/T.cmake` to `tests/types/detail_/T.cmake`
5. Add a section for `T` to all previously existing unit tests in
   `tests/types/detail_`
