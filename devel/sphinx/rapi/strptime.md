# strptime: Date-time Parsing and Formatting

## Description

`strptime` parses strings representing date-time data and converts it to a date-time object. `strftime` formats a date-time object and outputs it as a character vector.

## Usage

```r
strptime(
  x,
  format = "%Y-%m-%dT%H:%M:%S%z",
  tz = "",
  lenient = FALSE,
  locale = NULL
)

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

|           |                                                                                                                                                                                                                                                                         |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`       | object to be converted                                                                                                                                                                                                                                                  |
| `format`  | character vector of date-time format specifiers, see [`stri_datetime_fstr`](https://stringi.gagolewski.com/rapi/stri_datetime_fstr.html); e.g., `"%Y-%m-%d"` or `"datetime_full"`; the default conforms to the ISO 8601 guideline, e.g., \'2015-12-31T23:59:59+0100\'   |
| `tz`      | `NULL` or `''` for the default time zone (see [`stri_timezone_get`](https://stringi.gagolewski.com/rapi/stri_timezone_set.html)) or a single string with a timezone identifier, see [`stri_timezone_list`](https://stringi.gagolewski.com/rapi/stri_timezone_list.html) |
| `lenient` | single logical value; should date/time parsing be lenient?                                                                                                                                                                                                              |
| `...`     | not used                                                                                                                                                                                                                                                                |

## Details

Replacements for base [`strptime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strptime.html) and [`strftime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strftime.html) implemented with [`stri_datetime_parse`](https://stringi.gagolewski.com/rapi/stri_datetime_format.html) and [`stri_datetime_format`](https://stringi.gagolewski.com/rapi/stri_datetime_format.html).

Inconsistencies/limitations in base R and the way we have addressed them:

-   formatting/parsing date-time in different locales and calendars is difficult and non-portable across platforms **\[fixed here - using services provided by ICU\]**;

-   default format not conforming to ISO 8601, in particular not displaying the current time zone **\[fixed here\]**;

-   partial recycling with no warning **\[fixed here\]**; \... format 2nd arg (but sprintf has as 1st); undocumented default arg

## Value

`strftime` returns a character vector (in UTF-8).

`strptime` returns an object of class [`POSIXlt`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/DateTimeClasses.html).

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`sprintf`](sprintf.md)

## Examples




```r
f <- c("date_full", "%Y-%m-%d", "date_relative_short", "datetime_full")
stringx::strftime(Sys.time(), f)  # current default locale
## [1] "Thursday, 3 June 2021"                                               
## [2] "2021-06-03"                                                          
## [3] "today"                                                               
## [4] "Thursday, 3 June 2021 at 8:19:06 pm Australian Eastern Standard Time"
stringx::strftime(Sys.time(), f, locale="de_DE")
## [1] "Donnerstag, 3. Juni 2021"                                       
## [2] "2021-06-03"                                                     
## [3] "heute"                                                          
## [4] "Donnerstag, 3. Juni 2021 um 20:19:06 Ostaustralische Normalzeit"
stringx::strftime(Sys.time(), "date_short", locale="en_IL@calendar=hebrew")
## Warning in as.POSIXlt.POSIXct(x, tz): NAs introduced by coercion
## [1] NA
```
