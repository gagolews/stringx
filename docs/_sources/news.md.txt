# What Is New in *stringx*

> Note that the date-time processing functions in *stringx* are a work
> in progress. Feature requests/comments/remarks are welcome,
> see https://github.com/gagolews/stringx/issues.


## 0.2.2 (2021-09-03)

* [DOCUMENTATION] ICU Project site has been moved to <https://icu.unicode.org/>.


## 0.2.1 (2021-08-27)

* [BACKWARD INCOMPATIBILITY, BUGFIX] #7: Dates without times are now always
    treated as being at midnight in the local (default) time zone.

* [BACKWARD INCOMPATIBILITY] Date-time functions now yield objects
    of class `POSIXxt`, which extend upon `POSIXct` (and allow for custom
    formatting etc.).

* [BACKWARD INCOMPATIBILITY, BUGFIX] #7: `strftime` uses the `tzone` attribute
    by default.

* [NEW FEATURE] Added functions: `as.POSIXxt`, `is.POSIXxt`,
    `Sys.time`, `ISOdatetime`, `ISOdate`, `Ops.POSIXxt`,
    `c.POSIXxt`, `rep.POSIXxt`, `seq.POSIXxt`.


## 0.1.3 (2021-08-05)

* [BUGFIX] #4: Fixed failing check with ICU 55.

* [BUGFIX] #5: Fixed failing check under POSIX/C locale.


## 0.1.2 (2021-07-27)

* First [CRAN](https://cran.r-project.org/package=stringx) release.


## 0.1.1 (2021-07-15)

* [GENERAL] [On-line manual](https://stringx.gagolewski.com) is now available.

* [GENERAL] Using [*realtest*](https://realtest.gagolewski.com)
  for documenting base R behaviour, unit testing, and desired outcomes.

* [NEW FEATURE] Added constants: `letters_greek`, `digits_hex`, etc.

* [NEW FEATURE] Added functions and operators:
  `strcat`, `%x+%`, `%x*%`,
  `chartr2`, `strtrans`,
  `printf`,
  `xtfrm2`,
  `strftime`, `strptime`,
  `strcoll`, `%x==%`, `%x!=%`, `%x<%`, `%x<=%`, `%x>%`, `%x>=%`,
  `substrl`, `substrl<-`,
  `sub2`, `gsub2`,
  `grepl2`, `grepv2`, `grepv2<-`,
  `regexpr2`, `gregexpr2`,
  `regexec2`, `gregexec2`,
  `gsubstrl`, `gsubstrl<-`,
  `gsubstr`, `gsubstr<-`,
  `regextr2`, `regextr2<-`,
  `gregextr2`, `gregextr2<-`.

* [NEW FEATURE] Rewritten functions:
  `paste`, `paste0`,
  `strrep`,
  `chartr`, `tolower`, `toupper`, `casefold`,
  `sprintf`,
  `strftime`, `strptime`,
  `nchar`, `nzchar`,
  `strtrim`,
  `trimws`,
  `startsWith`, `endsWith`,
  `sort`,
  `strwrap`,
  `substr`, `substring`, `substr<-`,  `substring<-`,
  `strsplit`,
  `sub`, `gsub`,
  `grep`, `grepl`,
  `regexpr`, `gregexpr`,
  `regexec`, `gregexec`.


## 0.0.0 (2021-05-07)

* The *stringx* project has been started.
