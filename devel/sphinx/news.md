# What Is New in *stringx*


strings are ubiquitous in modern data science;
source of knowledge, way to represent/transfer unstructured data,
statistics is not only about numerical computing;
"language for statistical computing and graphics".. but also more broadly, data wrangling and communication of results

but also for date/time

problems at a design/API level:
* order of attributes: startsWith vs grepl
* argument/function naming
* some functions are redundant (e.g., paste0 vs paste, substring vs substr,
casefold) - some for "compatibility with S" which might have been important two decades ago
* some functions are advertised as s3 generics, but method dispatch and
methods for class character are hard-coded at C-level and therefore
cannot be overloaded (unless a generic is replaced with the one calling
UseMethod - e.g., operators like <, xtfrm

typical problems:
* recycling rule (full with warning, full no warning, only one argument etc.)
* whether objects of other types than character are allowed and be coerced
* attribute preservation
* NA handling
* empty vector handling

additional:
* portability - no longer ASCII/English latin-1/Eastern Europe-centric
depends on services provided by OS/installed libraries which of course
may vary across platforms
R string handling still rooted in the "POSIX" world https://unicode-org.github.io/icu/userguide/icu/posix.html
* speed
* conformance to Unicode standards ("contemporary string processing")
like width of certain new emojis (Unicode 13.x)
`sprintf("%.1s", "\u0105")` being not at all UTF-8 aware
* support for and accessibility of locales

built on top of stringi which has proven reliable for the last 8 years
which in turn relies on ICU being widely adopted by the industry


contrary to the functions in stringi,
stringx preserves attributes,
uses the base R API (and hence aims at wider audience)
inconsistencies in base R thoroughly documented
working on stringx resulted in quite a new features in stringi implemented
(e.g., the sprintf function)

TODO: describe coercion

TODO: describe attributes
paste - chars in, char out
sprintf - any in, char out
strrep char*numeric->char
nchar char->int
nzchar char->logi
if (!is.xxx(x)) x <- as.xxx(x)
so if as.xxx.yyy does not preserve attributes, they will be lost
you can redefine them yourself, it is up to you


x <- structure(cbind(x=1:2, y=3:4), attrib1="val1")
sqrt(x)
x <- structure(cbind(x=1:2, y=3:4), attrib1="val1")
base::nchar(x)
stringx::nchar(x)
e.g., when we say nchar is a function to compute the length
of each string, we expect a character string argument; hence,
we do you the courtesy to call as.character on your behalf
if you provide a datum of different type; as.character drops attributes,
hence if you want them to be preserved, you do it manually
like `attributes<-`(as.character(x), attributes(x))


## 0.1.0.9xxx (to-be >= 0.1.1) (2021-xx-yy)

* [NEW FEATURE] constants, e.g., `letters_greek`, `LETTERS_BB`, `digits_hex`.
* [NEW FEATURE] `paste`, `paste0`, `strcat`, `%x+%`.
* [NEW FEATURE] `strrep`, `%x*%`.
* [NEW FEATURE] `chartr`, `tolower`, `toupper`, `casefold`, `strtrans`.
* [NEW FEATURE] `sprintf`, `printf`.
* [NEW FEATURE] `strftime`, `strptime`.
* [NEW FEATURE] `nchar`, `nzchar`.
* [NEW FEATURE] `strtrim`.
* [NEW FEATURE] `trimws`.
* [NEW FEATURE] `startsWith`, `endsWith`.
* [NEW FEATURE] `strcoll`, `%x==%`, `%x!=%`, `%x<%`, `%x<=%`, `%x>%`, `%x>=%`.
* [NEW FEATURE] `xtfrm`, `sort`.
* [NEW FEATURE] `strwrap`.
* [NEW FEATURE] ..strsplit
* [NEW FEATURE] ..substr, substring + replacement
* [NEW FEATURE] ..grep, grepl + grep2 etc.
* [NEW FEATURE] ..sub, gsub
* [NEW FEATURE] ..regexpr, gregexpr
* [NEW FEATURE] ..regexec, gregexec
* [NEW FEATURE] ..utils:::strcapture


## 0.0.0 (2021-05-07)

* The *stringx* project has been started.
