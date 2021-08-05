# grepl: Detect Pattern Occurrences

## Description

`grepl2` indicates whether a string matches the corresponding pattern or not.

`grepv2` returns a subset of `x` matching the corresponding patterns. Its replacement version allows for substituting such a subset with new content.

## Usage

```r
grepl2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE, invert = FALSE)

grepv2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE, invert = FALSE)

grepv2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE, invert = FALSE) <- value

grepl(
  pattern,
  x,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  invert = FALSE,
  perl = FALSE,
  useBytes = FALSE
)

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
```

## Arguments

|                            |                                                                                                                                                                                                                                                                                                                                                                                                                      |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`                        | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                                                                                                   |
| `pattern`                  | character vector of nonempty search patterns; for `grepv2` and `grep`, must not be longer than `x`                                                                                                                                                                                                                                                                                                                   |
| `...`                      | further arguments to [`stri_detect`](https://stringi.gagolewski.com/rapi/stri_detect.html), e.g., `max_count`, `locale`, `dotall`                                                                                                                                                                                                                                                                                    |
| `ignore_case, ignore.case` | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                          |
| `fixed`                    | single logical value; `FALSE` for matching with regular expressions (see [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `invert`                   | single logical value; indicates whether a no-match is rather of interest                                                                                                                                                                                                                                                                                                                                             |
| `value`                    | character vector of replacement strings or a single logical value indicating whether indexes of strings in `x` matching patterns should be returned                                                                                                                                                                                                                                                                  |
| `perl, useBytes`           | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                      |

## Details

These functions are fully vectorised with respect to `x` and `pattern`.

The \[DEPRECATED\] `grepl` simply calls `grepl2` which have a cleaned-up argument list.

The \[DEPRECATED\] `grep` with `value=FALSE` is actually redundant -- it can be trivially reproduced with `grepl` and [`which`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/which.html).

`grepv2` and `grep` with `value=FALSE` combine pattern matching and subsetting and some users may find it convenient in conjunction with the forward pipe operator, [`|>`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/%7C%3E.html).

## Value

`grepl2` and \[DEPRECATED\] `grep` return a logical vector. They preserve the attributes of the longest inputs (unless they are dropped due to coercion). Missing values in the inputs are propagated consistently.

`grepv2` and \[DEPRECATED\] `grep` with `value=TRUE` returns a subset of `x` with elements matching the corresponding patterns. \[DEPRECATED\] `grep` with `value=FALSE` returns the indexes in `x` where a match occurred. Missing values are not included in the outputs and only the `names` attribute is preserved, because the length of the result may be different than that of `x`.

The replacement version of `grepv2` modifies `x` \'in-place\'.

## Differences from Base R

`grepl` and `grep` are \[DEPRECATED\] replacements for base [`grep`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grep.html) and [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) implemented with [`stri_detect`](https://stringi.gagolewski.com/rapi/stri_detect.html).

-   there are inconsistencies between the argument order and naming in [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html), [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html), and [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) (amongst others); e.g., where the needle can precede the haystack, the use of the forward pipe operator, [`|>`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/%7C%3E.html), is less convenient **\[fixed by introducing `grepl2`\]**

-   base R implementation is not portable as it is based on the system PCRE or TRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

-   two different regular expression libraries are used (and historically, ERE was used in place of TRE) **\[here, <span class="pkg">ICU</span> Java-like regular expression engine is only available, hence the `perl` argument has no meaning\]**

-   not vectorised w.r.t. `pattern` **\[fixed here, however, in `grep`, `pattern` cannot be longer than `x`\]**

-   missing values in haystack will result in a no-match **\[fixed in `grepl`; see Value\]**

-   `ignore.case=TRUE` cannot be used with `fixed=TRUE` **\[fixed here\]**

-   no attributes are preserved **\[fixed here; see Value\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`strsplit`](strsplit.md), [`gsub2`](gsub.md), [`gregexpr2`](gregexpr.md), [`gregextr2`](gregextr.md), [`gsubstr`](substr.md)

## Examples




```r
x <- c("abc", "1237", "\U0001f602", "\U0001f603", "stringx\U0001f970", NA)
grepl2(x, "\\p{L}")
## [1]  TRUE FALSE FALSE FALSE  TRUE    NA
which(grepl2(x, "\\p{L}"))  # like grep
## [1] 1 5
# at least 1 letter or digit:
p <- c("\\p{L}", "\\p{N}")
`dimnames<-`(outer(x, p, grepl2), list(x, p))
##           \\p{L} \\p{N}
## abc         TRUE  FALSE
## 1237       FALSE   TRUE
## 😂         FALSE  FALSE
## 😃         FALSE  FALSE
## stringx🥰   TRUE  FALSE
## <NA>          NA     NA
x |> grepv2("\\p{L}")
## [1] "abc"       "stringx🥰"
grepv2(x, "\\p{L}", invert=TRUE) <- "\U0001F496"
print(x)
## [1] "abc"       "💖"        "💖"        "💖"        "stringx🥰" NA
```
