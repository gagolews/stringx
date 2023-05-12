# trimws: Trim Leading or Trailing Whitespaces

## Description

Removes whitespaces (or other code points as specified by the `whitespace` argument) from left, right, or both sides of each string.

## Usage

``` r
trimws(x, which = "both", whitespace = "\\p{Wspace}")
```

## Arguments

|                                    |                                                                                                                                                                                                      |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`{#trimws_:_x}                   | character vector whose elements are to be trimmed                                                                                                                                                    |
| `which`{#trimws_:_which}           | single string; either `"both"`, `"left"`, or `"right"`; side(s) from which the code points matching the `whitespace` pattern are to be removed                                                       |
| `whitespace`{#trimws_:_whitespace} | single string; specifies the set of Unicode code points for removal, see \'Character Classes\' in [about_search_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html) for more details |

## Details

Not to be confused with [`strtrim`](strtrim.md).

## Value

Returns a character vector (in UTF-8).

## Differences from Base R

Replacement for base [`trimws`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/trimws.html) implemented with [`stri_replace_all_regex`](https://stringi.gagolewski.com/rapi/stri_replace.html) (and not [`stri_trim`](https://stringi.gagolewski.com/rapi/stri_trim.html), which uses a slightly different syntax for pattern specifiers).

-   the default `whitespace` argument does not reflect the \'contemporary\' definition of whitespaces (e.g., does not include zero-width spaces) **\[fixed here\]**

-   base R implementation is not portable as it is based on the system PCRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category) **\[fixed here\]**

-   no sanity checks are performed on `whitespace` **\[fixed here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`sub`](gsub.md)

## Examples




```r
base::trimws("NAAAAANA!!!NANAAAAA", whitespace=NA)  # stringx raises an error
## [1] "NA!!!NA"
x <- "   :)\v\u00a0 \n\r\t"
base::trimws(x)
## [1] ":)\v "
stringx::trimws(x)
## [1] ":)"
```
