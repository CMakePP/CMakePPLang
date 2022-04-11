include_guard()

string(ASCII 5 _scl_enquiry)
string(ASCII 6 _scl_acknowledge)
string(ASCII 7 _scl_bell)
string(ASCII 16 _scl_data_link_escape)
string(ASCII 17 _scl_device_control_1)
string(ASCII 18 _scl_device_control_2)
string(ASCII 19 _scl_device_control_3)
string(ASCII 20 _scl_device_control_4)

cpp_map(CTOR special_chars_lookup
    "dquote" "${_scl_enquiry}"
    "dollar" "${_scl_acknowledge}"
    "scolon" "${_scl_bell}"
    "bslash" "${_scl_data_link_escape}"
)
