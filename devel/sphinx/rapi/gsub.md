# gsub: Replace Pattern Occurrences

## Description

`sub2` replaces the first pattern occurrence in each string with a given replacement string. `gsub2` replaces all (i.e., \'globally\') pattern matches.

## Usage

```r
sub2(x, pattern, replacement, ..., ignore.case = FALSE, fixed = FALSE)

gsub2(x, pattern, replacement, ..., ignore.case = FALSE, fixed = FALSE)

sub(
  pattern,
  replacement,
  x,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE
)

gsub(
  pattern,
  replacement,
  x,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE
)
```

## Arguments

|                  |                                                                                                                                                                                                                                                                                                                                                                                                                      |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`              | character vector with strings whose chunks are to be modified                                                                                                                                                                                                                                                                                                                                                        |
| `pattern`        | character vector of nonempty search patterns                                                                                                                                                                                                                                                                                                                                                                         |
| `replacement`    | character vector with the corresponding replacement strings; in `sub2` and `gsub2`, back-references (whenever `fixed=FALSE`) are indicated by `$0`..`$99` and `$<name>`, whereas the base-R compatible `sub` and `gsub`, only allow `\1`..`\9`                                                                                                                                                                       |
| `...`            | further arguments to [`stri_replace_first`](https://stringi.gagolewski.com/rapi/stri_replace.html) or [`stri_replace_all`](https://stringi.gagolewski.com/rapi/stri_replace.html), e.g., `locale`, `dotall`                                                                                                                                                                                                          |
| `ignore.case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                          |
| `fixed`          | single logical value; `FALSE` for matching with regular expressions (see [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `perl, useBytes` | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                      |

## Details

Not to be confused with [`substr`](substr.md).

These functions are fully vectorised with respect to `x`, `pattern`, and `replacement`.

`gsub2` uses `vectorise_all=TRUE` because of the attribute preservation rules, [`stri_replace_all`](https://stringi.gagolewski.com/rapi/stri_replace.html) should be called directly if different behaviour is needed.

The \[DEPRECATED\] `sub` and \[DEPRECATED\] `gsub` simply call `sub2` and `gsub2` which have a cleaned-up argument list. Additionally, if `fixed=FALSE`, the back-references in `replacement` strings are converted to these accepted by the <span class="pkg">ICU</span> regex engine.

## Value

Both functions return a character vector. They preserve the attributes of the longest inputs (unless they are dropped due to coercion).

## Differences from Base R

Replacements for base [`sub`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/sub.html) and [`gsub`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/gsub.html) implemented with [`stri_replace_first`](https://stringi.gagolewski.com/rapi/stri_replace.html) and [`stri_replace_all`](https://stringi.gagolewski.com/rapi/stri_replace.html), respectively.

-   there are inconsistencies between the argument order and naming in [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html), [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html), and [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) (amongst others); e.g., where the needle can precede the haystack, the use of the forward pipe operator, [`|>`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/%7C%3E.html), is less convenient **\[fixed here\]**

-   base R implementation is not portable as it is based on the system PCRE or TRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

-   two different regular expression libraries are used (and historically, ERE was used in place of TRE) **\[here, <span class="pkg">ICU</span> Java-like regular expression engine is only available, hence the `perl` argument has no meaning\]**

-   not vectorised w.r.t. `pattern` and `replacement` **\[fixed here\]**

-   only 9 (unnamed) back-references can be referred to in the replacement strings **\[fixed in `sub2` and `gsub2`\]**

-   `perl=TRUE` supports `\U`, `\L`, and `\E` in the replacement strings **\[not available here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`grepl`](grepl.md), [`gregexpr`](gregexpr.md) [`strsplit`](strsplit.md), [`substr`](substr.md)

[`trimws`](trimws.md) for removing whitespaces (amongst others) from the start or end of strings

## Examples




```r
"change \U0001f602 me \U0001f603" |> gsub2("\\p{EMOJI_PRESENTATION}", "O_O")
## [1] "change O_O me O_O"
x <- c("mario", "Mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario", NA)
sub2(x, "mario", "M\u00E1rio", fixed=NA, strength=1L)
## [1] "Mário"   "Mário"   "Mário"   "Mário"   "María"   "Rosario" NA
sub2(x, "mario", "Mario", fixed=NA, strength=2L)
## [1] "Mario"   "Mario"   "Mário"   "MÁRIO"   "María"   "Rosario" NA
x <- "abcdefghijklmnopqrstuvwxyz"
p <- "(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)"
base::sub(p, "\\1\\9", x)
## [1] "ainopqrstuvwxyz"
base::gsub(p, "\\1\\9", x)
## [1] "ainv"
base::gsub(p, "\\1\\9", x, perl=TRUE)
## [1] ""
base::gsub(p, "\\1\\13", x)
## [1] "aa3nn3"
sub2(x, p, "$1$13")
## [1] "amnopqrstuvwxyz"
gsub2(x, p, "$1$13")
## [1] "amnz"
```
