include_guard()

#[[[ A variable containing the recognized bool literals.
#
# The variable ``CMAKEPP_BOOL_LITERALS`` contains a list of the keywords which
# are recognized by CMakePP as being boolean literals. ``CMAKEPP_BOOL_LITERALS``
# only stores the uppercase variants, but all possible case-variants are also
# boolean literals, *i.e*, ``true``, `TrUe``, `y``, etc. are all also boolean
#literals.
#]]
set(CMAKEPP_BOOL_LITERALS ON YES TRUE Y OFF NO FALSE N NOTFOUND)

#[[[ A variable containing the list of recognized CMakePP types.
#
# The content of CMAKEPP_TYPE_LITERALS is a list of the literal type for each of
# the recognized intrinsic CMakePP types. Each type is listed using the official
# abbreviation for that type (*i.e.*, the abbreviation which must be used for
# all APIs relying on the type system). Types are stored alphabetically to
# facilitate :math:`n log_2(n)` look up.
#]]
set(CMAKEPP_TYPE_LITERALS
    array bool desc path float int list map obj str target type
)
