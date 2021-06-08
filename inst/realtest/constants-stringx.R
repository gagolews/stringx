toascii <- function(x, substitute="\u001a")
{
    stringi::stri_replace_all_charclass(
        stringi::stri_trans_general(x, "Any-NFKD; Any-Latin; Latin-ASCII"),
        "[^\\u0001-\\u007f]", substitute
    )
}


E(digits_dec, as.character(0:9))
E(digits_hex, c(as.character(0:9), LETTERS[1:6]))

E(toascii(letters_bb),   letters)
E(toascii(letters_bf),   letters)
E(toascii(letters_cal),  letters)
E(toascii(letters_frak), letters)

E(toascii(LETTERS_BB),   LETTERS)
E(toascii(LETTERS_BF),   LETTERS)
E(toascii(LETTERS_CAL),  LETTERS)
E(toascii(LETTERS_FRAK), LETTERS)
