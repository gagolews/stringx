# strsplit: Split Strings into Tokens

## Description

Splits each string into chunks delimited by occurrences of a given pattern.

## Usage

```r
strsplit(
  x,
  split,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  ignore.case = FALSE,
  ...
)
```

## Arguments

|                  |                                                                                                                                                                                                                                                                                                                                                                                                                      |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`              | character vector whose elements are to be examined                                                                                                                                                                                                                                                                                                                                                                   |
| `split`          | character vector of nonempty search patterns, [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)                                                                                                                                                                                                                                                                                    |
| `fixed`          | single logical value; `FALSE` for matching with regular expressions (see [about\_search\_regex](https://stringi.gagolewski.com/rapi/about_search_regex.html)); `TRUE` for fixed pattern matching ([about\_search\_fixed](https://stringi.gagolewski.com/rapi/about_search_fixed.html)); `NA` for the Unicode collation algorithm ([about\_search\_coll](https://stringi.gagolewski.com/rapi/about_search_coll.html)) |
| `perl, useBytes` | not used (with a warning if attempting to do so) \[DEPRECATED\]                                                                                                                                                                                                                                                                                                                                                      |
| `ignore.case`    | single logical value; indicates whether matching should be case-insensitive                                                                                                                                                                                                                                                                                                                                          |
| `...`            | further arguments to [`stri_split`](https://stringi.gagolewski.com/rapi/stri_split.html), e.g., `omit_empty`, `locale`, `dotall`                                                                                                                                                                                                                                                                                     |

## Details

This function is fully vectorised with respect to both arguments.

For splitting text into \'characters\' (grapheme clusters), words, or sentences, use [`stri_split_boundaries`](https://stringi.gagolewski.com/rapi/stri_split_boundaries.html) instead.

## Value

Returns a list of character vectors representing the identified tokens.

## Differences from Base R

Replacements for base [`strsplit`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/strsplit.html) implemented with [`stri_split`](https://stringi.gagolewski.com/rapi/stri_split.html).

-   base R implementation is not portable as it is based on the system PCRE or TRE library (e.g., some Unicode classes may not be available or matching thereof can depend on the current `LC_CTYPE` category **\[fixed here\]**

-   not suitable for natural language processing **\[fixed here -- use `fixed=NA`\]**

-   two different regular expression libraries are used (and historically, ERE was used in place of TRE) **\[here, <span class="pkg">ICU</span> Java-like regular expression engine is only available, hence the `perl` argument has no meaning\]**

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) and some other pattern matching functions have a different argument order, where the needle precedes the haystack and `ignore.case` is listed before `perl` and then `fixed` etc. **\[not fixed here\]**

-   [`grepl`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/grepl.html) also features the `ignore.case` argument **\[added here\]**

-   if `split` is a zero-length vector, it is treated as `""`, which extracts individual code points (which is not the best idea for natural language processing tasks) **\[empty search patterns are not supported here, zero-length vectors are propagated correctly\]**

-   last empty token is removed from the output, but first is not **\[fixed here -- see also the `omit_empty` argument\]**

-   missing values in `split` are not propagated correctly **\[fixed here\]**

-   partial recycling without the usual warning, not fully vectorised w.r.t. the `split` argument **\[fixed here\]**

-   only the `names` attribute of `x` is preserved **\[fixed here\]**

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

Related function(s): [`paste`](paste.md), [`nchar`](nchar.md), [`grep`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html), [`substr`](substr.md)

## Examples




```r
stringx::strsplit(c(x="a, b", y="c,d,  e"), ",\\s*")
## $x
## [1] "a" "b"
## 
## $y
## [1] "c" "d" "e"
x <- strcat(c(
    "abc", "123", ",!.", "\U0001F4A9",
    "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
    "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
    "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
))
# be careful when splitting into individual code points:
base::strsplit(x, "")  # stringx does not support this
## [[1]]
##  [1] "a"  "b"  "c"  "1"  "2"  "3"  ","  "!"  "."  "💩" "🙍" "🏼" "‍"   "♂"  "️"  
## [16] "⛹"  "🏿" "‍"   "♀"  "️"   "🏴" "󠁧"   "󠁢"   "󠁳"   "󠁣"   "󠁴"   "󠁿"
stringx::strsplit(x, "(?s)(?=.)", omit_empty=TRUE)  # look-ahead for any char with dot-all
## [[1]]
##  [1] "a"  "b"  "c"  "1"  "2"  "3"  ","  "!"  "."  "💩" "🙍" "🏼" "‍"   "♂"  "️"  
## [16] "⛹"  "🏿" "‍"   "♀"  "️"   "🏴" "󠁧"   "󠁢"   "󠁳"   "󠁣"   "󠁴"   "󠁿"
stringi::stri_split_boundaries(x, type="character")  # grapheme clusters
## [[1]]
##  [1] "a"     "b"     "c"     "1"     "2"     "3"     ","     "!"     "."    
## [10] "💩"    "🙍🏼‍♂️" "⛹🏿‍♀️"  "🏴󠁧󠁢󠁳󠁣󠁴󠁿"
```
