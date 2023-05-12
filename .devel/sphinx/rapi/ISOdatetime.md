# ISOdatetime: Construct Date-time Objects

## Description

`ISOdate` and `ISOdatetime` construct date-time objects from numeric representations. `Sys.time` returns current time.

## Usage

``` r
ISOdatetime(
  year,
  month,
  day,
  hour,
  min,
  sec,
  tz = "",
  lenient = FALSE,
  locale = NULL
)

ISOdate(
  year,
  month,
  day,
  hour = 0L,
  min = 0L,
  sec = 0L,
  tz = "",
  lenient = FALSE,
  locale = NULL
)

Sys.time()
```

## Arguments

|                                                                                                                                                                          |                                                                                                                                                                                                                                                                         |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `year`{#ISOdatetime_:_year}, `month`{#ISOdatetime_:_month}, `day`{#ISOdatetime_:_day}, `hour`{#ISOdatetime_:_hour}, `min`{#ISOdatetime_:_min}, `sec`{#ISOdatetime_:_sec} | numeric vectors                                                                                                                                                                                                                                                         |
| `tz`{#ISOdatetime_:_tz}                                                                                                                                                  | `NULL` or `''` for the default time zone (see [`stri_timezone_get`](https://stringi.gagolewski.com/rapi/stri_timezone_set.html)) or a single string with a timezone identifier, see [`stri_timezone_list`](https://stringi.gagolewski.com/rapi/stri_timezone_list.html) |
| `lenient`{#ISOdatetime_:_lenient}                                                                                                                                        | single logical value; should date/time parsing be lenient?                                                                                                                                                                                                              |
| `locale`{#ISOdatetime_:_locale}                                                                                                                                          | `NULL` or `''` for the default locale (see [`stri_locale_get`](https://stringi.gagolewski.com/rapi/stri_locale_set.html)) or a single string with a locale identifier, see [`stri_locale_list`](https://stringi.gagolewski.com/rapi/stri_locale_list.html)              |

## Value

These functions return an object of class `POSIXxt`, which extends upon [`POSIXct`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/POSIXct.html), [`strptime`](strptime.md).

You might wish to consider calling [`as.Date`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/as.Date.html) on the result yielded by `ISOdate`.

No attributes are preserved (because they are too many).

## Differences from Base R

Replacements for base [`ISOdatetime`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/ISOdatetime.html) and [`ISOdate`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/ISOdate.html) implemented with [`stri_datetime_create`](https://stringi.gagolewski.com/rapi/stri_datetime_create.html).

-   `ISOdate` does not treat dates as being at midnight by default **\[fixed here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`strptime`](strptime.md)

## Examples




```r
ISOdate(1970, 1, 1)
## [1] "1970-01-01T00:00:00+1000"
ISOdatetime(1970, 1, 1, 12, 0, 0)
## [1] "1970-01-01T12:00:00+1000"
```
