# nchar: Get Length or Width of Strings

## Description

`nchar` computes the number of code points, bytes used, or estimated total width of strings in a character vector. `nzchar` indicates which strings are empty.

## Usage

```r
nchar(x, type = "chars", allowNA = FALSE, keepNA = TRUE)

nzchar(x, keepNA = TRUE)
```

## Arguments

|           |                                                                                                                            |
|-----------|----------------------------------------------------------------------------------------------------------------------------|
| `x`       | character vector or an object coercible to                                                                                 |
| `type`    | `"chars"` gives the number of code points, `"width"` estimates the string width, `"bytes"` computes the number of bytes    |
| `allowNA` | not used                                                                                                                   |
| `keepNA`  | if `FALSE`, missing values will be treated as `"NA"` strings; otherwise, the corresponding outputs will be missing as well |

## Details

Replacement for base [`nchar`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/nchar.html) and [`nzchar`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/nzchar.html) implemented with [`stri_length`](https://stringi.gagolewski.com/rapi/stri_length.html), [`stri_width`](https://stringi.gagolewski.com/rapi/stri_width.html), [`stri_numbytes`](https://stringi.gagolewski.com/rapi/stri_numbytes.html), and [`stri_isempty`](https://stringi.gagolewski.com/rapi/stri_isempty.html)

Inconsistencies in base R and the way we have addressed them here:

-   `keepNA` does not default to `TRUE`, and hence missing values are treated as `"NA"` strings **\[fixed here\]**

-   some emojis, combining characters and modifiers (e.g., skin tones) are not recognised properly **\[fixed here\]**

-   only the `names` attribute is propagated **\[fixed here\]**

## Value

`nchar` returns an integer vector.

`nzchar` returns a logical vector, where `TRUE` indicates that the corresponding string is of non-zero length (i.e., non-empty).

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`sprintf`](sprintf.md), [`substr`](substr.md), [`strtrim`](strtrim.md)

## Examples




```r
x <- c(
    "\U0001F4A9",
    "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
    "\U0001F64D\U0001F3FB\U0000200D\U00002642",
    "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
    "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
)
print(x)
## [1] "💩"    "🙍🏼‍♂️" "🙍🏻‍♂" "⛹🏿‍♀️"  "🏴󠁧󠁢󠁳󠁣󠁴󠁿"
base::nchar(x, "width")
## [1] 2 5 5 4 2
stringx::nchar(x, "width")
## [1] 2 2 2 2 2
```
