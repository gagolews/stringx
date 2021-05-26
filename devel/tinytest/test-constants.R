source("common.R")

expect_equal(digits_dec, as.character(0:9))
expect_equal(digits_hex, c(as.character(0:9), LETTERS[1:6]))

expect_equal(toascii(letters_bb), letters)
expect_equal(toascii(letters_bf), letters)
expect_equal(toascii(letters_cal), letters)
expect_equal(toascii(letters_frak), letters)

expect_equal(toascii(LETTERS_BB), LETTERS)
expect_equal(toascii(LETTERS_BF), LETTERS)
expect_equal(toascii(LETTERS_CAL), LETTERS)
expect_equal(toascii(LETTERS_FRAK), LETTERS)

expect_equal(stringx::toupper(letters_greek), LETTERS_GREEK)
expect_equal(stringx::tolower(LETTERS_GREEK), letters_greek)

# does not give expected results:  (via ICU)
# stringi::stri_trans_toupper(letters_bf)
# stringi::stri_trans_tolower(LETTERS_BF)
# expect_equal(stringi::stri_trans_toupper(letters_bb), LETTERS_BB)
