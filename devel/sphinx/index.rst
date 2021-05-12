stringx: Drop-in replacements for base R string functions powered by stringi
============================================================================

    English is the native language for only 5% of the World population.
    Also, only 17% of us can understand this text. Moreover, the Latin alphabet
    is the main one for merely 36% of the total.
    The early computer era, now a very long time ago, was dominated by the US.
    Due to the proliferation of the internet, smartphones, social media,
    and other technologies and media, this is no longer the case.
    This package replaces all base R string functions with ones that fully
    support the Unicode standards related to natural language processing.
    Thanks to ICU (International Components for Unicode) and stringi,
    they are fast, reliable, and portable across different platforms.

    -- by `Marek Gagolewski <https://www.gagolewski.com/>`_




*stringx* replaces base R functions such as `paste`, `gregexpr`, `tolower`,
etc., with ones that:

* work in the same way on every platform,
* support a wide range of languages and scripts,
* fix some annoying inconsistencies in the base R functions (they are
  thoroughly documented in this online manual, happy reading!).

Also, a few (very few) new operations are introduced.


**stringx** is a set of wrappers around
`stringi <https://stringi.gagolewski.com/>`_ — a mature
`R <https://www.r-project.org/>`_ package for
fast, consistent, convenient, and portable string/text/natural language
processing in any locale that relies on
`ICU – International Components for Unicode <http://site.icu-project.org/>`_.

*stringx*'s source code is hosted on `GitHub <https://github.com/gagolews/stringx>`_.
It is distributed under the terms of the GNU General Public License,
either Version 2 or Version 3, see
`license <https://raw.githubusercontent.com/gagolews/stringx/master/LICENSE>`_.




.. toctree::
    :maxdepth: 2
    :caption: stringx

    About  <https://stringx.gagolewski.com/>


.. toctree::
    :maxdepth: 2
    :caption: Reference Manual

    rapi.md


.. toctree::
    :maxdepth: 2
    :caption: Other

    Source Code (GitHub) <https://github.com/gagolews/stringx>
    Bug Tracker and Feature Suggestions <https://github.com/gagolews/stringx/issues>
    Author's Homepage <https://www.gagolewski.com/>
    news.md

.. CRAN Entry <https://cran.r-project.org/web/packages/stringx/>


.. |downloads1| image:: https://cranlogs.r-pkg.org/badges/grand-total/stringi

.. |downloads2| image:: https://cranlogs.r-pkg.org/badges/last-month/stringi