# Copyleft (C) 2021-2023, Marek Gagolewski <https://www.gagolewski.com/>
# Configuration file for the Sphinx documentation builder.

import sys, os
sys.path.append(os.getcwd())

import re
def get_package_version():
    with open("../../DESCRIPTION") as f:
        return re.search(r'Version:[ ]*([0-9.-]+)', f.read()).group(1)

pkg_name = "stringx"
pkg_title = "stringx"
pkg_version = get_package_version()
copyright_year = "2021–2023"
html_baseurl = "https://stringx.gagolewski.com/"
html_logo = "https://www.gagolewski.com/_static/img/stringx.png"
html_favicon = "https://www.gagolewski.com/_static/img/stringx.png"
github_url = "https://github.com/gagolews/stringx"
github_star_repo = "gagolews/stringx"
analytics_id = None  # don't use it! this site does not track its users
author = "Marek Gagolewski"
copyright = f"{copyright_year}"
html_title = f"R Package {pkg_title}"
html_short_title = f"{pkg_title}"

html_version_text = f'\
    R Package<br />\
    v{pkg_version}'


pygments_style = 'default'  #'trac' - 'default' is more readable for some
project = f'{pkg_title}'
version = f'by {author}'
release = f'{pkg_version}'

nitpicky = True
smartquotes = True
today_fmt = "%Y-%m-%dT%H:%M:%S%Z"
highlight_language = "python"
html_last_updated_fmt = today_fmt















extensions = [
    'myst_parser',
    'sphinx.ext.mathjax',
    'sphinxcontrib.bibtex',
]













myst_enable_extensions = [
    "colon_fence",
    "dollarmath",
    "deflist",
    "strikethrough",  # HTML only
]

suppress_warnings = ["myst.strikethrough"]

templates_path = ['_templates']

exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

todo_include_todos = True

source_suffix = ['.md', '.rst']

numfig = True
numfig_format = {
    'figure': 'Figure %s',
    'table': 'Table %s',
    'code-block': 'Listing %s',
    'section': 'Section %s'
}
numfig_secnum_depth = 0

html_theme = 'furo'

html_show_sourcelink = True

html_static_path = ['_static']
html_css_files = ['css/custom.css']

html_scaled_image_link = False

html_theme_options = {

    # https://pradyunsg.me/furo/customisation/
    'sidebar_hide_name': False,
    'navigation_with_keys': False,
    'top_of_page_button': "edit",
    "source_edit_link": f"{github_url}/issues/",
    #'footer_icons': ...,
    #'announcement': ...,


    # https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties
    # https://github.com/pradyunsg/furo/tree/main/src/furo/assets/styles/variables

    "light_css_variables": {
        "admonition-font-size": "95%",
        "admonition-title-font-size": "95%",
        # let each project have a different colour theme!
        "color-brand-primary": "#274641",
        "color-brand-content": "#2f7889",
    },

    "dark_css_variables": {
        "admonition-font-size": "95%",
        "admonition-title-font-size": "95%",
        # let each project have a different colour theme!
        "color-brand-primary": "#a8e3f0",
        "color-brand-content": "#f2f2a0",
    },
}


# BibTeX biblography + Marek's custom pybtex style
import alphamarek
bibtex_default_style = "alphamarek"
bibtex_bibfiles = ["bibliography.bib"]
