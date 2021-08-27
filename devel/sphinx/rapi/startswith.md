# startswith: Detect Pattern Occurrences at Start or End of Strings

## Description

Determines if a string starts or ends with a match to a specified fixed pattern.

## Usage

```r
startsWith(
  x,
  pattern = prefix,
  ...,
  ignore_case = ignore.case,
  fixed = TRUE,
  ignore.case = FALSE,
  prefix
)

endsWith(
  x,
  pattern = suffix,
  ...,
  ignore_case = ignore.case,
  fixed = TRUE,
  ignore.case = FALSE,
  suffix
)
```

## Arguments

|                  |                                                                                                                                                                                                                                                                                                                                              |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`              | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                           |
| `pattern`        | character vector with patterns to search for                                                                                                                                                                                                                                                                                                 |
| `...`            | further arguments to [`stri_startswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html) and [`stri_endswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html), e.g., `locale`                                                                                                                                   |
| `ignore_case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                  |
| `fixed`          | single logical value; `TRUE` for fixed pattern matching (see [about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)); `FALSE` is not supported -- use [`grepl`](grepl.md) instead |
| `ignore.case`    | alias to the `ignore_case` argument \[DEPRECATED\]                                                                                                                                                                                                                                                                                           |
| `prefix, suffix` | aliases to the `pattern` argument \[DEPRECATED\]                                                                                                                                                                                                                                                                                             |

## Details

These functions are fully vectorised with respect to both arguments.

For matching with regular expressions, see [`grepl`](grepl.md) with patterns like `"^prefix"` and `"suffix$"`.

## Value

Each function returns a logical vector, indicating whether a pattern match has been detected or not. They preserve the attributes of the longest inputs (unless they are dropped due to coercion).

## Differences from Base R

Replacements for base [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) and [`endsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/endsWith.html) implemented with [`stri_startswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html) and [`stri_endswith`](https://stringi.gagolewski.com/rapi/stri_startsendswith.html).

-   there are inconsistencies between the argument order and naming in [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html), [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html), and [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) (amongst others); e.g., where the needle can precede the haystack, the use of the forward pipe operator, [`|>`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/+7C+3E.html), is less convenient **\[fixed here\]**

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) also features the `ignore.case` argument **\[added here\]**

-   partial recycling without the usual warning **\[fixed here\]**

-   no attributes preserved whatsoever **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`grepl`](grepl.md), [`substr`](substr.md)

## Examples




```r
startsWith("ababa", c("a", "ab", "aba", "baba", NA))
## [1]  TRUE  TRUE  TRUE FALSE    NA
outer(
    c("aba", "abb", "abc", "baba", "bac"),
    c("A", "B", "C"),
    endsWith,
    ignore_case=TRUE
)
##       [,1]  [,2]  [,3]
## [1,]  TRUE FALSE FALSE
## [2,] FALSE  TRUE FALSE
## [3,] FALSE FALSE  TRUE
## [4,]  TRUE FALSE FALSE
## [5,] FALSE FALSE  TRUE
x <- c("Mario", "mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario")
x[startsWith(x, "mario", ignore_case=TRUE)]
## [1] "Mario" "mario"
x[startsWith(x, "mario", fixed=NA, strength=1L)]
## [1] "Mario" "mario" "Mário" "MÁRIO"
```
