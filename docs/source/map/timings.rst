***********
Performance
***********

These values are really only intended for internally tracking the performance of
the map class. The timings are not intended to be reproducible or statistically
meaningful. Timings use the stress test ``tests/stress_tests/map``.


Original Implementation - 11/17/2019
====================================

Timings were run with CMake 3.15.3, on a CentOS 7.3 desktop with an Intel Xeon
E5-2640 v4 CPU, 128 GB of RAM, and a 1 TB solid state drive. CMakePP was run in
release mode.

+----------+--------------+--------------+
| # of ops | Set Time (s) | Get Time (s) |
+==========+==============+==============+
| 1,000    | 1            | <1           |
+----------+--------------+--------------+
| 10,000   | 5            | 8            |
+----------+--------------+--------------+
| 20,000   | 17           | 30           |
+----------+--------------+--------------+
| 30,000   | 36           | 63           |
+----------+--------------+--------------+
| 40,000   | 55           | 124          |
+----------+--------------+--------------+
