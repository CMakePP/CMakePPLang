import os
import sys

# -- Path setup --------------------------------------------------------------

dir_path = os.path.dirname(os.path.realpath(__file__))  # directory for conf.py
sys.path.insert(0,dir_path)                             # add to Python path
doc_path = os.path.dirname(dir_path)                    # path to docs dir
root_path = os.path.dirname(doc_path)                   # root dir of project
build_path = os.path.join(doc_path, 'build')            # doc build directory

# -- Project Info ------------------------------------------------------------
copyright = u'2019, CMakePP Team'
author = u'CMakePP Team'
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
