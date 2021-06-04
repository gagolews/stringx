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

E(toupper(letters_greek), LETTERS_GREEK,   bad=letters_greek)
E(tolower(LETTERS_GREEK), letters_greek,   bad=LETTERS_GREEK)

E(toupper(letters_bf),   LETTERS_BF,   bad=letters_bf,   .comment="unsupported by ICU")
E(tolower(LETTERS_BF),   letters_bf,   bad=LETTERS_BF,   .comment="unsupported by ICU")
E(toupper(letters_bb),   LETTERS_BB,   bad=letters_bb,   .comment="unsupported by ICU")
E(tolower(LETTERS_BB),   letters_bb,   bad=LETTERS_BB,   .comment="unsupported by ICU")
E(toupper(letters_cal),  LETTERS_CAL,  bad=letters_cal,  .comment="unsupported by ICU")
E(tolower(LETTERS_CAL),  letters_cal,  bad=LETTERS_CAL,  .comment="unsupported by ICU")
E(toupper(letters_frak), LETTERS_FRAK, bad=letters_frak, .comment="unsupported by ICU")
E(tolower(LETTERS_FRAK), letters_frak, bad=LETTERS_FRAK, .comment="unsupported by ICU")
