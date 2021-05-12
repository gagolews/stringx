# strrep: Duplicate Strings

## Description

Concatenate a number of copies of each string.

## Usage

```r
strrep(x, times)

e1 %x*% e2
```

## Arguments

|             |                                                                                  |
|-------------|----------------------------------------------------------------------------------|
| `e1, x`     | character vector (or an object coercible to) whose elements are to be duplicated |
| `e2, times` | numeric vector giving the number of times to repeat the corresponding strings    |

## Details

Replacement for base [`strrep`](https://stat.ethz.ch/R-manual/R-patched/library/base/html/strrep.html) implemented with [`stri_dup`](https://stringi.gagolewski.com/rapi/stri_dup.html).

Arguments are recycled if necessary.

The `` `%x*%` `` mimics a vectorised version of Python\'s `` `*` `` for strings (`str.__mul__`).

Inconsistencies in base R (currently; we hope they will be fixed some day) and the way we have addressed them here:

-   missing values are (luckily) not treated as `"NA"` strings (as in base [`paste`](https://stat.ethz.ch/R-manual/R-patched/library/base/html/paste.html)) **\[nothing to do\]**;

-   partial recycling with no warning \"longer object length is not a multiple of shorter object length\" **\[fixed here\]**;

-   base `strrep` seems to preserve only the `names` attribute (whilst `paste` preserves nothing) **\[fixed only in `` `%x+%` `` operator\]**;

-   overloading `` `*.character` `` has no effect in R, because S3 method dispatch is done internally with hard-coded support for character arguments. We could have replaced the generic `` `*` `` with the one that calls [`UseMethod`](https://stat.ethz.ch/R-manual/R-patched/library/base/html/UseMethod.html), but it feels like a too intrusive solution **\[fixed by introducing `` `%x+%` `` operator\]**;

## Value

A character vector (in UTF-8).

`` `%x*%` `` preserves object attributes in a similar way as other [Arithmetic](https://stat.ethz.ch/R-manual/R-patched/library/base/html/Arithmetic.html) operators. `strrep` preserves no attributes whatsoever.

## See Also

[`paste`](paste.md)

## Examples




```r
x <- structure(c(A="a", B=NA, C="c"), attrib1="value1")
x %x*% 3
##     A     B     C 
## "aaa"    NA "ccc" 
## attr(,"attrib1")
## [1] "value1"
x %x*% 1:3
##     A     B     C 
##   "a"    NA "ccc" 
## attr(,"attrib1")
## [1] "value1"
"a" %x*% 1:3
## [1] "a"   "aa"  "aaa"
stringx::strrep(x, 3)
## [1] "aaa" NA    "ccc"
base::strrep(x, 3)
##     A     B     C 
## "aaa"    NA "ccc"
y <- matrix(1:6, nrow=2, dimnames=list(c("A", "B"), NULL))
y %x*% 1:2
##   [,1] [,2] [,3]
## A "1"  "3"  "5" 
## B "22" "44" "66"
stringx::strrep(y, 1:2)
## [1] "1"  "22" "3"  "44" "5"  "66"
base::strrep(y, 1:2)
## [1] "1"  "22" "3"  "44" "5"  "66"
```