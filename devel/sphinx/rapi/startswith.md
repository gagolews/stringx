# startswith: Detect Pattern Occurrences at Start or End of Strings

## Description

Determines if a string starts or ends with a match to a specified fixed pattern.

## Usage

```r
startsWith(x, prefix, fixed = TRUE, ignore.case = FALSE, ...)

endsWith(x, suffix, fixed = TRUE, ignore.case = FALSE, ...)
```

## Arguments

|                  |                                                                                                                                                                                                                                                                                                                                                                                                       |
|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`              | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                                                                                    |
| `prefix, suffix` | character vectors with patterns to search for                                                                                                                                                                                                                                                                                                                                                         |
| `fixed`          | single logical value; `TRUE` for fixed pattern matching (see [about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)); `FALSE` is not supported -- use [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html) instead |
| `ignore.case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                           |
| `...`            | further arguments to [`stri_startswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html) and [`stri_endswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html)                                                                                                                                                                                                            |

## Details

Both functions are fully vectorised with respect to both arguments.

For matching with regular expressions, see [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html) with patterns like `"^prefix"` and `"suffix$"`.

## Value

Each function returns a logical vector, indicating whether a pattern match has been detected or not.

## Differences from base R

Replacements for base [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) and [`endsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/endsWith.html) implemented with [`stri_startswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html) and [`stri_endswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html).

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) and some other pattern matching functions have a different argument order, where the needle precedes the haystack **\[not fixed here\]**

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) also features the `ignore.case` argument **\[added here\]**

-   partial recycling without the usual warning **\[fixed here\]**

-   no attributes preserved whatsoever **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html), [`substr`](substr.md)

## Examples




```r
stringx::startsWith("ababa", c("a", "ab", "aba", "baba", NA))
## [1]  TRUE  TRUE  TRUE FALSE    NA
outer(
    c("aba", "abb", "abc", "baba", "bac"),
    c("A", "B", "C"),
    stringx::endsWith,
    ignore.case=TRUE
)
##       [,1]  [,2]  [,3]
## [1,]  TRUE FALSE FALSE
## [2,] FALSE  TRUE FALSE
## [3,] FALSE FALSE  TRUE
## [4,]  TRUE FALSE FALSE
## [5,] FALSE FALSE  TRUE
x <- c("Mario", "mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario")
x[stringx::startsWith(x, "mario", ignore.case=TRUE)]
## [1] "Mario" "mario"
x[stringx::startsWith(x, "mario", fixed=NA, strength=1L)]
## [1] "Mario" "mario" "Mário" "MÁRIO"
```
