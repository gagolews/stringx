# What Is New in *stringx*


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
* [NEW FEATURE] ..substr, substring + replacement
* [NEW FEATURE] ..gregexpr
* [NEW FEATURE] ..grepl
* [NEW FEATURE] ..regexpr, gregexpr
* [NEW FEATURE] ..regexec, gregexec
* [NEW FEATURE] ..sub, gsub
startsWith, endsWith
* [NEW FEATURE] ..strsplit
* [NEW FEATURE] ..strwrap
* [NEW FEATURE] ..trimws
* [NEW FEATURE] ..strcmp/strcoll
xtfrm
iconv, iconvlist
readLines, writeLines, ??


## 0.0.0 (2021-05-07)

* The *stringx* project has been started.
