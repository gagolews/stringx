# sprintf: Format Strings

## Description

`sprintf` creates strings from a given template and the arguments provided. A new function (present in C and many other languages), `printf`, displays formatted strings.

## Usage

``` r
sprintf(fmt, ..., na_string = NA_character_)

printf(fmt, ..., file = "", sep = "\n", append = FALSE, na_string = "NA")
```

## Arguments

|  |  |
|----|----|
| `fmt` | character vector of format strings |
| `...` | vectors with data to format (coercible to integer, real, or character) |
| `na_string` | single string to represent missing values; if `NA`, missing values in `...` result in the corresponding outputs be missing too |
| `file` | see [`cat`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/cat.html) |
| `sep` | see [`cat`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/cat.html) |
| `append` | see [`cat`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/cat.html) |

## Details

Note that the purpose of `printf` is to display a string, not to create a new one for use elsewhere, therefore this function, as an exception, treats missing values as `"NA"` strings.

## Value

`sprintf` returns a character vector (in UTF-8). No attributes are preserved. `printf` returns \'nothing\'.

## Differences from Base R

Replacement for base [`sprintf`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/sprintf.html) implemented with [`stri_sprintf`](https://stringi.gagolewski.com/rapi/stri_sprintf.html).

-   missing values in `...` are treated as `"NA"` strings **\[fixed in `sprintf`, left in `printf`, but see the `na_string` argument\]**

-   partial recycling results in an error **\[fixed here -- warning given\]**

-   input objects\' attributes are not preserved **\[not fixed, somewhat tricky\]**

-   in to-string conversions, field widths and precisions are interpreted as bytes which is of course problematic for text in UTF-8 **\[fixed by interpreting these as Unicode code point widths\]**

-   `fmt` is limited to 8192 bytes and the number of arguments passed via `...` to 99 (note that we can easily exceed this limit by using [`do.call`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/do.call.html)) **\[rewritten from scratch, there is no limit anymore\]**

-   unused values in `...` are evaluated anyway (should not evaluation be lazy?) **\[not fixed here because this is somewhat questionable; in both base R and our case, a warning is given if this is the case; moreover, the length of the longest argument always determines the length of the output\]**

-   coercion of each argument can only be done once **\[fixed here - can coerce to integer, real, and character\]**

-   either width or precision can be fetched from `...`, but not both **\[fixed here - two asterisks are allowed in format specifiers\]**

-   `NA`/`NaNs` are not prefixed by a sign/space even if we explicitly request this **\[fixed here - prefixed by a space\]**

-   the outputs are implementation-dependent; the format strings are passed down to the system (`libc`) `sprintf` function **\[not fixed here (yet), but the format specifiers are normalised more eagerly\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`strrep`](strrep.md), [`strtrim`](strtrim.md), [`substr`](substr.md), [`nchar`](nchar.md), [`strwrap`](strwrap.md)

## Examples




``` r
# UTF-8 number of bytes vs Unicode code point width:
l <- c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2", "\U0001f602\U0001f603")
r <- c(exp(1), exp(2), pi, pi^2, NaN)
cat(base::sprintf("%8s=%+.3f", l, r), sep="\n")
```

```
##        e=+2.718
##      e²=+7.389
##       π=+3.142
##     π²=+9.870
## 😂😃=NaN
```

``` r
cat(stringx::sprintf("%8s=%+.3f", l, r), sep="\n")
```

```
##        e=+2.718
##       e²=+7.389
##        π=+3.142
##       π²=+9.870
##     😂😃= NaN
```
