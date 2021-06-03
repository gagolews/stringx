# constants: Character Constants

## Description

Letters and digits sets complementing the built-in `LETTERS` and `letters`, see [Constants](https://stat.ethz.ch/R-manual/R-devel/library/base/help/Constants.html).

Beware: calling, e.g., [`tolower`](chartr.md) on `LETTERS_FRAK` does not yield `letters_frak`.

## Usage

```r
digits_dec

digits_hex

letters_greek

LETTERS_GREEK

letters_bb

LETTERS_BB

letters_cal

LETTERS_CAL

letters_frak

LETTERS_FRAK

letters_bf

LETTERS_BF
```

## Format

Decimal digits

Hexadecimal digits

Greek letters (lower case)

Greek letters (upper case)

Blackboard bold English letters (lower case)

Blackboard bold English letters (upper case)

Calligraphy (script) English letters (lower case)

Calligraphy (script) English letters (upper case)

Fraktur English letters (lower case)

Fraktur English letters (upper case)

Bold English letters (lower case)

Bold English letters (upper case)

## Author(s)

[Marek Gagolewski](https://www.gagolewski.com/)

## See Also

The official online manual of <span class="pkg">stringx</span> at <https://stringx.gagolewski.com/>

## Examples




```r
letters_bb
##  [1] "𝕒" "𝕓" "𝕔" "𝕕" "𝕖" "𝕗" "𝕘" "𝕙" "𝕚" "𝕛" "𝕜" "𝕝" "𝕞" "𝕟" "𝕠" "𝕡" "𝕢" "𝕣" "𝕤"
## [20] "𝕥" "𝕦" "𝕧" "𝕨" "𝕩" "𝕪" "𝕫"
letters_bf
##  [1] "𝐚" "𝐛" "𝐜" "𝐝" "𝐞" "𝐟" "𝐠" "𝐡" "𝐢" "𝐣" "𝐤" "𝐥" "𝐦" "𝐧" "𝐨" "𝐩" "𝐪" "𝐫" "𝐬"
## [20] "𝐭" "𝐮" "𝐯" "𝐰" "𝐱" "𝐲" "𝐳"
letters_cal
##  [1] "𝓪" "𝓫" "𝓬" "𝓭" "𝓮" "𝓯" "𝓰" "𝓱" "𝓲" "𝓳" "𝓴" "𝓵" "𝓶" "𝓷" "𝓸" "𝓹" "𝓺" "𝓻" "𝓼"
## [20] "𝓽" "𝓾" "𝓿" "𝔀" "𝔁" "𝔂" "𝔃"
letters_frak
##  [1] "𝖆" "𝖇" "𝖈" "𝖉" "𝖊" "𝖋" "𝖌" "𝖍" "𝖎" "𝖏" "𝖐" "𝖑" "𝖒" "𝖓" "𝖔" "𝖕" "𝖖" "𝖗" "𝖘"
## [20] "𝖙" "𝖚" "𝖛" "𝖜" "𝖝" "𝖞" "𝖟"
letters_greek
##  [1] "α" "β" "γ" "δ" "ε" "ζ" "η" "θ" "ι" "κ" "λ" "μ" "ν" "ξ" "ο" "π" "ρ" "σ" "τ"
## [20] "υ" "φ" "χ" "ψ" "ω"
LETTERS_BB
##  [1] "𝔸" "𝔹" "ℂ" "𝔻" "𝔼" "𝔽" "𝔾" "ℍ" "𝕀" "𝕁" "𝕂" "𝕃" "𝕄" "ℕ" "𝕆" "ℙ" "ℚ" "ℝ" "𝕊"
## [20] "𝕋" "𝕌" "𝕍" "𝕎" "𝕏" "𝕐" "ℤ"
LETTERS_BF
##  [1] "𝐀" "𝐁" "𝐂" "𝐃" "𝐄" "𝐅" "𝐆" "𝐇" "𝐈" "𝐉" "𝐊" "𝐋" "𝐌" "𝐍" "𝐎" "𝐏" "𝐐" "𝐑" "𝐒"
## [20] "𝐓" "𝐔" "𝐕" "𝐖" "𝐗" "𝐘" "𝐙"
LETTERS_CAL
##  [1] "𝓐" "𝓑" "𝓒" "𝓓" "𝓔" "𝓕" "𝓖" "𝓗" "𝓘" "𝓙" "𝓚" "𝓛" "𝓜" "𝓝" "𝓞" "𝓟" "𝓠" "𝓡" "𝓢"
## [20] "𝓣" "𝓤" "𝓥" "𝓦" "𝓧" "𝓨" "𝓩"
LETTERS_FRAK
##  [1] "𝕬" "𝕭" "𝕮" "𝕯" "𝕰" "𝕱" "𝕲" "𝕳" "𝕴" "𝕵" "𝕶" "𝕷" "𝕸" "𝕹" "𝕺" "𝕻" "𝕼" "𝕽" "𝕾"
## [20] "𝕿" "𝖀" "𝖁" "𝖂" "𝖃" "𝖄" "𝖅"
LETTERS_GREEK
##  [1] "Α" "Β" "Γ" "Δ" "Ε" "Ζ" "Η" "Θ" "Ι" "Κ" "Λ" "Μ" "Ν" "Ξ" "Ο" "Π" "Ρ" "Σ" "Τ"
## [20] "Υ" "Φ" "Χ" "Ψ" "Ω"
digits_dec
##  [1] "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
digits_hex
##  [1] "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F"
```
