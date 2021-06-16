# grep: Detect Pattern Occurrences

## Description

\... g stands for \'global\'=all

## Usage

```r
grep2(
  x,
  pattern,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  value = FALSE,
  invert = FALSE
)

grepl2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

regexpr2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

gregexpr2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

regexec2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

gregexec2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

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
  perl = FALSE,
  useBytes = FALSE
)

regexpr(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)

gregexpr(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)

regexec(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)

gregexec(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)
```

## Arguments

|                  |                                                                                                                                                                                                                                                                                                                                                                                                                      |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`              | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                                                                                                   |
| `pattern`        | character vector of nonempty search patterns                                                                                                                                                                                                                                                                                                                                                                         |
| `...`            | further arguments to [`stri_split`](https://stringi.gagolewski.com/rapi/stri_split.html), e.g., `omit_empty`, `locale`, `dotall`                                                                                                                                                                                                                                                                                     |
| `ignore.case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                          |
| `fixed`          | single logical value; `FALSE` for matching with regular expressions (see [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `perl, useBytes` | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                      |

## Details

This function is fully vectorised with respect to both arguments.

For splitting text into \'characters\' (grapheme clusters), words, or sentences, use [`stri_split_boundaries`](https://stringi.gagolewski.com/rapi/stri_split_boundaries.html) instead.

## Value

Returns a list of character vectors representing the identified tokens.

## Differences from Base R

Replacements for base [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html) implemented with [`stri_split`](https://stringi.gagolewski.com/rapi/stri_split.html).

-   there are inconsistencies between the argument order and naming in [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html), [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html), and [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) (amongst others); e.g., where the needle can precede the haystack, the use of the forward pipe operator `|>` is less convenient **\[fixed here\]**

-   base R implementation is not portable as it is based on the system PCRE or TRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

-   two different regular expression libraries are used (and historically, ERE was used in place of TRE) **\[here, <span class="pkg">ICU</span> Java-like regular expression engine is only available, hence the `perl` argument has no meaning\]**

-   not vectorised w.r.t. `pattern` **\[fixed here\]**

-   \...

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`strsplit`](strsplit.md), [`gsub`](gsub.md), [`substr`](substr.md)

## Examples




```r
# ...
```
