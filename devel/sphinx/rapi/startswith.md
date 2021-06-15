# startswith: Detect Pattern Occurrences at Start or End of Strings

## Description

Determines if a string starts or ends if with a match to a specified fixed pattern.

## Usage

```r
startsWith(x, prefix, ignore.case = FALSE)

endsWith(x, suffix, ignore.case = FALSE)
```

## Arguments

|                  |                                                               |
|------------------|---------------------------------------------------------------|
| `x`              | character vector whose elements are to be examined            |
| `prefix, suffix` | character vectors with fixed (literal) patterns to search for |
| `ignore.case`    | single logical value                                          |

## Details

Replacements for base [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) and [`endsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/endsWith.html) implemented with [`stri_startswith_fixed`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html) and [`stri_endswith_fixed`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html)

For matching with regular expressions, see [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html) with patterns like `"^prefix"` and `"suffix$"`.

Vectorised with respect to both arguments.

Inconsistencies in/differences from base R:

-   note that other pattern matching functions have a different argument order, where the needle precedes the haystack **\[not fixed here\]**

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) also features the `ignore.case` argument **\[added here\]**

-   partial recycling without the usual warning **\[fixed here\]**

-   no attributes preserved whatsoever **\[fixed here\]**

## Value

Each function returns a logical vector, indicating whether a pattern match has been detected or not.

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
```
