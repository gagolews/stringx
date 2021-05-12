# chartr: Transliteration and Other Text Transforms

## Description

Translate characters, including case mapping and folding, script to script conversion, and Unicode normalisation.

## Usage

```r
strtrans(x, transform)

chartr(old, new, x)

tolower(x)

toupper(x)

casefold(x, upper = NA)
```

## Arguments

|             |                                                                                                                                          |
|-------------|------------------------------------------------------------------------------------------------------------------------------------------|
| `x`         | character vector (or an object coercible to)                                                                                             |
| `transform` | a single string with ICU general transform specifier, see [`stri_trans_list`](https://stringi.gagolewski.com/rapi/stri_trans_list.html). |
| `old`       | a single string                                                                                                                          |
| `new`       | a single string, preferably of the same length as `old`                                                                                  |
| `upper`     | single logical value; switches between case folding (the default, `NA`), lower-, and upper-case.                                         |

## Details

Unlike their base R counterparts, the new `tolower` and `toupper` are locale-sensitive; see `stri_trans_tolower`.

The base `casefold` simply dispatches to `tolower` or `toupper` \'for compatibility with S-PLUS\' (that was only crucial long time ago). The version implemented here, by default, performs the true case folding, whose purpose is to make two pieces of text that differ only in case identical, see `stri_trans_casefold`.

The new `chartr` is a wrapper for [`stri_trans_char`](https://stringi.gagolewski.com/rapi/stri_trans_char.html). Contrary to the base [`chartr`](https://stat.ethz.ch/R-manual/R-patched/library/base/html/chartr.html), it always generates a warning when `old` and `new` are of different lengths.

A new function `strtrans` applies ICU general transforms, see [`stri_trans_general`](https://stringi.gagolewski.com/rapi/stri_trans_general.html).

## Value

A character vector (in UTF-8).

These functions preserve most attributes of `x`. Their base R counterparts drop all the attributes if not fed with character vectors.

## Examples




```r
strtrans(strcat(letters_bf), "Any-NFKD; Any-Upper")
## [1] "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
strtrans(strcat(letters_bb[1:6]), "Any-Hex/C")
## [1] "\\U0001D552\\U0001D553\\U0001D554\\U0001D555\\U0001D556\\U0001D557"
strtrans(strcat(letters_greek), "Greek-Latin")
## [1] "abgdezēthiklmn'xoprstyphchpsō"
toupper(letters_greek)
##  [1] "Α" "Β" "Γ" "Δ" "Ε" "Ζ" "Η" "Θ" "Ι" "Κ" "Λ" "Μ" "Ν" "Ξ" "Ο" "Π" "Ρ" "Σ" "Τ"
## [20] "Υ" "Φ" "Χ" "Ψ" "Ω"
tolower(LETTERS_GREEK)
##  [1] "α" "β" "γ" "δ" "ε" "ζ" "η" "θ" "ι" "κ" "λ" "μ" "ν" "ξ" "ο" "π" "ρ" "σ" "τ"
## [20] "υ" "φ" "χ" "ψ" "ω"
base::toupper("gro\u00DF")
## [1] "GROß"
stringx::toupper("gro\u00DF")
## [1] "GROSS"
casefold("gro\u00DF")
## [1] "groß"
x <- as.matrix(c(a="\u00DFpam ba\U0001D554on spam", b=NA))
base::chartr("\u00DF\U0001D554aba", "SCXBA", x)
##   [,1]             
## a "SpAm BACon spAm"
## b NA
stringx::chartr("\u00DF\U0001D554aba", "SCXBA", x)
##   [,1]             
## a "SpAm BACon spAm"
## b NA
```
