


.. code-block:: cmake

   include(<path/to/file/that/declared/class>)
   macro(cpp_<class_type> _<class_type>_method)
       if("${_<class_type>_method}" STREQUAL <method1>)
           cpp_determine_sig(_<class_type>_sig <method> <class_type> ${ARGN})
           if("${_<class_type>_sig}" STREQUAL <overload1>)
              <overload1>(${ARGN})
           else()
              message(FATAL_ERROR "Overload does not exist")
           endif()
       elseif("${_<class_type>_method}" STREQUAL <attribute1>
           cpp_get_attr()
       else()
           message(FATAL_ERROR "Member function/attribute does not exist")
       endif()
   endmacro()
