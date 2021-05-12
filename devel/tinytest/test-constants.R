source("common.R")


expect_equivalent(digits_dec, as.character(0:9))
expect_equivalent(digits_hex, c(as.character(0:9), LETTERS[1:6]))

expect_equivalent(to_ascii(letters_bb), letters)
expect_equivalent(to_ascii(letters_bf), letters)
expect_equivalent(to_ascii(letters_cal), letters)
expect_equivalent(to_ascii(letters_frak), letters)

expect_equivalent(to_ascii(LETTERS_BB), LETTERS)
expect_equivalent(to_ascii(LETTERS_BF), LETTERS)
expect_equivalent(to_ascii(LETTERS_CAL), LETTERS)
expect_equivalent(to_ascii(LETTERS_FRAK), LETTERS)

expect_equivalent(stringi::stri_trans_toupper(letters_greek), LETTERS_GREEK)
expect_equivalent(stringi::stri_trans_tolower(LETTERS_GREEK), letters_greek)


# does not give expected results:
# stringi::stri_trans_toupper(letters_bf)
# stringi::stri_trans_tolower(LETTERS_BF)
# expect_equivalent(stringi::stri_trans_toupper(letters_bb), LETTERS_BB)
