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
* there is not "the linear ordering of strings" - a user should be able to customise it easily

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

Unicode is the future (UTF-8, UTF-16 etc.) no useBytes etc.
Python switched to UTF-8 in v3  Perl=? other=?


built on top of stringi which has proven reliable for the last 8 years
which in turn relies on ICU being widely adopted by the industry


contrary to the functions in stringi,
stringx preserves attributes,
uses the base R API (and hence aims at wider audience)
inconsistencies in base R thoroughly documented
working on stringx resulted in quite a new features in stringi implemented
(e.g., the sprintf function)

the new forward pipe operator

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


startsWith(x, prefix)                          startsWith(x, pattern=prefix, ..., ignore.case=FALSE, fixed=TRUE, prefix)
endsWith(x, suffix)                            endsWith(x, pattern=suffix, ..., ignore.case=FALSE, fixed=TRUE, suffix)
strsplit(x, split, fixed, perl, useBytes)      strsplit(x, pattern=split, ..., ignore.case=FALSE, fixed=FALSE, perl=FALSE, useBytes=FALSE, split)

sub(pattern, replacement, x, ignore.case, perl, fixed, useBytes)
gsub(pattern, replacement, x, ignore.case, perl, fixed, useBytes)

grep(pattern, x, ignore.case, perl, value, fixed, useBytes, invert)

grepl(pattern, x, ignore.case, perl, fixed, useBytes)



regexpr(pattern, text, ignore.case, perl, fixed, useBytes)

gregexpr(pattern, text, ignore.case, perl, fixed, useBytes)

regexec(pattern, text, ignore.case, perl, fixed, useBytes)

gregexec(pattern, text, ignore.case, perl, fixed, useBytes)



current limitations/main differences from base R:
* long vectors are not supported (see \link[base]{LongVectors})
* border cases (empty vectors, empty strings) and missing values handled consistently
* regex matching is based on ICU (Java-like)
* no bytes encoding supported
* different char widths
* portable locales
* some arguments can only be passed as keywords (this increases consistency
and code readability)
* names of capture groups cannot currently be extracted


## 0.1.0.9xxx (to-be >= 0.1.1) (2021-xx-yy)

* [GENERAL] On-line manual available at https://stringx.gagolewski.com.
* [GENERAL] Using *realtest* (https://realtest.gagolewski.com)
  for documenting base R behaviour, unit testing, and desired outcomes.
* [NEW FEATURE] Added constants: `letters_greek`, `digits_hex`, etc.
* [NEW FEATURE] Added functions and operators:
  `paste`, `paste0`, `strcat`, `%x+%`,
  `strrep`, `%x*%`,
  `chartr`, `tolower`, `toupper`, `casefold`,
  `chartr2`, `strtrans`,
  `sprintf`, `printf`,
  `strftime`, `strptime`,
  `nchar`, `nzchar`,
  `strtrim`,
  `trimws`,
  `startsWith`, `endsWith`,
  `strcoll`, `%x==%`, `%x!=%`, `%x<%`, `%x<=%`, `%x>%`, `%x>=%`,
  `xtfrm`, `sort`,
  `strwrap`,
  `substr`, `substring`, `substr<-`, `substring<-`,
  `strsplit`,
  `sub`, `gsub`, `sub2`, `gsub2`,
  ..`grep`, `grepl`, `grep2`, `grepl2`,
  ..`regexpr`, `gregexpr`, `regexpr2`, `gregexpr2`,
  ..`regexec`, `gregexec`, `regexec2`, `gregexec2`,
  ..utils::strcapture ???


regexpr == what does that even mean? /positions/
regexec == ? /positions+capture groups/

regexec  - POSIX has it


## 0.0.0 (2021-05-07)

* The *stringx* project has been started.
