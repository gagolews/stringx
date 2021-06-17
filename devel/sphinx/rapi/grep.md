# grep: Detect Pattern Occurrences

## Description

`grepl2` indicates whether a string matches a corresponding pattern or not. `grepv2` returns a subset of `x` that is comprised of

Its replacement version allows for substituting matching strings with new ones. `grep2` is merely a shorthand for `which(grepl2(...))`.

## Usage

```r
grepl2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE, invert = FALSE)

grep2(
  x,
  pattern,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  invert = FALSE,
  arr.ind = FALSE,
  useNames = TRUE
)

grepv2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE, invert = FALSE)

grepv2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE, invert = FALSE) <- value

grep(
  pattern,
  x,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  value = FALSE,
  invert = FALSE,
  perl = FALSE,
  useBytes = FALSE
)

grepl(
  pattern,
  x,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  value = FALSE,
  invert = FALSE,
  perl = FALSE,
  useBytes = FALSE
)
```

## Arguments

|                     |                                                                                                                                                                                                                                                                                                                                                                                                                      |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`                 | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                                                                                                   |
| `pattern`           | character vector of nonempty search patterns                                                                                                                                                                                                                                                                                                                                                                         |
| `...`               | further arguments to [`stri_detect`](https://stringi.gagolewski.com/rapi/stri_detect.html), e.g., `max_count`, `locale`, `dotall`                                                                                                                                                                                                                                                                                    |
| `ignore.case`       | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                          |
| `fixed`             | single logical value; `FALSE` for matching with regular expressions (see [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `invert`            | single logical value; indicates whether a no-match is rather of interest                                                                                                                                                                                                                                                                                                                                             |
| `arr.ind, useNames` | see [`which`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/which.html)                                                                                                                                                                                                                                                                                                                                    |
| `value`             | for the replacement version of `grepv2`, a character vector with replacement strings; otherwise, a single logical value indicating whether indexes of strings in `x` matching patterns should be returned                                                                                                                                                                                                            |
| `perl, useBytes`    | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                      |

## Details

These functions are fully vectorised with respect to `x` and `pattern`. However, because `grepv2` aims at subsetting `x`, calling it with `pattern` longer than `x` results in an error.

## Value

Returns a list of character vectors representing the identified tokens.

missing values, attributes\....

## Differences from Base R

Replacements for base [`grep`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grep.html) and [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) implemented with [`stri_detect`](https://stringi.gagolewski.com/rapi/stri_detect.html).

-   there are inconsistencies between the argument order and naming in [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html), [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html), and [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) (amongst others); e.g., where the needle can precede the haystack, the use of the forward pipe operator `|>` is less convenient **\[fixed here\]**

-   base R implementation is not portable as it is based on the system PCRE or TRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category **\[fixed here\]**

-   `grepl` is not equipped with `value` and `invert` arguments **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

-   two different regular expression libraries are used (and historically, ERE was used in place of TRE) **\[here, <span class="pkg">ICU</span> Java-like regular expression engine is only available, hence the `perl` argument has no meaning\]**

-   not vectorised w.r.t. `pattern` **\[fixed here\]**

-   \...

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`strsplit`](strsplit.md), [`gsub`](gsub.md), [`gregexpr`](gregexpr.md), [`substr`](substr.md)

## Examples




```r
# ...
```
