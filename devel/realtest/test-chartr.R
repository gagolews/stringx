source("common.R")


expect_equal(stringx::toupper("gro\u00DF"), "GROSS")  # right
expect_equal(base::toupper("gro\u00DF"),  "GRO\u00DF")  # wrong
expect_equal(stringx::casefold("gro\u00DF"), "gross")

expect_equal(stringx::toupper(letters_greek), LETTERS_GREEK)
expect_equal(stringx::tolower(LETTERS_GREEK), letters_greek)

x <- structure(c(a="gross", b=NA, c="abcdefghi", d="ABCDEFGHI"), F="x")
expect_equal(stringx::chartr("abc", "ABC", x), base::chartr("abc", "ABC", x))
expect_equal(stringx::tolower(x), base::tolower(x))
expect_equal(stringx::toupper(x), base::toupper(x))
expect_equal(stringx::casefold(x), base::casefold(x))

expect_warning(stringx::chartr("AB", "XYZ", x))
expect_warning(stringx::chartr("ABC", "XY", x))
expect_silent(base::chartr("AB", "XYZ", x))  # hmm....
expect_error(base::chartr("ABC", "XY", x)) # hmm....


x <- matrix(as.character(1:12), nrow=2, dimnames=list(c("a", "b"), NULL))
expect_equal(stringx::chartr("abc", "ABC", x), base::chartr("abc", "ABC", x))
expect_equal(stringx::tolower(x), base::tolower(x))
expect_equal(stringx::toupper(x), base::toupper(x))
expect_equal(stringx::casefold(x), base::casefold(x))

