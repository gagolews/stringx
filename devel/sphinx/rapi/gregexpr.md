# gregexpr: Locate Pattern Occurrences

## Description

`regexpr2` and `gregexpr2` locate, respectively, first and all (i.e., **g**lobally) occurrences of a pattern. `regexec2` and `gregexec2` can additionally pinpoint the matches to parenthesised subexpressions (regex capture groups).

## Usage

```r
regexpr2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

gregexpr2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

regexec2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

gregexec2(x, pattern, ..., ignore.case = FALSE, fixed = FALSE)

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
| `...`            | further arguments to [`stri_locate`](https://stringi.gagolewski.com/rapi/stri_locate.html), e.g., `omit_empty`, `locale`, `dotall`                                                                                                                                                                                                                                                                                   |
| `ignore.case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                          |
| `fixed`          | single logical value; `FALSE` for matching with regular expressions (see [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `perl, useBytes` | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                      |
| `text`           | alias to the `x` argument \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                                             |

## Details

These functions are fully vectorised with respect to both `x` and `pattern`.

## Value

`regexpr2` and \[DEPRECATED\] `regexpr` return an integer vector which gives the start positions of the first substrings matching a pattern. The `match.length` attribute gives the corresponding match lengths. If there is no match, the two values are set to -1.

`gregexpr2` and \[DEPRECATED\] `gregexpr` yield a list whose elements are integer vectors with `match.length` attributes, giving the positions of all the matches. For consistency with `regexpr2`, a no-match is denoted with a single -1, hence the output is guaranteed to consist of non-empty integer vectors.

`regexec2` and \[DEPRECATED\] `regexec` return a list of integer vectors giving the positions of the first matches and the locations of matches to the consecutive parenthesised subexpressions (which can only be recognised if `fixed=FALSE`). Each vector is equipped with the `match.length` attribute.

`gregexec2` and \[DEPRECATED\] `gregexec` generate a list of matrices, where each column corresponds to a separate match; the first row is the start index of the match, the second row gives the position of the first captured group, and so forth. Their `match.length` attributes are matrices of corresponding sizes.

These functions preserve the attributes of the longest inputs (unless they are dropped due to coercion). Missing values in the inputs are propagated consistently.

## Differences from Base R

Replacements for base [`gregexpr`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/gregexpr.html) (and others) implemented with [`stri_locate`](https://stringi.gagolewski.com/rapi/stri_locate.html).

-   there are inconsistencies between the argument order and naming in [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html), [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html), and [`startsWith`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/startsWith.html) (amongst others); e.g., where the needle can precede the haystack, the use of the forward pipe operator, [`|>`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/%7C%3E.html), is less convenient **\[fixed here\]**

-   base R implementation is not portable as it is based on the system PCRE or TRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

-   two different regular expression libraries are used (and historically, ERE was used in place of TRE) **\[here, <span class="pkg">ICU</span> Java-like regular expression engine is only available, hence the `perl` argument has no meaning\]**

-   not vectorised w.r.t. `pattern` **\[fixed here\]**

-   `ignore.case=TRUE` cannot be used with `fixed=TRUE` **\[fixed here\]**

-   no attributes are preserved **\[fixed here; see Value\]**

-   in `regexec`, `match.length` attribute is unnamed even if the capture groups are (but `gregexec` sets dimnames of both start positions and lengths) **\[fixed here\]**

-   `regexec` and `gregexec` with `fixed` other than `FALSE` make little sense. **\[this argument is \[DEPRECATED\] in `regexec2` and `gregexec2`\]**

-   `gregexec` does not always yield a list of matrices **\[fixed here\]**

-   a no-match to a conditional capture group is assigned length 0 **\[fixed here\]**

-   no-matches result in a single -1, even if capture groups are defined in the pattern **\[fixed here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`strsplit`](strsplit.md), [`gsub`](gsub.md), [`substrl`](substr.md), [`grepl`](grepl.md)

## Examples




```r
x <- c(aca1="acacaca", aca2="gaca", noaca="actgggca", na=NA)
regexpr2(x, "(A)[ACTG]\\1", ignore.case=TRUE)
##  aca1  aca2 noaca    na 
##     1     2    -1    NA 
## attr(,"match.length")
## [1]  3  3 -1 NA
regexpr2(x, "aca") >= 0  # like grepl2
##  aca1  aca2 noaca    na 
##  TRUE  TRUE FALSE    NA
gregexpr2(x, "aca", fixed=TRUE, overlap=TRUE)
## $aca1
## [1] 1 3 5
## attr(,"match.length")
## [1] 3 3 3
## 
## $aca2
## [1] 2
## attr(,"match.length")
## [1] 3
## 
## $noaca
## [1] -1
## attr(,"match.length")
## [1] -1
## 
## $na
## [1] NA
## attr(,"match.length")
## [1] NA
# two named capture groups:
regexec2(x, "(?<x>a)(?<y>cac?)")
## $aca1
##   x y 
## 1 1 2 
## attr(,"match.length")
##   x y 
## 4 1 3 
## 
## $aca2
##   x y 
## 2 2 3 
## attr(,"match.length")
##   x y 
## 3 1 2 
## 
## $noaca
##     x  y 
## -1 -1 -1 
## attr(,"match.length")
##     x  y 
## -1 -1 -1 
## 
## $na
##     x  y 
## NA NA NA 
## attr(,"match.length")
##     x  y 
## NA NA NA
gregexec2(x, "(?<x>a)(?<y>cac?)")
## $aca1
##   [,1] [,2]
##      1    5
## x    1    5
## y    2    6
## attr(,"match.length")
##   [,1] [,2]
##      4    3
## x    1    1
## y    3    2
## 
## $aca2
##   [,1]
##      2
## x    2
## y    3
## attr(,"match.length")
##   [,1]
##      3
## x    1
## y    2
## 
## $noaca
##   [,1]
##     -1
## x   -1
## y   -1
## attr(,"match.length")
##   [,1]
##     -1
## x   -1
## y   -1
## 
## $na
##   [,1]
##     NA
## x   NA
## y   NA
## attr(,"match.length")
##   [,1]
##     NA
## x   NA
## y   NA
# TODO: extract, make operable with substr and substr<-
# replace  ..utils::strcapture and ..regmatches
# .....
```
