# chartr: Transliteration and Other Text Transforms

## Description

Translate characters, including case mapping and folding, script to script conversion, and Unicode normalisation.

## Usage

```r
strtrans(x, transform)

chartr(old, new, x)

tolower(x, locale = NULL)

toupper(x, locale = NULL)

casefold(x, upper = NA)
```

## Arguments

|             |                                                                                                                                                                                                                                                            |
|-------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `x`         | character vector (or an object coercible to)                                                                                                                                                                                                               |
| `transform` | single string with ICU general transform specifier, see [`stri_trans_list`](https://stringi.gagolewski.com/rapi/stri_trans_list.html)                                                                                                                      |
| `old`       | single string                                                                                                                                                                                                                                              |
| `new`       | single string, preferably of the same length as `old`                                                                                                                                                                                                      |
| `locale`    | `NULL` or `''` for the default locale (see [`stri_locale_get`](https://stringi.gagolewski.com/rapi/stri_locale_set.html)) or a single string with a locale identifier, see [`stri_locale_list`](https://stringi.gagolewski.com/rapi/stri_locale_list.html) |
| `upper`     | single logical value; switches between case folding (the default, `NA`), lower-, and upper-case                                                                                                                                                            |

## Details

Unlike their base R counterparts, the new `tolower` and `toupper` are locale-sensitive; see [`stri_trans_tolower`](https://stringi.gagolewski.com/rapi/stri_trans_casemap.html).

The base [`casefold`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/casefold.html) simply dispatches to `tolower` or `toupper` \'for compatibility with S-PLUS\' (which was only crucial long time ago). The version implemented here, by default, performs the true case folding, whose purpose is to make two pieces of text that differ only in case identical, see [`stri_trans_casefold`](https://stringi.gagolewski.com/rapi/stri_trans_casemap.html).

The new `chartr` is a wrapper for [`stri_trans_char`](https://stringi.gagolewski.com/rapi/stri_trans_char.html). Contrary to the base [`chartr`](https://stat.ethz.ch/R-manual/R-devel/library/base/help/chartr.html), it always generates a warning when `old` and `new` are of different lengths.

A new function `strtrans` applies ICU general transforms, see [`stri_trans_general`](https://stringi.gagolewski.com/rapi/stri_trans_general.html).

## Value

These functions return a character vector (in UTF-8). They preserve most attributes of `x`. Note that their base R counterparts drop all the attributes if not fed with character vectors.

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

## Examples




```r
strtrans(strcat(letters_bf), "Any-NFKD; Any-Upper")
```

```
## [1] "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
```

```r
strtrans(strcat(letters_bb[1:6]), "Any-Hex/C")
```

```
## [1] "\\U0001D552\\U0001D553\\U0001D554\\U0001D555\\U0001D556\\U0001D557"
```

```r
strtrans(strcat(letters_greek), "Greek-Latin")
```

```
## [1] "abgdezēthiklmn'xoprstyphchpsō"
```

```r
toupper(letters_greek)
```

```
##  [1] "Α" "Β" "Γ" "Δ" "Ε" "Ζ" "Η" "Θ" "Ι" "Κ" "Λ" "Μ" "Ν" "Ξ" "Ο" "Π" "Ρ" "Σ" "Τ"
## [20] "Υ" "Φ" "Χ" "Ψ" "Ω"
```

```r
tolower(LETTERS_GREEK)
```

```
##  [1] "α" "β" "γ" "δ" "ε" "ζ" "η" "θ" "ι" "κ" "λ" "μ" "ν" "ξ" "ο" "π" "ρ" "σ" "τ"
## [20] "υ" "φ" "χ" "ψ" "ω"
```

```r
base::toupper("gro\u00DF")
```

```
## [1] "GROß"
```

```r
stringx::toupper("gro\u00DF")
```

```
## [1] "GROSS"
```

```r
casefold("gro\u00DF")
```

```
## [1] "groß"
```

```r
x <- as.matrix(c(a="\u00DFpam ba\U0001D554on spam", b=NA))
base::chartr("\u00DF\U0001D554aba", "SCXBA", x)
```

```
##   [,1]             
## a "SpAm BACon spAm"
## b NA
```

```r
stringx::chartr("\u00DF\U0001D554aba", "SCXBA", x)
```

```
##   [,1]             
## a "SpAm BACon spAm"
## b NA
```

```r
stringx::toupper('i', locale='en_US')
```

```
## [1] "I"
```

```r
stringx::toupper('i', locale='tr_TR')
```

```
## [1] "İ"
```
