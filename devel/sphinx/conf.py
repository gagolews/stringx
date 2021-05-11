# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))

import sys
import os
import sphinx_rtd_theme
import sphinx
import matplotlib.sphinxext
import IPython.sphinxext

# -- Project information -----------------------------------------------------

project = 'stringx'
copyright = '2021, Marek Gagolewski'
author = 'Marek Gagolewski'
html_title = project
html_short_title = project

# The full version, including alpha/beta/rc tags
version = '0.1.0'  # TODO: automate
release = version

github_project_url = "https://github.com/gagolews/stringx/"
html_baseurl = "https://stringx.gagolewski.com/"


nitpicky = True
smartquotes = True
today_fmt = "%Y-%m-%d %H:%M:%S"
highlight_language = "r"

extensions = [
    'myst_parser',
    'sphinx.ext.mathjax',
    'sphinx_rtd_theme',
    #'sphinxcontrib.bibtex',
    #'numpydoc'
    #'sphinx.ext.viewcode',
    #'sphinx.ext.imgmath',
    # 'sphinx.ext.napoleon',
]

templates_path = ['_templates']

exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

todo_include_todos = True

source_suffix = ['.rst', '.md']


html_theme = 'sphinx_rtd_theme'

html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
html_show_sourcelink = False

html_theme_options = {
    'prev_next_buttons_location': 'both',
    'sticky_navigation': True,
    'display_version': True,
    'style_external_links': True,
    #'display_github': True,
    #'github_url': github_project_url,
    #'style_nav_header_background': '#ff704d',
}

html_last_updated_fmt = today_fmt
html_static_path = ['_static']
html_css_files = ['css/custom.css']


pygments_style = 'colorful'

# bibtex_bibfiles = ['bibliography.bib']
# bibtex_default_style = 'alpha'
