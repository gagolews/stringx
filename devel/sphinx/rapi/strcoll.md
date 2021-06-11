# strcoll: Compare Strings

## Description

These functions provide means to compare strings in any locale using the Unicode collation algorithm.

## Usage

```r
strcoll(
  e1,
  e2,
  locale = NULL,
  strength = 3L,
  alternate_shifted = FALSE,
  french = FALSE,
  uppercase_first = NA,
  case_level = FALSE,
  normalisation = FALSE,
  numeric = FALSE
)

e1 %x<% e2

e1 %x<=% e2

e1 %x==% e2

e1 %x!=% e2

e1 %x>% e2

e1 %x>=% e2
```

## Arguments

|                     |                                                                                         |
|---------------------|-----------------------------------------------------------------------------------------|
| `e1, e2`            | character vector whose corresponding elements are to be compared                        |
| `locale`            | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |
| `strength`          | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |
| `alternate_shifted` | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |
| `french`            | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |
| `uppercase_first`   | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |
| `case_level`        | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |
| `normalisation`     | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |
| `numeric`           | see [`stri_opts_collator`](https://stringi.gagolewski.com/rapi/stri_opts_collator.html) |

## Details

Replacements for base [Comparison](https://stat.ethz.ch/R-manual/R-devel/library/base/help/Comparison.html) operators implemented with [`stri_cmp`](https://stringi.gagolewski.com/rapi/stri_compare.html).

Arguments are recycled if necessary.

For a locale-insensitive behaviour like that of `strcmp` from the standard C library, call `strcoll(e1, e2, locale="C", strength=4L, normalisation=FALSE)`. However, still some normalisation will be performed.

Inconsistencies in base R and the way we have addressed them here:

-   collation in different locales is difficult and non-portable across platforms **\[fixed here -- using services provided by ICU\]**

-   overloading `` `<.character` `` has no effect in R, because S3 method dispatch is done internally with hard-coded support for character arguments. We could have replaced the generic `` `<` `` with the one that calls [`UseMethod`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/UseMethod.html), but it feels like a too intrusive solution **\[fixed by introducing `` `%x<%` `` operator\]**

## Value

`strcmp` returns an integer vector representing the comparison results: if a string in `e1` is smaller than the corresponding string in `e2`, the corresponding result will be equal to `-1`, and `0` if they are canonically equivalent, as well as `1` if the former is greater than the latter.

The binary operators call `strcoll` with default arguments and return logical vectors.

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`xtfrm`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/xtfrm.html)

## Examples




```r
# lexicographic vs. numeric sort
strcoll("100", c("1", "10", "11", "99", "100", "101", "1000"))
## [1]  1  1 -1 -1  0 -1 -1
strcoll("100", c("1", "10", "11", "99", "100", "101", "1000"), numeric=TRUE)
## [1]  1  1  1  1  0 -1 -1
strcoll("hladn\u00FD", "chladn\u00FD", locale="sk_SK")
## [1] -1
```
