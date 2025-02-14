# strptime: Parse and Format Date-time Objects

## Description

Note that the date-time processing functions in <span class="pkg">stringx</span> are a work in progress. Feature requests/comments/remarks are welcome.

`strptime` parses strings representing date-time data and converts it to a date-time object.

`strftime` formats a date-time object and outputs it as a character vector.

The functions are meant to be compatible with each other, especially with regards to formatting/printing. This is why they return/deal with objects of a new class, `POSIXxt`, which expends upon the built-in `POSIXct`.

## Usage

``` r
strptime(x, format, tz = "", lenient = FALSE, locale = NULL)

strftime(
  x,
  format = "%Y-%m-%dT%H:%M:%S%z",
  tz = attr(x, "tzone")[1L],
  usetz = FALSE,
  ...,
  locale = NULL
)

## S3 method for class 'POSIXxt'
format(
  x,
  format = "%Y-%m-%dT%H:%M:%S%z",
  tz = attr(x, "tzone")[1L],
  usetz = FALSE,
  ...,
  locale = NULL
)

is.POSIXxt(x)

as.POSIXxt(x, tz = "", ...)

## S3 method for class 'POSIXt'
as.POSIXxt(x, tz = attr(x, "tzone")[1L], ...)

## S3 method for class 'POSIXxt'
as.POSIXlt(x, tz = attr(x, "tzone")[1L], ..., locale = NULL)

## Default S3 method:
as.POSIXxt(x, tz = "", ...)

## S3 method for class 'POSIXxt'
as.Date(x, ...)

## S3 method for class 'Date'
as.POSIXxt(x, ...)

## S3 method for class 'character'
as.POSIXxt(x, tz = "", format = NULL, ..., lenient = FALSE, locale = NULL)

## S3 method for class 'POSIXxt'
Ops(e1, e2)

## S3 method for class 'POSIXxt'
seq(from, to, by, length.out = NULL, along.with = NULL, ...)

## S3 method for class 'POSIXxt'
c(..., recursive = FALSE)

## S3 method for class 'POSIXxt'
rep(..., recursive = FALSE)
```

## Arguments

