source("common.R")



# equivalent behaviour:

for (args in list(
    list("a", 5),
    list("a", 1:5),
    list(LETTERS, 1),
    list(LETTERS, seq_along(LETTERS)),
    list(LETTERS, c(1, 2)),
    list(character(0), 1:10),
    list(1:10, integer(0)),
    list(c(1, NA, 3, 5), c(NA, 3))
)) {
    expect_equal(do.call(stringx::`%x*%`, args), do.call(base::strrep, args))
    expect_equal(do.call(stringx::strrep, args), do.call(base::strrep, args))
}


# can't overload `*` in base R:
`*.character` <- function(e1, e2) stringi::stri_dup(e1, e2)
expect_error("a" * 3)
# ##Error in "a" * 3 : non-numeric argument to binary operator
rm(`*.character`)



x <- structure(c(A="a", B=NA, C="b"), attrib1="value1")
expect_equal(as.character(x %x*% 3), as.character(base::strrep(x, 3)))
expect_equal(as.character(stringx::strrep(x, 3)), as.character(base::strrep(x, 3)))
expect_equal(sorted_attributes(x %x*% 3), sorted_attributes(x))
expect_equal(sorted_attributes(stringx::strrep(x, 3)), sorted_attributes(x))

# only names.... and only if input is of type character
expect_equal(sorted_attributes(base::strrep(x, 3)), list(names=names(x)))

x <- matrix(letters[1:6], nrow=2, dimnames=list(c("A", "B"), NULL))
expect_equal(stringx::strrep(x, 1:2), x %x*% 1:2)

x <- matrix(1:6, nrow=2, dimnames=list(c("A", "B"), NULL))
expect_equal(sorted_attributes(x %x*% 1:2), sorted_attributes(x * 1:2))

expect_warning(stringx::strrep(1:3, 1:2))
expect_silent(base::strrep(1:3, 1:2))  # inconsistent
