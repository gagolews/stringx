# paste: Concatenate Strings

## Description

Concatenate (join) the corresponding and/or consecutive elements of given vectors, after converting them to strings.

## Usage

``` r
paste(..., sep = " ", collapse = NULL, recycle0 = FALSE)

paste0(..., sep = "", collapse = NULL, recycle0 = FALSE)

e1 %x+% e2

strcat(x, collapse = "", na.rm = FALSE)
```

## Arguments

|  |  |
|----|----|
| `...` | character vectors (or objects coercible to) whose corresponding/consecutive elements are to be concatenated |
| `sep` | single string; separates terms |
| `collapse` | single string or `NULL`; an optional separator if tokens are to be merged into a single string |
| `recycle0` | single logical value; if `FALSE`, then empty vectors provided via `...` are silently ignored |
| `e1`, `e2` | character vectors (or objects coercible to) whose corresponding elements are to be concatenated |
| `x` | character vector (or an object coercible to) whose consecutive elements are to be concatenated |
| `na.rm` | single logical value; if `TRUE`, missing values are silently ignored |

## Details

`` `%x+%` `` is an operator that concatenates corresponding strings from two character vectors (and which behaves just like the arithmetic `` `+` `` operator).

`strcat` joins (aggregates based on string concatenation) consecutive strings in a character vector, possibly with a specified separator in place, into a single string.

`paste` and `paste0`, concatenate a number of vectors using the same separator and then possibly join them into a single string. We recommend using `` `%x+%` ``, [`sprintf`](sprintf.md), and `strcat` instead (see below for discussion).

## Value

A character vector (in UTF-8).