|  |  |
|----|----|
| `x` | object to be converted: a character vector for `strptime` and `as.POSIXxt.character`, an object of class `POSIXxt` for `strftime` an object of class `Date` for `as.POSIXxt.Date`, or objects coercible to |
| `format` | character vector of date-time format specifiers, see [`stri_datetime_fstr`](https://stringi.gagolewski.com/rapi/stri_datetime_fstr.html); e.g., `"%Y-%m-%d"` or `"datetime_full"`; the default conforms to the ISO 8601 guideline |
| `tz` | `NULL` or `''` for the default time zone (see [`stri_timezone_get`](https://stringi.gagolewski.com/rapi/stri_timezone_set.html)) or a single string with a timezone identifier, see [`stri_timezone_list`](https://stringi.gagolewski.com/rapi/stri_timezone_list.html); note that when `x` is equipped with `tzone` attribute, this datum is used; `as.POSIXxt.character` treats dates as being at midnight local time |
| `lenient` | single logical value; should date/time parsing be lenient? |
| `locale` | `NULL` or `''` for the default locale (see [`stri_locale_get`](https://stringi.gagolewski.com/rapi/stri_locale_set.html)) or a single string with a locale identifier, see [`stri_locale_list`](https://stringi.gagolewski.com/rapi/stri_locale_list.html) |
| `usetz` | not used (with a warning if attempting to do so) \[DEPRECATED\] |
| `...` | not used |
| `e1`, `e2`, `from`, `to`, `by`, `length.out`, `along.with`, `recursive` | arguments to [`c`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/c.html), [`rep`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/rep.html), [`seq`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/seq.html), etc. |

## Details

Note that the ISO 8601 guideline suggests a year-month-day date format and a 24-hour time format always indicating the effective time zone, e.g., `2015-12-31T23:59:59+0100`. This is so as to avoid ambiguity.

When parsing strings, missing fields are filled based on today\'s midnight data.

## Value

`strftime` and `format` return a character vector (in UTF-8).

`strptime`, `as.POSIXxt.Date`, and `asPOSIXxt.character` return an object of class `POSIXxt`, which extends upon [`POSIXct`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/POSIXct.html), see also [DateTimeClasses](https://stat.ethz.ch/R-manual/R-devel/library/base/help/DateTimeClasses.html).

Subtraction returns an object of the class `difftime`, see [`difftime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/difftime.html).

If a string cannot be recognised as valid date/time specifier (as per the given format string), the corresponding output will be `NA`.

## Differences from Base R

Replacements for base [`strptime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strptime.html) and [`strftime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strftime.html) implemented with [`stri_datetime_parse`](https://stringi.gagolewski.com/rapi/stri_datetime_format.html) and [`stri_datetime_format`](https://stringi.gagolewski.com/rapi/stri_datetime_format.html).

`format.POSIXxt` is a thin wrapper around `strftime`.

-   formatting/parsing date-time in different locales and calendars is difficult and non-portable across platforms **\[fixed here -- using services provided by ICU\]**

-   default format not conforming to ISO 8601, in particular not displaying the current time zone **\[fixed here\]**

-   only the names attribute in `x` is propagated **\[fixed here\]**

-   partial recycling with no warning **\[fixed here\]**

-   `strptime` returns an object of class `POSIXlt`, which is not the most convenient to work with, e.g., when including in data frames **\[fixed here\]**

-   Ideally, there should be only one class to represent dates and one to represent date/time; `POSIXlt` is no longer needed as we have [`stri_datetime_fields`](https://stringi.gagolewski.com/rapi/stri_datetime_fields.html); our new `POSIXxt` class aims to solve the underlying problems with `POSIXct`\'s not being consistent with regards to working in different time zones and dates (see, e.g., `as.Date(as.POSIXct(strftime(Sys.Date())))`) **\[addressed here\]**

-   dates without times are not always treated as being at midnight (despite that being stated in the help page for `as.POSIXct`) **\[fixed here\]**

-   `strftime` does not honour the `tzone` attribute, which is used whilst displaying time (via [`format`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/format.html)) **\[fixed here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`sprintf`](sprintf.md), [`ISOdatetime`](ISOdatetime.md)

## Examples




``` r
strftime(Sys.time())  # default format - ISO 8601
```

```
## [1] "2025-01-11T17:25:20+0100"
```

``` r
f <- c("date_full", "%Y-%m-%d", "date_relative_short", "datetime_full")
strftime(Sys.time(), f)  # current default locale
```

```
## [1] "Saturday, January 11, 2025"                                             
## [2] "2025-01-11"                                                             
## [3] "today"                                                                  
## [4] "Saturday, January 11, 2025 at 5:25:20 PM Central European Standard Time"
```

``` r
strftime(Sys.time(), f, locale="de_DE")
```

```
## [1] "Samstag, 11. Januar 2025"                                         
## [2] "2025-01-11"                                                       
## [3] "heute"                                                            
## [4] "Samstag, 11. Januar 2025 um 17:25:20 Mitteleuropäische Normalzeit"
```

``` r
strftime(Sys.time(), "date_short", locale="en_IL@calendar=hebrew")
```

```
## [1] "11 Tevet 5785"
```

``` r
strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S", tz="GMT")
```

```
## [1] "1970-01-01T00:00:00+0000"
```

``` r
strptime("14 Nisan 5703", "date_short", locale="en_IL@calendar=hebrew")
```

```
## [1] "1943-04-19T00:00:00+0200"
```

``` r
as.POSIXxt("1970-01-01")
```

```
## [1] "1970-01-01T00:00:00+0100"
```

``` r
as.POSIXxt("1970/01/01 12:00")
```

```
## [1] "1970-01-01T12:00:00+0100"
```
