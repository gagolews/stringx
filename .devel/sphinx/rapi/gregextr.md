# gregextr: Extract Pattern Occurrences

## Description

`regextr2` and `gregextr2` extract, respectively, first and all (i.e., **g**lobally) occurrences of a pattern. Their replacement versions substitute the matching substrings with new content.

## Usage

``` r
regextr2(
  x,
  pattern,
  ...,
  ignore_case = FALSE,
  fixed = FALSE,
  capture_groups = FALSE
)

gregextr2(
  x,
  pattern,
  ...,
  ignore_case = FALSE,
  fixed = FALSE,
  capture_groups = FALSE
)

regextr2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE) <- value

gregextr2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE) <- value
```

## Arguments

|                  |                                                                                                                                                                                                                                                                                                                                                                                                                |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`              | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                                                                                             |
| `pattern`        | character vector of nonempty search patterns                                                                                                                                                                                                                                                                                                                                                                   |
| `...`            | further arguments to [`stri_locate`](https://stringi.gagolewski.com/rapi/stri_locate.html), e.g., `omit_empty`, `locale`, `dotall`                                                                                                                                                                                                                                                                             |
| `ignore_case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                    |
| `fixed`          | single logical value; `FALSE` for matching with regular expressions (see [about_search_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about_search_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about_search_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `capture_groups` | single logical value; whether matches individual capture groups should be extracted separately                                                                                                                                                                                                                                                                                                                 |
| `value`          | character vector (for `regextr`) or list of character vectors (for `gregextr`) defining the replacement strings                                                                                                                                                                                                                                                                                                |

## Details

Convenience functions based on [`gregexpr2`](gregexpr.md) and [`gsubstrl`](substr.md) (amongst others). Provided as pipe operator-friendly alternatives to \[DEPRECATED\] [`regmatches`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/regmatches.html) and \[DEPRECATED\] [`strcapture`](https://stat.ethz.ch/R-manual/R-devel/library/utils/help/strcapture.html).

They are fully vectorised with respect to `x`, `pattern`, and `value`.

Note that, unlike in [`gsub2`](gsub.md), each substituted chunk can be replaced with different content. However, references to matches to capture groups cannot be made.

## Value

`capture_groups` is `FALSE`, `regextr2` returns a character vector and `gregextr2` gives a list of character vectors.

Otherwise, `regextr2` returns a list of character vectors, giving the whole match as well as matches to the individual capture groups. In `gregextr2`, this will be a matrix with as many columns as there are matches.

Missing values in the inputs are propagated consistently. In `regextr2`, a no-match is always denoted with `NA` (or series thereof). In `gregextr2`, the corresponding result is empty (unless we mean a no-match to an optional capture group within a matching substring). Note that this function distinguishes between a missing input and a no-match.

Their replacement versions return a character vector.

These functions preserve the attributes of the longest inputs (unless they are dropped due to coercion).

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`strsplit`](strsplit.md), [`gsub2`](gsub.md) [`grepl2`](grepl.md), [`gregexpr2`](gregexpr.md), [`gsubstrl`](substr.md),

## Examples




```r
x <- c(aca1="acacaca", aca2="gaca", noaca="actgggca", na=NA)
regextr2(x, "(?<x>a)(?<y>cac?)")
```

```
##   aca1   aca2  noaca     na 
## "acac"  "aca"     NA     NA
```

```r
gregextr2(x, "(?<x>a)(?<y>cac?)")
```

```
## $aca1
## [1] "acac" "aca" 
## 
## $aca2
## [1] "aca"
## 
## $noaca
## character(0)
## 
## $na
## [1] NA
```

```r
regextr2(x, "(?<x>a)(?<y>cac?)", capture_groups=TRUE)
```

```
## $aca1
##             x      y 
## "acac"    "a"  "cac" 
## 
## $aca2
##           x     y 
## "aca"   "a"  "ca" 
## 
## $noaca
##     x  y 
## NA NA NA 
## 
## $na
##     x  y 
## NA NA NA
```

```r
gregextr2(x, "(?<x>a)(?<y>cac?)", capture_groups=TRUE)
```

```
## $aca1
##   [,1]   [,2] 
##   "acac" "aca"
## x "a"    "a"  
## y "cac"  "ca" 
## 
## $aca2
##   [,1] 
##   "aca"
## x "a"  
## y "ca" 
## 
## $noaca
##  
##  
## x
## y
## 
## $na
##   [,1]
##   NA  
## x NA  
## y NA
```

```r
# substitution - note the different replacement strings:
`gregextr2<-`(x, "(?<x>a)(?<y>cac?)", value=list(c("!", "?"), "#"))
```

```
##       aca1       aca2      noaca         na 
##       "!?"       "g#" "actgggca"         NA
```

```r
# references to capture groups can only be used in gsub and sub:
gsub2(x, "(?<x>a)(?<y>cac?)", "{$1}{$2}")
```

```
##              aca1              aca2             noaca                na 
## "{a}{cac}{a}{ca}"        "g{a}{ca}"        "actgggca"                NA
```

```r
regextr2(x, "(?<x>a)(?<y>cac?)") <- "\U0001D554\U0001F4A9"
print(x)  # x was modified 'in-place'
```

```
##       aca1       aca2      noaca         na 
##   "𝕔💩aca"     "g𝕔💩" "actgggca"         NA
```
