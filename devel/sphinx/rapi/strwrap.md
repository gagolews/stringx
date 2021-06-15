# strwrap: Word-Wrap Text

## Description

Splits each string into words which are then arranged to form text lines of no more of a given width. Might be useful when displaying strings using a monospaced font.

## Usage

```r
strwrap(
  x,
  width = 0.9 * getOption("width"),
  indent = 0,
  exdent = 0,
  prefix = "",
  simplify = TRUE,
  initial = prefix,
  locale = NULL
)
```

## Arguments

|            |                                                                                                                                                                                                                                                            |
|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`        | character vector whose elements are to be word-wrapped                                                                                                                                                                                                     |
| `width`    | single integer; maximal total width of the code points per line (as determined by [`stri_width`](https://stringi.gagolewski.com/rapi/stri_width.html))                                                                                                     |
| `indent`   | single integer; first line indentation size                                                                                                                                                                                                                |
| `exdent`   | single integer; consequent lines indentation size                                                                                                                                                                                                          |
| `prefix`   | single string; prefix for each line except the first                                                                                                                                                                                                       |
| `simplify` | see Value                                                                                                                                                                                                                                                  |
| `initial`  | single string; prefix for the first line                                                                                                                                                                                                                   |
| `locale`   | `NULL` or `""` for the default locale (see [`stri_locale_get`](https://stringi.gagolewski.com/rapi/stri_locale_set.html)) or a single string with a locale identifier, see [`stri_locale_list`](https://stringi.gagolewski.com/rapi/stri_locale_list.html) |

## Details

Replacement for base [`strwrap`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strwrap.html) implemented with [`stri_wrap`](https://stringi.gagolewski.com/rapi/stri_wrap.html).

Inconsistencies/limitations in/differences from base R:

-   missing values not propagated **\[fixed here\]**

-   some emojis, combining characters and modifiers (e.g., skin tones) are not recognised properly **\[fixed here\]**

-   what is considered a word does not depend on locale **\[fixed here - using <span class="pkg">ICU</span>\'s word break iterators\]**

-   multiple whitespaces between words are not preserved except after a dot, question mark, or exclamation mark, which leads to two spaces inserted **\[changed here -- any sequence of whitespaces considered word boundaries is converted to a single space\]**

-   a greedy word wrap algorithm is used, which may lead to high raggedness **\[fixed here -- using the Knuth-Plass method\]**

## Value

If `simplify` is `FALSE`, a list of `length(x)` numeric vectors is returned.

Otherwise, the function yields a character vector (in UTF-8). Note that the length of the output may be different than that of the input.

Due to this, no attributes are preserved.

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## References

D.E. Knuth, M.F. Plass, Breaking paragraphs into lines, *Software: Practice and Experience* 11(11), 1981, pp. 1119--1184.

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`sprintf`](sprintf.md), [`trimws`](trimws.md), [`nchar`](nchar.md)

## Examples




```r
strwrap(paste0(
    strrep("az ", 20),
    strrep("\u0105\u20AC ", 20),
    strrep("\U0001F643 ", 20),
    strrep("\U0001F926\U0000200D\U00002642\U0000FE0F ", 20)
), width=60)
## [1] "az az az az az az az az az az az az az az az az az az az az"                    
## [2] "ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€ ą€"                    
## [3] "🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃 🙃"                    
## [4] "🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️ 🤦‍♂️"
```
