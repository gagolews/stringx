# paste: Concatenate Strings

## Description

Concatenate (join) the corresponding and/or consecutive elements of given vectors, after converting them to strings.

Instead of `paste` and `paste0`, we recommend using `` `%+%` ``, `sprintf`, and `strcat`.

## Usage

```r
paste(..., sep = " ", collapse = NULL, recycle0 = FALSE)

paste0(..., sep = "", collapse = NULL, recycle0 = FALSE)

e1 %+% e2

strcat(x, collapse = "", na.rm = FALSE)
```

## Arguments

|               |                                                                                                                                                                     |
|---------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `sep`         | a single string; separates terms                                                                                                                                    |
| `collapse`    | a single string or `NULL`; an optional separator if tokens are to be merged into a single string                                                                    |
| `recycle0`    | a single logical value; if `FALSE`, then empty vectors provided via `...` are silently ignored                                                                      |
| `e1, e2, ...` | character vectors (or objects coercible to character vectors) whose corresponding elements are to be concatenated whose consecutive elements are to be concatenated |
| `na.rm`       | a single logical value; if `TRUE`, missing values are silently ignored                                                                                              |

## Details

Replacement for base [`paste`](https://stat.ethz.ch/R-manual/R-patched/library/base/html/paste.html) implemented with [`stri_join`](https://stringi.gagolewski.com/rapi/stri_join.html).

`paste` can be thought of as a string counterpart of both the `` `+` `` operator (actually, some languages do have a binary operator for string concatenation, e.g., `` `.` `` in PHP, `` `+` `` in Python; R should have it too, but does not) and the [`sum`](https://stat.ethz.ch/R-manual/R-patched/library/base/html/sum.html) function. Therefore, we would expect it to behave similarly with regards to the propagation of missing values and the preservation of object attributes, but it does not.

Inconsistencies in base R and the way we have addressed them here:

-   missing values treated as `"NA"` strings (it is a well-documented feature though) **\[fixed here\]**;

-   partial recycling with no warning \"longer object length is not a multiple of shorter object length\" **\[fixed here\]**;

-   empty vectors are treated as vectors of empty strings **\[fixed here\]**;

-   input objects\' attributes are not preserved **\[not fixed\]**;

-   `paste0` multiplies entities without necessity; `sep=""` should be the default in `paste` **\[not fixed\]**;

-   `paste0` treats named argument `sep="..."` as one more vector to concatenate **\[fixed by introducing `sep` argument\]**.

It should also be noted that `paste` with `collapse=NULL` is a special case of `sprintf` (which is featured in many programming languages; R\'s version is of course vectorised). For instance, `paste(x, y, sep=",")` is equivalent to `sprintf("%s,%s", x, y)`.

Taking into account the above, `paste` and `paste0` seem redundant. Here are our recommendations:

-   the most frequent use case - concatenating corresponding strings from two character vectors with no separator - is covered by a new operator `` `%+%` `` which propagates NAs correctly and handles object attributes the same way as the built-in arithmetic operators;

-   for fancy elementwise (like \'Map\') concatenation, use our version of [`sprintf`](https://stat.ethz.ch/R-manual/R-patched/library/base/html/sprintf.html);

-   for the \'flattening\' of consecutive strings in a character vector (like \'Reduce\'), use the new function `strcat`.

## Value

Return a character vector (in UTF-8).

## Examples




```r
# behaviour of `+` vs. base::paste vs. stringx::paste
x <- structure(c(x=1, y=NA, z=100, w=1000), F="*")
y1 <- structure(c(a=1, b=2, c=3), G="#", F="@")
y2 <- structure(c(a=1, b=2, c=3, d=4), G="#", F="@")
y3 <- structure(1:4, G="#", F="@", dim=c(2, 2), dimnames=list(NULL, c("a", "b")))
x + y1
## Warning in x + y1: longer object length is not a multiple of shorter object
## length
##    x    y    z    w 
##    2   NA  103 1001 
## attr(,"F")
## [1] "*"
x + y2
##    x    y    z    w 
##    2   NA  103 1004 
## attr(,"G")
## [1] "#"
## attr(,"F")
## [1] "*"
x + y3
##       a    b
## [1,]  2  103
## [2,] NA 1004
## attr(,"G")
## [1] "#"
## attr(,"F")
## [1] "*"
y2 + x
##    a    b    c    d 
##    2   NA  103 1004 
## attr(,"F")
## [1] "@"
## attr(,"G")
## [1] "#"
base::paste(x, y1)
## [1] "1 1"    "NA 2"   "100 3"  "1000 1"
base::paste(x, y2)
## [1] "1 1"    "NA 2"   "100 3"  "1000 4"
base::paste(x, y3)
## [1] "1 1"    "NA 2"   "100 3"  "1000 4"
stringx::paste(x, y1)
## Warning in stri_join(..., sep = sep, collapse = collapse, ignore_null = !
## isTRUE(recycle0)): longer object length is not a multiple of shorter object
## length
## [1] "1 1"    NA       "100 3"  "1000 1"
stringx::paste(x, y2)
## [1] "1 1"    NA       "100 3"  "1000 4"
stringx::paste(x, y3)
## [1] "1 1"    NA       "100 3"  "1000 4"
base::paste(x, character(0), y2, sep=",")
## [1] "1,,1"    "NA,,2"   "100,,3"  "1000,,4"
stringx::paste(x, character(0), y2, sep=",")
## [1] "1,1"    NA       "100,3"  "1000,4"
x %+% y1
## Warning in stringi::`%s+%`(e1, e2): longer object length is not a multiple of
## shorter object length
##       x       y       z       w 
##    "11"      NA  "1003" "10001" 
## attr(,"F")
## [1] "*"
x %+% y2
##       x       y       z       w 
##    "11"      NA  "1003" "10004" 
## attr(,"G")
## [1] "#"
## attr(,"F")
## [1] "*"
x %+% y3
##      a    b      
## [1,] "11" "1003" 
## [2,] NA   "10004"
## attr(,"G")
## [1] "#"
## attr(,"F")
## [1] "*"
y2 %+% x
##       a       b       c       d 
##    "11"      NA  "3100" "41000" 
## attr(,"F")
## [1] "@"
## attr(,"G")
## [1] "#"
x %+% character(0)
## character(0)
strcat(x, collapse=",")
## [1] NA
strcat(x, collapse=",", na.rm=TRUE)
## [1] "1,100,1000"
```
