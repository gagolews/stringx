# grep: Detect Pattern Occurrences

## Description

\...

## Usage

```r
grep(
  pattern,
  x,
  ignore.case = FALSE,
  perl = FALSE,
  value = FALSE,
  fixed = FALSE,
  useBytes = FALSE,
  invert = FALSE
)

grepl(
  pattern,
  x,
  ignore.case = FALSE,
  perl = FALSE,
  fixed = FALSE,
  useBytes = FALSE
)

regexpr(
  pattern,
  text,
  ignore.case = FALSE,
  perl = FALSE,
  fixed = FALSE,
  useBytes = FALSE
)

gregexpr(
  pattern,
  text,
  ignore.case = FALSE,
  perl = FALSE,
  fixed = FALSE,
  useBytes = FALSE
)

regexec(
  pattern,
  text,
  ignore.case = FALSE,
  perl = FALSE,
  fixed = FALSE,
  useBytes = FALSE
)

gregexec(
  pattern,
  text,
  ignore.case = FALSE,
  perl = FALSE,
  fixed = FALSE,
  useBytes = FALSE
)
```

## Arguments

|                  |                                                                                                                                                                                                                                                                                                                                                                                                                      |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`              | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                                                                                                   |
| `ignore.case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                          |
| `perl, useBytes` | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                      |
| `fixed`          | single logical value; `FALSE` for matching with regular expressions (see [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `split`          | character vector of nonempty search patterns, [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)                                                                                                                                                                                                                                                                                    |
| `...`            | further arguments to [`stri_split`](https://stringi.gagolewski.com/rapi/stri_split.html), e.g., `omit_empty`, `locale`, `dotall`                                                                                                                                                                                                                                                                                     |

## Details

This function is fully vectorised with respect to both arguments.

For splitting text into \'characters\' (grapheme clusters), words, or sentences, use [`stri_split_boundaries`](https://stringi.gagolewski.com/rapi/stri_split_boundaries.html) instead.

## Value

Returns a list of character vectors representing the identified tokens.

## Differences from Base R

Replacements for base [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html) implemented with [`stri_split`](https://stringi.gagolewski.com/rapi/stri_split.html).

-   base R implementation is not portable as it is based on the system PCRE or TRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

-   two different regular expression libraries are used (and historically, ERE was used in place of TRE) **\[here, <span class="pkg">ICU</span> Java-like regular expression engine is only available, hence the `perl` argument has no meaning\]**

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) and some other pattern matching functions have a different argument order, where the needle precedes the haystack and `ignore.case` is listed before `perl` and then `fixed` etc. **\[not fixed here\]**

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) also features the `ignore.case` argument **\[added here\]**

-   if `split` is a zero-length vector, it is treated as `""`, which extracts individual code points (which is not the best idea for natural language processing tasks) **\[empty search patterns are not supported here, zero-length vectors are propagated correctly\]**

-   last empty token is removed from the output, but first is not **\[fixed here -- see also the `omit_empty` argument\]**

-   missing values in `split` are not propagated correctly **\[fixed here\]**

-   partial recycling without the usual warning, not fully vectorised w.r.t. the `split` argument **\[fixed here\]**

-   only the `names` attribute of `x` is preserved **\[fixed here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`strsplit`](strsplit.md), [`gsub`](gsub.md), [`substr`](substr.md)

## Examples




```r
# ...
```
