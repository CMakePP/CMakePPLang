.. todo:: You might want to have a look on `PyScaffold's contributor's guide`_,

   especially if your project is open source. The text should be very similar to
   this template, but there are a few extra contents that you might decide to
   also include, like mentioning labels of your issue tracker or automated
   releases.


============
Contributing
============

Welcome to the ``CMakePPLang`` contributor's guide.

This document focuses on getting any potential contributor familiarized
with the development processes, but `other kinds of contributions`_ are also
appreciated.

If you are new to using git_ or have never collaborated in a project previously,
please have a look at `contribution-guide.org`_. Other resources are also
listed in the excellent `guide created by FreeCodeCamp`_ [#contrib1]_.

Please notice, all users and contributors are expected to be **open,
considerate, reasonable, and respectful**. When in doubt, `Python Software
Foundation's Code of Conduct`_ is a good reference in terms of behavior
guidelines.


Issue Reports
=============

If you experience bugs or general issues with ``CMakePPLang``, please have a look
on the `issue tracker`_. If you don't see anything useful there, please feel
free to submit an issue report.

.. tip::
   
   Please don't forget to include the closed issues in your search.
   Sometimes a solution was already reported, and the problem is considered
   **solved**.

New issue reports should include information about your programming environment
(e.g., operating system, CMake version) and steps to reproduce the problem.
Please try to simplify the reproduction steps to a very minimal example
that still illustrates the problem you are facing. By removing other factors,
you help us identify the root cause of the issue.


Documentation Improvements
==========================

You can help improve ``CMakePPLang`` docs by making them more readable and
coherent, or by adding missing information and correcting mistakes.

``CMakePPLang`` documentation uses Sphinx_ as its main documentation compiler.
This means that the docs are kept in the same repository as the project code,
and that any documentation update is done in the same way was a code
contribution. Documentation is written using reStructuredText_.

.. TODO:: Add instructions for building the documentation locally.

Please notice that the `GitHub web interface`_ provides a quick way of
propose changes in ``CMakePPLang``'s files. While this mechanism can
be tricky for normal code contributions, it works perfectly fine for
contributing to the docs, and can be quite handy.

If you are interested in trying this method out, please navigate to
the ``docs`` folder in the source repository_, find which file you
would like to propose changes and click in the little pencil icon at the
top, to open `GitHub's code editor`_. Once you finish editing the file,
please write a message in the form at the bottom of the page describing
which changes have you made and what are the motivations behind them and
submit your proposal.

When working on documentation changes in your local machine, you first
need to install Python_. Once you have Python, navigate to the ``docs``
directory of CMakePPLang in a terminal. Best practice is to install Python
packages in a virtual environment, so create one and activate it using the
command for your operating system:

Unix- or Linux-based system:

.. code-block:: bash

   python -m venv venv
   source venv/bin/activate

Windows system:

.. code-block:: batch

   python -m venv venv
   .\venv\Scripts\activate

Then the documentation can be built with the following command for your
operating system:

Unix- or Linux-based system:

.. code-block:: bash

   make html

Windows system:

.. code-block:: batch

   .\make.bat html

and, finally, use Python's built-in web server for a preview in your web
browser at ``http://localhost:8000``:

.. code-block:: bash

   python3 -m http.server --directory 'docs/build/html'


Code Contributions
==================

.. todo:: Please include a reference or explanation about the internals of the project.

   An architecture description, design principles or at least a summary of the
   main concepts will make it easy for potential contributors to get started
   quickly.

Submit an issue
---------------

Before you work on any non-trivial code contribution it's best to first create
a report in the `issue tracker`_ to start a discussion on the subject.
This often provides additional considerations and avoids unnecessary work.

Install Prerequisites
---------------------

Before you start coding, you will need to install CMake_.

Clone the repository
--------------------

#. Create an user account on |the repository service| if you do not already have one.
#. Fork the project repository_: click on the *Fork* button near the top of the
   page. This creates a copy of the code under your account on |the repository service|.
#. Clone this copy to your local disk::

    git clone git@github.com:YourUsername/CMakePPLang.git
    cd CMakePPLang

Implement your changes
----------------------

#. Create a branch to hold your changes::

    git checkout -b my-feature

   and start making changes. Never work on the main branch!

#. Start your work on this branch. Don't forget to add doccomments_ to new
   functions, modules and classes, especially if they are part of public APIs.

#. Add yourself to the list of contributors in ``AUTHORS.rst``.

#. When you are done editing, do::

    git add <MODIFIED FILES>
    git commit

   to record your changes in git_.

   .. important:: Don't forget to add unit tests and documentation in case your
      contribution adds an additional feature and is not just a bugfix.

      Moreover, writing a `descriptive commit message`_ is highly recommended.
      In case of doubt, you can check the commit history with::

         git log --graph --decorate --pretty=oneline --abbrev-commit --all

      to look for recurring communication patterns.

#. Please check that your changes don't break any unit tests with:

   .. code-block:: bash

      # Configure the build system (this "builds" CMakePPLang)
      cmake -H. -Bbuild -DBUILD_TESTING=ON

      # Navigate into the build directory
      cd build

      # Run the tests
      ctest -j 8 --output-on-failure --rerun-failed


Submit your contribution
------------------------

#. If everything works fine, push your local branch to |the repository service| with::

    git push -u origin my-feature

#. Go to the web page of your fork and click |contribute button|
   to send your changes for review.

Find more detailed information in `creating a PR`_. You might also want to open
the PR as a draft first and mark it as ready for review after the feedbacks
from the continuous integration (CI) system or any required fixes.


Troubleshooting
---------------

The following tips can be used when facing problems to build or test the
package:

#. Make sure to fetch all the tags from the upstream repository_.
   The command ``git describe --abbrev=0 --tags`` should return the version you
   are expecting. If you are trying to run CI scripts in a fork repository,
   make sure to push all the tags.

#. If a change you made doesn't seem to be appearing when building the
   code, try deleting the ``build`` directory to start with a clean build.


.. [#contrib1] Even though these resources focus on open source projects and
   communities, the general ideas behind collaborating with other developers
   to collectively create software are general and can be applied to all sorts
   of environments, including private companies and proprietary code bases.


.. <-- strart -->
.. todo:: Please review and change the following definitions:

.. |the repository service| replace:: GitHub
.. |contribute button| replace:: "Create pull request"

.. _repository: https://github.com/CMakePP/CMakePPLang
.. _issue tracker: https://github.com/CMakePP/CMakePPLang/issues
.. <-- end -->


.. _CMake: https://cmake.org/
.. _CMinx: https://cmakepp.github.io/CMinx/index.html
.. _contribution-guide.org: https://www.contribution-guide.org/
.. _creating a PR: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request
.. _descriptive commit message: https://chris.beams.io/posts/git-commit
.. _doccomments: https://cmakepp.github.io/CMinx/documenting/index.html
.. _first-contributions tutorial: https://github.com/firstcontributions/first-contributions
.. _git: https://git-scm.com
.. _GitHub's fork and pull request workflow: https://guides.github.com/activities/forking/
.. _guide created by FreeCodeCamp: https://github.com/FreeCodeCamp/how-to-contribute-to-open-source
.. _other kinds of contributions: https://opensource.guide/how-to-contribute
.. _PyScaffold's contributor's guide: https://pyscaffold.org/en/stable/contributing.html
.. _Python: https://www.python.org/
.. _Python Software Foundation's Code of Conduct: https://www.python.org/psf/conduct/
.. _reStructuredText: https://www.sphinx-doc.org/en/master/usage/restructuredtext/
.. _Sphinx: https://www.sphinx-doc.org/en/master/

.. _GitHub web interface: https://docs.github.com/en/repositories/working-with-files/managing-files/editing-files
.. _GitHub's code editor: https://docs.github.com/en/repositories/working-with-files/managing-files/editing-files
