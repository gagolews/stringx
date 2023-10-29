# substr: Extract or Replace Substrings

## Description

`substr` and `substrl` extract contiguous parts of given character strings. The former operates based on start and end positions while the latter is fed with substring lengths.

Their replacement versions allow for substituting parts of strings with new content.

`gsubstr` and `gsubstrl` allow for extracting or replacing multiple chunks from each string.

## Usage

``` r
substr(x, start = 1L, stop = -1L)

substrl(
  x,
  start = 1L,
  length = attr(start, "match.length"),
  ignore_negative_length = FALSE
)

substr(x, start = 1L, stop = -1L) <- value

substrl(x, start = 1L, length = attr(start, "match.length")) <- value

gsubstr(x, start = list(1L), stop = list(-1L))

gsubstrl(
  x,
  start = list(1L),
  length = lapply(start, attr, "match.length"),
  ignore_negative_length = TRUE
)

gsubstr(x, start = list(1L), stop = list(-1L)) <- value

gsubstrl(x, start = list(1L), length = lapply(start, attr, "match.length")) <- value

substring(text, first = 1L, last = -1L)

substring(text, first = 1L, last = -1L) <- value
```

## Arguments

|                          |                                                                                                                                                                                                                                                 |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`, `text`              | character vector whose parts are to be extracted/replaced                                                                                                                                                                                       |
| `start`, `first`         | numeric vector (for `substr`) or list of numeric vectors (for `gsubstr`) giving the start indexes; e.g., 1 denotes the first code point; negative indexes count from the end of a string, i.e., -1 is the last character                        |
| `stop`, `last`           | numeric vector (for `substr`) or list of numeric vectors (for `gsubstr`) giving the end indexes (inclusive); note that if the start position is farther than the end position, this indicates an empty substring therein (see Examples)         |
| `length`                 | numeric vector (for `substr`) or list of numeric vectors (for `gsubstr`) giving the substring lengths; negative lengths result in a missing value or empty vector (see `ignore_negative_length`) or the corresponding substring being unchanged |
| `ignore_negative_length` | single logical value; whether negative lengths should be ignored or yield missing values                                                                                                                                                        |
| `value`                  | character vector (for `substr`) or list of character vectors (for `gsubstr`) defining the replacements strings                                                                                                                                  |

## Details

Not to be confused with [`sub`](gsub.md).

`substring` is a \[DEPRECATED\] synonym for `substr`.

Note that these functions can break some meaningful Unicode code point sequences, e.g., when inputs are not normalised. For extracting initial parts of strings based on character width, see [`strtrim`](strtrim.md).

Note that `gsubstr` (and related functions) expect `start`, `stop`, `length`, and `value` to be lists. Non-list arguments will be converted by calling [`as.list`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/as.list.html). This is different from the default policy applied by [`stri_sub_all`](https://stringi.gagolewski.com/rapi/stri_sub_all.html), which calls [`list`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/list.html).

Note that `substrl` and `gsubstrl` are interoperable with [`regexpr2`](gregexpr.md) and [`gregexpr2`](gregexpr.md), respectively, and hence can be considered as substituted for the \[DEPRECATED\] [`regmatches`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/regmatches.html) (which is more specialised).

## Value

`substr` and `substrl` return a character vector (in UTF-8). `gsubstr` and `gsubstrl` return a list of character vectors.

Their replacement versions modify `x` \'in-place\' (see Examples).

The attributes are copied from the longest arguments (similar to binary operators).

## Differences from Base R

Replacements for and enhancements of base [`substr`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/substr.html) and [`substring`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/substring.html) implemented with [`stri_sub`](https://stringi.gagolewski.com/rapi/stri_sub.html) and [`stri_sub_all`](https://stringi.gagolewski.com/rapi/stri_sub_all.html),

-   `substring` is \"for compatibility with S\", but this should no longer matter **\[here, `substring` is equivalent to `substr`; in a future version, using the former may result in a warning\]**

-   `substr` is not vectorised with respect to all the arguments (and `substring` is not fully vectorised wrt `value`) **\[fixed here\]**

-   not all attributes are taken from the longest of the inputs **\[fixed here\]**

-   partial recycling with no warning **\[fixed here\]**

-   the replacement must be of the same length as the chunk being substituted **\[fixed here\]**

-   negative indexes are silently treated as 1 **\[changed here: negative indexes count from the end of the string\]**

-   replacement of different length than the extracted substring never changes the length of the string **\[changed here -- output length is input length minus length of extracted plus length of replacement\]**

-   [`regexpr`](gregexpr.md) (amongst others) return start positions and lengths of matches, but base `substr` only uses start and end **\[fixed by introducing `substrl`\]**

-   there is no function to extract or replace multiple chunks in each string (other than [`regmatches`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/regmatches.html) that works on outputs generated by [`gregexpr`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/gregexpr.html) et al.) **\[fixed by introducing `gsubstrl`\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`strtrim`](strtrim.md), [`nchar`](nchar.md), [`startsWith`](startswith.md), [`endsWith`](startswith.md), [`gregexpr`](gregexpr.md)

## Examples




```r
x <- "spam, spam, bacon, and spam"
base::substr(x, c(1, 13), c(4, 17))
```

```
## [1] "spam"
```

```r
base::substring(x, c(1, 13), c(4, 17))
```

```
## [1] "spam"  "bacon"
```

```r
substr(x, c(1, 13), c(4, 17))
```

```
## [1] "spam"  "bacon"
```

```r
substrl(x, c(1, 13), c(4, 5))
```

```
## [1] "spam"  "bacon"
```

```r
# replacement function used as an ordinary one - return a copy of x:
base::`substr<-`(x, 1, 4, value="jam")
```

```
## [1] "jamm, spam, bacon, and spam"
```

```r
`substr<-`(x, 1, 4, value="jam")
```

```
## [1] "jam, spam, bacon, and spam"
```

```r
base::`substr<-`(x, 1, 4, value="porridge")
```

```
## [1] "porr, spam, bacon, and spam"
```

```r
`substr<-`(x, 1, 4, value="porridge")
```

```
## [1] "porridge, spam, bacon, and spam"
```

```r
# interoperability with gregexpr2:
p <- "[\\w&&[^a]][\\w&&[^n]][\\w&&[^d]]\\w+"  # regex: all words but 'and'
gsubstrl(x, gregexpr2(x, p))
```

```
## [[1]]
## [1] "spam"  "spam"  "bacon" "spam"
```

```r
`gsubstrl<-`(x, gregexpr2(x, p), value=list(c("a", "b", "c", "d")))
```

```
## [1] "a, b, c, and d"
```

```r
# replacement function modifying x in-place:
substr(x, 1, 4) <- "eggs"
substr(x, 1, 0) <- "porridge, "        # prepend (start<stop)
substr(x, nchar(x)+1) <- " every day"  # append (start<stop)
print(x)
```

```
## [1] "porridge, eggs, spam, bacon, and spam every day"
```