`` `%x+%` `` preserves object attributes in a similar way as other [Arithmetic](https://stat.ethz.ch/R-manual/R-devel/library/base/help/Arithmetic.html) operators (however, they may be lost during `as.character(...)` conversion, which is an S3 generic).

`strcat` is an aggregation function, therefore it preserves no attributes whatsoever.

Currently, `paste` and `paste0` preserve no attributes too.

## Differences from Base R

Replacement for base [`paste`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/paste.html) implemented with [`stri_join`](https://stringi.gagolewski.com/rapi/stri_join.html).

Note that `paste` can be thought of as a string counterpart of both the `` `+` `` operator (actually, some languages do have a binary operator for string concatenation, e.g., `` `.` `` in Perl and PHP, `` `+` `` (`str.__add__`) in Python; R should have it too, but does not) which is additionally vectorised (\'Map\') and the [`sum`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/sum.html) function (\'Reduce\'). Therefore, we would expect it to behave similarly with regards to the propagation of missing values and the preservation of object attributes, but it does not.

-   missing values treated as `"NA"` strings (it is a well-documented feature though) **\[fixed here\]**

-   partial recycling with no warning \"longer object length is not a multiple of shorter object length\" **\[fixed here\]**

-   empty vectors are treated as vectors of empty strings **\[fixed here\]**

-   input objects\' attributes are not preserved **\[fixed only in `` `%x+%` `` operator\]**

-   `paste0` multiplies entities without necessity; `sep=""` should be the default in `paste` **\[not fixed\]**

-   `paste0` treats the named argument `sep="..."` as one more vector to concatenate **\[fixed by introducing `sep` argument\]**

-   overloading `` `+.character` `` has no effect in R, because S3 method dispatch is done internally with hard-coded support for character arguments. We could have replaced the generic `` `+` `` with the one that calls [`UseMethod`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/UseMethod.html), but the dispatch would be done on the type of the first argument anyway (not to mention it feels like a too intrusive solution). Actually having a separate operator for concatenation (similar to PHP\'s or Perl\'s `` `.` ``) which always coerces to character frees the user from manual coercion (is it such a burden on the other hand?) **\[fixed by introducing `` `%x+%` `` operator\]**

It should also be noted that `paste` with `collapse=NULL` is a special case of `sprintf` (which is featured in many programming languages; R\'s version is of course vectorised). For instance, `paste(x, y, sep=",")` is equivalent to `sprintf("%s,%s", x, y)`.

Taking into account the above, `paste` and `paste0` seem redundant and hence we mark them as \[DEPRECATED\]. Here are our recommendations:

-   the most frequent use case - concatenating corresponding strings from two character vectors with no separator - is covered by a new operator `` `%x+%` `` which propagates NAs correctly and handles object attributes the same way as the built-in arithmetic operators;

-   for fancy elementwise (like \'Map\') concatenation, use our version of [`sprintf`](sprintf.md);

-   for the \'flattening\' of consecutive strings in a character vector (like \'Reduce\'), use the new function `strcat`.

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`strrep`](strrep.md), [`sprintf`](sprintf.md)

## Examples




``` r
# behaviour of `+` vs. base::paste vs. stringx::paste
x <- structure(c(x=1, y=NA, z=100, w=1000), F="*")
y1 <- structure(c(a=1, b=2, c=3), G="#", F="@")
y2 <- structure(c(a=1, b=2, c=3, d=4), G="#", F="@")
y3 <- structure(1:4, G="#", F="@", dim=c(2, 2), dimnames=list(NULL, c("a", "b")))
x + y1
```

```
## Warning in x + y1: longer object length is not a multiple of shorter object
## length
```

```
##    x    y    z    w 
##    2   NA  103 1001 
## attr(,"F")
## [1] "*"
```

``` r
x + y2
```

```
##    x    y    z    w 
##    2   NA  103 1004 
## attr(,"G")
## [1] "#"
## attr(,"F")
## [1] "*"
```

``` r
x + y3
```

```
##       a    b
## [1,]  2  103
## [2,] NA 1004
## attr(,"G")
## [1] "#"
## attr(,"F")
## [1] "*"
```

``` r
y2 + x
```

```
##    a    b    c    d 
##    2   NA  103 1004 
## attr(,"F")
## [1] "@"
## attr(,"G")
## [1] "#"
```

``` r
base::paste(x, y1)
```

```
## [1] "1 1"    "NA 2"   "100 3"  "1000 1"
```

``` r
base::paste(x, y2)
```

```
## [1] "1 1"    "NA 2"   "100 3"  "1000 4"
```

``` r
base::paste(x, y3)
```

```
## [1] "1 1"    "NA 2"   "100 3"  "1000 4"
```

``` r
stringx::paste(x, y1)
```

```
## Warning in (function (..., sep = "", collapse = NULL, ignore_null = FALSE) :
## longer object length is not a multiple of shorter object length
```

```
## [1] "1 1"    NA       "100 3"  "1000 1"
```

``` r
stringx::paste(x, y2)
```

```
## [1] "1 1"    NA       "100 3"  "1000 4"
```

``` r
stringx::paste(x, y3)
```

```
## [1] "1 1"    NA       "100 3"  "1000 4"
```

``` r
base::paste(x, character(0), y2, sep=",")
```

```
## [1] "1,,1"    "NA,,2"   "100,,3"  "1000,,4"
```

``` r
stringx::paste(x, character(0), y2, sep=",")
```

```
## [1] "1,1"    NA       "100,3"  "1000,4"
```

``` r
x %x+% y1
```

```
## Warning in stringi::`%s+%`(e1, e2): longer object length is not a multiple of
## shorter object length
```

```
## [1] "11"    NA      "1003"  "10001"
```

``` r
x %x+% y2
```

```
## [1] "11"    NA      "1003"  "10004"
```

``` r
x %x+% y3
```

```
## [1] "11"    NA      "1003"  "10004"
```

``` r
y2 %x+% x
```

```
## [1] "11"    NA      "3100"  "41000"
```

``` r
x %x+% character(0)
```

```
## character(0)
```

``` r
strcat(x, collapse=",")
```

```
## [1] NA
```

``` r
strcat(x, collapse=",", na.rm=TRUE)
```

```
## [1] "1,100,1000"
```
