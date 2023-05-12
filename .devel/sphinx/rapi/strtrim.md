# strtrim: Shorten Strings to Specified Width

## Description

Right-trims strings so that they do not exceed a given width (as determined by [`stri_width`](https://stringi.gagolewski.com/rapi/stri_width.html)).

## Usage

``` r
strtrim(x, width)
```

## Arguments

|         |                                                                                       |
|---------|---------------------------------------------------------------------------------------|
| `x`     | character vector whose elements are to be trimmed                                     |
| `width` | numeric vector giving the widths to which the corresponding strings are to be trimmed |

## Details

Both arguments are recycled if necessary.

Not to be confused with [`trimws`](trimws.md).

Might be useful when displaying strings using a monospaced font.

## Value

Returns a character vector (in UTF-8). Preserves object attributes in a similar way as [Arithmetic](https://stat.ethz.ch/R-manual/R-devel/library/base/help/Arithmetic.html) operators.

## Differences from Base R

Replacement for base [`strtrim`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strtrim.html) implemented with (special case of) [`stri_sprintf`](https://stringi.gagolewski.com/rapi/stri_sprintf.html).

-   both arguments are not recycled in an usual manner **\[fixed here\]**

-   missing values are not allowed in `width` **\[fixed here\]**

-   some emojis, combining characters and modifiers (e.g., skin tones) are not recognised properly **\[fixed here\]**

-   attributes are only propagated from the 1st argument **\[fixed\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`sprintf`](sprintf.md), [`substr`](substr.md), [`nchar`](nchar.md)

## Examples




```r
base::strtrim("aaaaa", 1:3)
## [1] "a"
stringx::strtrim("aaaaa", 1:3)
## [1] "a"   "aa"  "aaa"
x <- c(
    "\U0001F4A9",
    "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
    "\U0001F64D\U0001F3FB\U0000200D\U00002642",
    "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
    "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
)
print(x)
## [1] "💩"    "🙍🏼‍♂️" "🙍🏻‍♂" "⛹🏿‍♀️"  "🏴󠁧󠁢󠁳󠁣󠁴󠁿"
base::strtrim(x, 2)
## [1] "💩" "🙍" "🙍" "⛹"  "🏴󠁧󠁢󠁳󠁣󠁴󠁿"
stringx::strtrim(x, 2)
## [1] "💩"    "🙍🏼‍♂️" "🙍🏻‍♂" "⛹🏿‍♀️"  "🏴󠁧󠁢󠁳󠁣󠁴󠁿"
```
