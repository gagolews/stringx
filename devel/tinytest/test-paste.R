library("tinytest")
library("stringb")

# equivalent behaviour:

for (args in list(
    list(structure(c(x=1, y=10), F="*"), structure(c(a=1, b=2), G="#", F="@")),  # TODO: should be different
    list(1:2, LETTERS),
    list(1:2, character(0), LETTERS, recycle0=TRUE),
    list(letters, LETTERS),
    list(1:2, LETTERS, letters)
)) {
    expect_equivalent(do.call(stringb::paste, args), do.call(base::paste, args))
    expect_equivalent(do.call(stringb::paste0, args), do.call(base::paste0, args))
}



for (args in list(
    list(letters, LETTERS, sep="---"),
    list(1:2, LETTERS, letters, sep="!", collase=";")
)) {
    expect_equivalent(do.call(stringb::paste, args), do.call(base::paste, args))
}


# different behaviour:

expect_silent(base::paste0(1:2, 1:3))
expect_warning(stringb::paste0(1:2, 1:3))

expect_equivalent(base::paste0(c(1, NA, 3), "a", collapse=","), "1a,NAa,3a")
expect_equivalent(stringb::paste0(c(1, NA, 3), "a", collapse=","), NA_character_)

expect_equivalent(base::paste(1, character(0), "a", sep=",", recycle0=FALSE), "1,,a")
expect_equivalent(stringb::paste(1, character(0), "a", sep=",", recycle0=FALSE), "1,a")

expect_equivalent(base::paste0(1, 2, sep=","), "12,")
expect_equivalent(stringb::paste0(1, 2, sep=","), "1,2")

# TODO: paste should preserve attributes
