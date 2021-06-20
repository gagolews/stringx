# substr: Extract or Replace Substrings

## Description

`substr` and `substrl` extract contiguous parts of given character strings. The former operates based on start and end positions while the later is fed with start position and substring length.

Their replacement versions allows for substituting them with new content.

## Usage

```r
substr(x, start = 1L, stop = -1L)

substrl(x, start = 1L, length)

substring(text, first = 1L, last = -1L)

substr(x, start = 1L, stop = -1L) <- value

substrl(x, start = 1L, length) <- value

substring(text, first = 1L, last = -1L) <- value
```

## Arguments

|                |                                                                                                                                                                                                                                                                 |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x, text`      | character vector whose parts are to be extracted/replaced                                                                                                                                                                                                       |
| `start, first` | numeric vector giving the start indexes; e.g., 1 points to the first code point, -1 to the last                                                                                                                                                                 |
| `stop, last`   | numeric vector giving the end indexes (inclusive); as with `start`, for negative indexes, counting starts at the end of each string; note that if the start position is farther than the end position, this indicates an empty substring therein (see Examples) |
| `length`       | numeric vector giving the substring lengths                                                                                                                                                                                                                     |
| `value`        | character vector defining the replacements strings                                                                                                                                                                                                              |

## Details

Not to be confused with [`sub`](gsub.md).

`substring` is a \[DEPRECATED\] synonym for `substr`.

Note that these functions can break some meaningful Unicode code point sequences, e.g., when inputs are not normalised. For extracting initial parts of strings based on character width, see [`strtrim`](strtrim.md).

## Value

`substr` and `substrl` return a character vector (in UTF-8). Their replacement versions modify `x` \'in-place\' (see Examples).

The attributes are copied from the longest arguments (similarly as in the case of binary operators).

## Differences from Base R

Replacement for base [`substr`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/substr.html) and [`substring`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/substring.html) implemented with [`stri_sub`](https://stringi.gagolewski.com/rapi/stri_sub.html).

-   `substring` is \"for compatibility with S\", but this should no longer matter **\[here, `substring` is equivalent to `substr`; in a future version, using the former may result in a warning\]**

-   `substr` is not vectorised with respect to all the arguments (and `substring` is not fully vectorised wrt `value`) **\[fixed here\]**

-   not all attributes are taken form the longest of the inputs **\[fixed here\]**

-   partial recycling with no warning **\[fixed here\]**

-   if the replacement string of different length than the chunk being substituted, then **\[fixed here\]**

-   negative indexes are silently treated as 1 **\[changed here -- negative indexes count from the end of the string\]**

-   replacement of different length than the extracted substring never changes the length of the string **\[changed here -- output length is input length minus length of extracted plus length of replacement\]**

-   [`gregexpr`](gregexpr.md) (amongst others) return start positions and lengths of matches, but base `substr` only uses start and end **\[fixed by introducing `substrl`\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`strtrim`](strtrim.md), [`nchar`](nchar.md), [`startsWith`](startswith.md), [`endsWith`](startswith.md), [`gregexpr`](gregexpr.md)

See also [`stri_sub_all`](https://stringi.gagolewski.com/rapi/stri_sub_all.html) for replacing multiple substrings within individual strings.

## Examples




```r
x <- "spam, spam, bacon, and spam"
base::substr(x, c(1, 13), c(4, 17))
## [1] "spam"
base::substring(x, c(1, 13), c(4, 17))
## [1] "spam"  "bacon"
substr(x, c(1, 13), c(4, 17))
## [1] "spam"  "bacon"
substrl(x, c(1, 13), c(4, 5))
## [1] "spam"  "bacon"
# replacement function used as an ordinary one - return a copy of x:
base::`substr<-`(x, 1, 4, value="jam")
## [1] "jamm, spam, bacon, and spam"
`substr<-`(x, 1, 4, value="jam")
## [1] "jam, spam, bacon, and spam"
base::`substr<-`(x, 1, 4, value="porridge")
## [1] "porr, spam, bacon, and spam"
`substr<-`(x, 1, 4, value="porridge")
## [1] "porridge, spam, bacon, and spam"
# replacement function modifying x in-place:
substr(x, 1, 4) <- "eggs"
substr(x, 1, 0) <- "porridge, "        # prepend (start<stop)
substr(x, nchar(x)+1) <- " every day"  # append (start<stop)
print(x)
## [1] "porridge, eggs, spam, bacon, and spam every day"
```
