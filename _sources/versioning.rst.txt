.. Copyright 2023 CMakePP
..
.. Licensed under the Apache License, Version 2.0 (the "License");
.. you may not use this file except in compliance with the License.
.. You may obtain a copy of the License at
..
.. http://www.apache.org/licenses/LICENSE-2.0
..
.. Unless required by applicable law or agreed to in writing, software
.. distributed under the License is distributed on an "AS IS" BASIS,
.. WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
.. See the License for the specific language governing permissions and
.. limitations under the License.

******************
Release Versioning
******************

CMakePPLang uses `semantic versioning <https://semver.org/>`__, often shortened
called "semver", for release versioning. In short, each release is tagged with
a version in the form: ``MAJOR.MINOR.PATCH``. The MAJOR version is incremented
when an incompatible API change is made, the MINOR version is incremented when
new functionality is added but doesn't break the API, and the PATCH version is
incremented for bug fixes that also do not break the API.

Although CMakePPLang is built on top of CMake, CMakePPLang mostly relies on
fairly fundamental features of the CMake language, so it is versioned
independently of CMake. We consider the CMakePPLang API stable regardless of
underlying changes to CMake, although changes to the CMakePPLang backend may
be necessary to account for changes in CMake. That said, if CMake ever
increments from version 3.x.x to 4.0.0 and completely overhauls the basics of
the CMake language, then we may need to go to increment to 2.0.0.

See :ref:`version-pinning` for more information about pinning a specific
CMakePPLang version in case of bugs in the latest version.
