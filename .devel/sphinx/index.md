# stringx: Replacements for base R string functions powered by stringi

::::{epigraph}
English is the native language for only 5% of the World population.
Also, only 17% of us can understand this text. Moreover, the Latin alphabet
is the main one for merely 36% of the total. The early computer era,
now a very long time ago, was dominated by the US. Due to the proliferation
of the internet, smartphones, social media, and other technologies
and communication platforms, this is no longer the case.
This package replaces base R string functions with ones that fully
support the Unicode standards related to natural language
and date-time processing.
Thanks to [{program}`ICU`](https://icu.unicode.org/)
(International Components for Unicode) and
[{program}`stringi`](https://stringi.gagolewski.com/),
they are fast, reliable, and portable across different platforms.
::::

[R](https://www.r-project.org/)'s ambitions go far beyond being merely the
"free software environment for statistical computing and graphics".
It has proven effective in developing whole data analysis pipelines:
from gathering information through the discovery of knowledge to
the communication of results.

**Modern data science is no longer just about number crunching.**
Text is a rich source of new knowledge — from natural language
processing to bioinformatics. It also gives powerful
means to represent or transfer unstructured data.

:::{note}
To learn more about R, check out Marek's open-access (free!) textbook
[Deep R Programming](https://deepr.gagolewski.com/).
:::


**stringx brings R string processing abilities to the 21st century.**
It replaces functions like {command}`paste`, {command}`grep`,
{command}`tolower`, {command}`strptime`, and {command}`sprintf`
with ones that:


* support a wide range of languages and scripts and
  fully conform to [Unicode](https://www.unicode.org/) standards
  (see also [this video](https://www.youtube.com/watch?v=-n2nlPHEMG8)),

* work in the same way on every platform,

* fix some long-standing inconsistencies in the base R functions
  (related to vectorisation, handling of missing values,
  preservation of attributes, order of arguments, interoperability
  with other procedures, etc.;
  they are all thoroughly documented in this online manual,
  happy reading! 🤓),

* are more forward-pipe ({command}`|>` or {command}`magrittr::%>%`)
    operator-friendly.


Also, a few new, useful operations are introduced.

```r
install.packages("stringx")  # install from CRAN
suppressMessages(library("stringx"))

c("ACTGCT", "42", "stringx \U0001f970") |> grepv2("\\p{EMOJI_PRESENTATION}")
## [1] "stringx 🥰"

toupper("gro\u00DF")  # replaces base::toupper()
## [1] "GROSS"

l <- c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2", "\U0001f602\U0001f603")
r <- c(exp(1), exp(2), pi, pi^2, NaN)
cat(sprintf("%8s=%+.3f", l, r), sep="\n")  # replaces base::sprintf()
##        e=+2.718
##       e²=+7.389
##        π=+3.142
##       π²=+9.870
##     😂😃= NaN
```

<!--
% COMMENT
%
% but we do not aim to fix the whole nam.ING_meSS
%
% 99% compatible (cannot be 100% as they use a different regex engine,
% for example, and some inconsistencies are quite obvious and can be a push
% for a change in the right direction)
%
% * collator - portable (locales),  Unicode-correct (normalisation)
% * date/time - portable (locales)
% * iconv - portable
% * regex - Unicode-correct, portable
% * speed
%
% TODO: mention https://unicode-org.github.io/icu/userguide/icu/posix.html
-->


{program}`stringx` is a set of wrappers around
[{program}`stringi`](https://stringi.gagolewski.com/) — a mature
[R](https://www.r-project.org/) package for
fast, consistent, convenient, and portable string/text/natural language
processing in any locale that relies on
[{program}`ICU` – International Components for Unicode](https://icu.unicode.org/).



{program}`stringx`'s source code is hosted on
[GitHub](https://github.com/gagolews/stringx). Its official releases
are available on [CRAN](https://cran.r-project.org/package=stringx).
It is distributed under the terms of the GNU General Public License,
either Version 2 or Version 3; see
[license](https://raw.githubusercontent.com/gagolews/stringx/master/LICENSE).



```{toctree}
:caption: stringx
:hidden: true
:maxdepth: 2

About <self>
Author <https://www.gagolewski.com/>
Source Code (GitHub) <https://github.com/gagolews/stringx>
Bug Tracker and Feature Suggestions <https://github.com/gagolews/stringx/issues>
CRAN Entry <https://cran.r-project.org/package=stringx>
```

```{toctree}
:caption: Reference Manual
:glob: true
:hidden: true
:maxdepth: 1

rapi/*
```
<!--
% rapi.md
-->


```{toctree}
:caption: Other
:hidden: true
:maxdepth: 1

Deep R Programming <https://deepr.gagolewski.com/>
stringi <https://stringi.gagolewski.com/>
news.md
```

<!--
% COMMENT
% .. |downloads1| image:: https://cranlogs.r-pkg.org/badges/grand-total/stringx
% .. |downloads2| image:: https://cranlogs.r-pkg.org/badges/last-month/stringx
-->
