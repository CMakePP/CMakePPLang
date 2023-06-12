<!--
  ~ Copyright 2023 CMakePP
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
-->

# CMakePPLang

## Summary

CMakePPLang is an object-oriented extension to the CMake language written entirely using the original CMake language
with the goal of making projects built on CMake easier to create and maintain. 
That said, CMakePPLang has different coding practices, paradigms, and standards than the native CMake language, 
much in the same way that C++ coding differs from C coding despite some level of interoperability. 
Currently, CMakePPLang is used within the CMakePP organization as the 
foundation for two in-progress projects, CMakeTest, which provides a solution
for unit testing CMake and CMakePPLang code, as well as CMaize, a CMake tool
to simplify interoperability between projects and writing their CMake
build files.


## Statement of Need

CMake is an extensible build tool that exceeds at generating build systems for many combinations of platforms, compilers, and build configurations.

CMake has become the *de facto* standard tool for building C, C++, and Fortran
programs of moderate to large size. However, as the size of a project increases, the
complexity of the CMake code to build it tends to also increase. 
In addition, as more tooling is built around CMake to make building projects with CMake
easier and less error prone, these tools will need to be designed in a
maintainable and testable way. 
The complexity of builds will also increase as
we move toward heterogeneous systems, requiring programs to leverage a
combination of CPUs, GPUs, and other specialized hardware. Object-
oriented programming excels at managing and maintaining large, complex code bases, and there
is an increasing need for this in the CMake language.

Tobias Becker recognized these issues and wrote a purely object-oriented
language on top of CMake, called CMake++ (formerly oo-cmake).
This project appears to have been abandoned, as there have only been two
commits since July 2017, both in 2021. *TLW: Need to say why you haven't started from this base.*

CMakePPLang has been developed to provide extensions to the CMake language
which provide objected-oriented functionality and other quality-of-life
improvements. The main features of CMakePPLang are the object-oriented
functionality, addition of a map structure, strong data typing, and 
backwards-compatability with CMake. These features allow for easier general
programming in CMake, which is key to writing complex build tools in the
language.

## Basic Usage
*TLW: Give a short description of the design (maybe a picture?) and then briefly discuss each of the Features mentioned above.*

## Acknowledgement
This research was supported by the Exascale Computing Project (17-SC-20-SC), a collaborative 
effort of the U.S. Department of Energy Office of Science and the National Nuclear Security Administration.
The software was developed in the NWChemEx subproject and the research was performed at the Ames National Laboratory, 
which is operated for the US DOE by Iowa State University under [Contract No. DE-AC02-07CH11358].

## References
