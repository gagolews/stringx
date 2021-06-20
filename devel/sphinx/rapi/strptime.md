# strptime: Date-time Parsing and Formatting

## Description

`strptime` parses strings representing date-time data and converts it to a date-time object. `strftime` formats a date-time object and outputs it as a character vector.

## Usage

```r
strptime(x, format, tz = "", lenient = FALSE, locale = NULL)

strftime(
  x,
  format = "%Y-%m-%dT%H:%M:%S%z",
  tz = "",
  usetz = FALSE,
  ...,
  locale = NULL
)
```

## Arguments

|           |                                                                                                                                                                                                                                                                                                                                                             |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`       | object to be converted: a character vector for `strptime` and an object of class `POSIXct` for `strftime`, or objects coercible to                                                                                                                                                                                                                          |
| `format`  | character vector of date-time format specifiers, see [`stri_datetime_fstr`](https://stringi.gagolewski.com/rapi/stri_datetime_fstr.html); e.g., `"%Y-%m-%d"` or `"datetime_full"`; the default conforms to the ISO 8601 guideline                                                                                                                           |
| `tz`      | `NULL` or `''` for the default time zone (see [`stri_timezone_get`](https://stringi.gagolewski.com/rapi/stri_timezone_set.html)) or a single string with a timezone identifier, see [`stri_timezone_list`](https://stringi.gagolewski.com/rapi/stri_timezone_list.html); note that even when `x` is equipped with `tzone` attribute, this datum is not used |
| `lenient` | single logical value; should date/time parsing be lenient?                                                                                                                                                                                                                                                                                                  |
| `locale`  | `NULL` or `''` for the default locale (see [`stri_locale_get`](https://stringi.gagolewski.com/rapi/stri_locale_set.html)) or a single string with a locale identifier, see [`stri_locale_list`](https://stringi.gagolewski.com/rapi/stri_locale_list.html)                                                                                                  |
| `usetz`   | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                             |
| `...`     | not used                                                                                                                                                                                                                                                                                                                                                    |

## Details

Note that the ISO 8601 guideline suggests a year-month-day date format and a 24-hour time format always indicating the effective time zone, e.g., `2015-12-31T23:59:59+0100`. This is so as to avoid ambiguity.

## Value

`strftime` returns a character vector (in UTF-8).

`strptime` returns an object of class [`POSIXct`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/POSIXct.html), see also [DateTimeClasses](https://stat.ethz.ch/R-manual/R-devel/library/base/help/DateTimeClasses.html). If a string cannot be recognised as valid date/time specified (as per the given format string), the corresponding output will be `NA`.

## Differences from Base R

Replacements for base [`strptime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strptime.html) and [`strftime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strftime.html) implemented with [`stri_datetime_parse`](https://stringi.gagolewski.com/rapi/stri_datetime_format.html) and [`stri_datetime_format`](https://stringi.gagolewski.com/rapi/stri_datetime_format.html).

-   formatting/parsing date-time in different locales and calendars is difficult and non-portable across platforms **\[fixed here -- using services provided by ICU\]**

-   default format not conforming to ISO 8601, in particular not displaying the current time zone **\[fixed here\]**

-   only the names attribute in `x` is propagated **\[fixed here\]**

-   partial recycling with no warning **\[fixed here\]**

-   `strptime` returns an object of class `POSIXlt`, which is not the most convenient to work with, e.g., when including in data frames **\[fixed here\]**

-   `strftime` does not honour the `tzone` attribute, which is used whilst displaying time (via [`format`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/format.html)) **\[not fixed here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`sprintf`](sprintf.md)

## Examples




```r
stringx::strftime(Sys.time())  # default format - ISO 8601
## [1] "2021-06-20T16:40:06+1000"
f <- c("date_full", "%Y-%m-%d", "date_relative_short", "datetime_full")
stringx::strftime(Sys.time(), f)  # current default locale
## [1] "Sunday, 20 June 2021"                                               
## [2] "2021-06-20"                                                         
## [3] "today"                                                              
## [4] "Sunday, 20 June 2021 at 4:40:06 pm Australian Eastern Standard Time"
stringx::strftime(Sys.time(), f, locale="de_DE")
## [1] "Sonntag, 20. Juni 2021"                                       
## [2] "2021-06-20"                                                   
## [3] "heute"                                                        
## [4] "Sonntag, 20. Juni 2021 um 16:40:06 Ostaustralische Normalzeit"
stringx::strftime(Sys.time(), "date_short", locale="en_IL@calendar=hebrew")
## [1] "10 Tamuz 5781"
stringx::strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S", tz="GMT")
## [1] "1970-01-01 00:00:00 GMT"
stringx::strptime("14 Nisan 5703", "date_short", locale="en_IL@calendar=hebrew")
## [1] "1943-04-19 16:40:06 AEST"
```
