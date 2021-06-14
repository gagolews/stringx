# sort: Sort Strings

## Description

The `sort` method for objects of class `character` (`sort.character`) uses the locale-sensitive Unicode collation algorithm to arrange strings in a vector in a lexicographic order. `xtfrm` (TODO: does anyone know what does this name stand for?) generates an integer vector that sorts in the same way as its input, and hence can be used in conjunction with [`order`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/order.html) or [`rank`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/rank.html).

## Usage

```r
xtfrm(x, ...)

## Default S3 method:
xtfrm(x, ...)

## S3 method for class 'character'
xtfrm(
  x,
  locale = NULL,
  strength = 3L,
  alternate_shifted = FALSE,
  french = FALSE,
  uppercase_first = NA,
  case_level = FALSE,
  normalisation = FALSE,
  numeric = FALSE,
  ...
)

## S3 method for class 'character'
sort(
  x,
  decreasing = FALSE,
  na.last = NA,
  locale = NULL,
  strength = 3L,
  alternate_shifted = FALSE,
  french = FALSE,
  uppercase_first = NA,
  case_level = FALSE,
  normalisation = FALSE,
  numeric = FALSE,
  ...
)
```

## Arguments

|                     |                                                                                                                                                                                   |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`                 | character vector whose elements are to be sorted                                                                                                                                  |
| `...`               | further arguments passed to other methods                                                                                                                                         |
| `locale`            | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `strength`          | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `alternate_shifted` | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `french`            | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `uppercase_first`   | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `case_level`        | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `normalisation`     | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `numeric`           | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html)                                                                                           |
| `decreasing`        | single logical value; if `FALSE`, the ordering is nondecreasing (weakly increasing)                                                                                               |
| `na.last`           | single logical value; if `TRUE`, then missing values are placed at the end; if `FALSE`, they are put at the beginning; if `NA`, then they are removed from the output whatsoever. |

## Details

Replacements for the default S3 methods [`sort`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/sort.html) and [`xtfrm`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/xtfrm.html) for character vectors implemented with [`stri_sort`](https://stringi.gagolewski.com/rapi/stri_sort.html) and [`stri_rank`](https://stringi.gagolewski.com/rapi/stri_rank.html).

Inconsistencies in base R and the way we have addressed them here:

-   Collation in different locales is difficult and non-portable across platforms **\[fixed here -- using services provided by ICU\]**

-   Overloading `xtfrm.character` has no effect in R, because S3 method dispatch is done internally with hard-coded support for character arguments. Thus, we needed to replace the generic `xtfrm` with the one that calls [`UseMethod`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/UseMethod.html) **\[fixed here\]**

-   `xtfrm` does not support customisation of the linear ordering relation it is based upon **\[fixed by introducing `...` argument to the generic\]**

-   Neither [`order`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/order.html), [`rank`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/rank.html), nor [`sort.list`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/sort.list.html) is a generic, therefore they should have to be rewritten from scratch to allow the inclusion of our patches; interestingly, `order` even calls `xtfrm`, but only for classed objects **\[not fixed here -- see Examples for a workaround\]**

-   `xtfrm` for objects of type `character` does not preserve the names attribute (but does so for `numeric`) **\[fixed here\]**

-   `sort` seems to preserve only the names attribute which makes sense if `na.last` is `NA`, because the resulting vector might be shorter **\[not fixed here as it would break compatibility with other sorting methods\]**

-   Note that `sort` by default removes missing values whatsoever, whereas [`order`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/order.html) has `na.last=TRUE` **\[not fixed here as it would break compatibility with other sorting methods\]**

## Value

`sort.character` returns a character vector, with only the `names` attribute preserved. Note that the output vector may be shorter than the input one.

`xtfrm.character` returns an integer vector; most attributes are preserved.

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`strcoll`](strcoll.md)

## Examples




```r
x <- c("a1", "a100", "a101", "a1000", "a10", "a10", "a11", "a99", "a10", "a1")
base::sort.default(x)   # lexicographic sort
##  [1] "a1"    "a1"    "a10"   "a10"   "a10"   "a100"  "a1000" "a101"  "a11"  
## [10] "a99"
sort(x, numeric=TRUE)   # calls stringx:::sort.character
##  [1] "a1"    "a1"    "a10"   "a10"   "a10"   "a11"   "a99"   "a100"  "a101" 
## [10] "a1000"
xtfrm(x, numeric=TRUE)  # calls stringx:::xtfrm.character
##  [1]  1  8  9 10  3  3  6  7  3  1
rank(xtfrm(x, numeric=TRUE), ties.method="average")  # ranks with averaged ties
##  [1]  1.5  8.0  9.0 10.0  4.0  4.0  6.0  7.0  4.0  1.5
order(xtfrm(x, numeric=TRUE))    # ordering permutation
##  [1]  1 10  5  6  9  7  8  2  3  4
x[order(xtfrm(x, numeric=TRUE))] # equivalent to sort()
##  [1] "a1"    "a1"    "a10"   "a10"   "a10"   "a11"   "a99"   "a100"  "a101" 
## [10] "a1000"
# order a data frame w.r.t. decreasing ids and increasing vals
d <- data.frame(vals=round(runif(length(x)), 1), ids=x)
d[order(-xtfrm(d[["ids"]], numeric=TRUE), d[["vals"]]), ]
##    vals   ids
## 4   0.9 a1000
## 3   0.4  a101
## 2   0.8  a100
## 8   0.9   a99
## 7   0.5   a11
## 6   0.0   a10
## 9   0.6   a10
## 5   0.9   a10
## 1   0.3    a1
## 10  0.5    a1
```