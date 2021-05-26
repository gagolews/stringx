source("common.R")

# equivalent behaviour:

for (args in list(
    list(structure(c(x=1, y=10), F="*"), structure(c(a=1, b=2), G="#", F="@")),  # TODO: should be different
    list(1:2, LETTERS),
    list(1:2, character(0), LETTERS, recycle0=TRUE),
    list(letters, LETTERS),
    list(1:2, LETTERS, letters)
)) {
    expect_equal(do.call(stringx::paste, args), do.call(base::paste, args))
    expect_equal(do.call(stringx::paste0, args), do.call(base::paste0, args))
}



for (args in list(
    list(letters, LETTERS, sep="---"),
    list(1:2, LETTERS, letters, sep="!", collase=";")
)) {
    expect_equal(do.call(stringx::paste, args), do.call(base::paste, args))
}


# different behaviour:

expect_silent(base::paste0(1:2, 1:3))
expect_warning(stringx::paste0(1:2, 1:3))

expect_equal(base::paste0(c(1, NA, 3), "a", collapse=","), "1a,NAa,3a")
expect_equal(stringx::paste0(c(1, NA, 3), "a", collapse=","), NA_character_)

expect_equal(base::paste(1, character(0), "a", sep=",", recycle0=FALSE), "1,,a")
expect_equal(stringx::paste(1, character(0), "a", sep=",", recycle0=FALSE), "1,a")

expect_equal(base::paste0(1, 2, sep=","), "12,")
expect_equal(stringx::paste0(1, 2, sep=","), "1,2")

# TODO: paste should preserve attributes?
x <- structure(c(u="x"), class="foo", attrib1="val1")
y <- structure(c(a="1", b="2"), class="bar", attrib2="val2")
expect_null(attributes(base::paste(x, y)))
expect_null(attributes(stringx::paste(x, y)))  # TODO ??


expect_equal(stringx::strcat(structure(c(x=1, y=NA, z=100), F="*"), collapse=","), NA_character_)
expect_equal(stringx::strcat(structure(c(x=1, y=NA, z=100), F="*"), collapse=",", na.rm=TRUE), "1,100")



# can't overload `+` in base R:
`+.character` <- stringi::`%s+%`
expect_error("a" + 3)
rm(`+.character`)



expect_equal(1:10 %x+% character(0), character(0))


x <- structure(c(x=1, y=NA, z=100, w=1000), F="*", class="foo")
y1 <- structure(c(a=1, b=2), G="#", F="@")
y2 <- structure(c(a=1, b=2, c=3, d=4), G="#", F="@")
y3 <- matrix(1:4, nrow=2, dimnames=list(c("ROW1", "ROW2"), c("COL1", "COL2")))


expect_equal(sorted_attributes(x %x+% y1), sorted_attributes(x + y1))
expect_equal(sorted_attributes(x %x+% y2), sorted_attributes(x + y2))
expect_equal(sorted_attributes(x %x+% y3), sorted_attributes(x + y3))
expect_equal(sorted_attributes(y1 %x+% x), sorted_attributes(y1 + x))
expect_equal(sorted_attributes(y2 %x+% x), sorted_attributes(y2 + x))
expect_equal(sorted_attributes(y3 %x+% x), sorted_attributes(y3 + x))
expect_equal(sorted_attributes(x %x+% as.vector(y1)), sorted_attributes(x + as.vector(y1)))
expect_equal(sorted_attributes(x %x+% as.vector(y2)), sorted_attributes(x + as.vector(y2)))
expect_equal(sorted_attributes(x %x+% as.vector(y3)), sorted_attributes(x + as.vector(y3)))
expect_equal(sorted_attributes(as.vector(y1) %x+% x), sorted_attributes(as.vector(y1) + x))
expect_equal(sorted_attributes(as.vector(y2) %x+% x), sorted_attributes(as.vector(y2) + x))
expect_equal(sorted_attributes(as.vector(y3) %x+% x), sorted_attributes(as.vector(y3) + x))
expect_equal(sorted_attributes(x %x+% character(0)), NULL)
