# Copyright 2023 CMakePP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import sys

import cminx

# -- Path setup --------------------------------------------------------------

dir_path = os.path.dirname(os.path.realpath(__file__))  # directory for conf.py
sys.path.insert(0,dir_path)                             # add to Python path
doc_path = os.path.dirname(dir_path)                    # path to docs dir
root_path = os.path.dirname(doc_path)                   # root dir of project
build_path = os.path.join(doc_path, 'build')            # doc build directory
src_dir  = os.path.abspath(os.path.dirname(__file__))

# -- Project Info ------------------------------------------------------------
copyright = u'2019-2020, 2022-2023, CMakePP Organization'
author = u'CMakePP Organization'
project = 'CMakePPLang'
version = '1.0.0'
release = '1.0.0alpha'

# -- General configuration ---------------------------------------------------
highlight_language = 'cmake'
templates_path = ['.templates']
source_suffix = '.rst'
master_doc = 'index'
language = 'en'
exclude_patterns = []
pygments_style = 'sphinx'
html_theme = 'sphinx_rtd_theme'
html_static_path = []
htmlhelp_basename = project + 'doc'
extensions = [
    'sphinx.ext.mathjax',
    'sphinx.ext.githubpages'
]

# -- Run CMinx on CMake Source Code -------------------------------------------

cminx_out_dir = os.path.join(src_dir, "developer", "cmakepp_lang")
cminx_in_dir = os.path.join(root_path, "cmake", "cmakepp_lang")
args = ["-s", "config.yml", "-r", cminx_in_dir]
cminx.main(args)
