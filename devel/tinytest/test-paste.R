library("tinytest")
library("stringx")

# equivalent behaviour:

for (args in list(
    list(structure(c(x=1, y=10), F="*"), structure(c(a=1, b=2), G="#", F="@")),  # TODO: should be different
    list(1:2, LETTERS),
    list(1:2, character(0), LETTERS, recycle0=TRUE),
    list(letters, LETTERS),
    list(1:2, LETTERS, letters)
)) {
    expect_equivalent(do.call(stringx::paste, args), do.call(base::paste, args))
    expect_equivalent(do.call(stringx::paste0, args), do.call(base::paste0, args))
}



for (args in list(
    list(letters, LETTERS, sep="---"),
    list(1:2, LETTERS, letters, sep="!", collase=";")
)) {
    expect_equivalent(do.call(stringx::paste, args), do.call(base::paste, args))
}


# different behaviour:

expect_silent(base::paste0(1:2, 1:3))
expect_warning(stringx::paste0(1:2, 1:3))

expect_equivalent(base::paste0(c(1, NA, 3), "a", collapse=","), "1a,NAa,3a")
expect_equivalent(stringx::paste0(c(1, NA, 3), "a", collapse=","), NA_character_)

expect_equivalent(base::paste(1, character(0), "a", sep=",", recycle0=FALSE), "1,,a")
expect_equivalent(stringx::paste(1, character(0), "a", sep=",", recycle0=FALSE), "1,a")

expect_equivalent(base::paste0(1, 2, sep=","), "12,")
expect_equivalent(stringx::paste0(1, 2, sep=","), "1,2")

# TODO: paste should preserve attributes



expect_equivalent(stringx::strcat(structure(c(x=1, y=NA, z=100), F="*"), collapse=","), NA_character_)
expect_equivalent(stringx::strcat(structure(c(x=1, y=NA, z=100), F="*"), collapse=",", na.rm=TRUE), "1,100")







expect_equivalent(1:10 %x+% character(0), character(0))


x <- structure(c(x=1, y=NA, z=100, w=1000), F="*", class="foo")
y1 <- structure(c(a=1, b=2), G="#", F="@")
y2 <- structure(c(a=1, b=2, c=3, d=4), G="#", F="@")
y3 <- matrix(1:4, nrow=2, dimnames=list(c("ROW1", "ROW2"), c("COL1", "COL2")))

sorted_attributes <- function(x) {
    a <- attributes(suppressWarnings(x))
    if (is.null(a)) NULL
    else a[order(names(a))]
}

expect_equivalent(sorted_attributes(x %x+% y1), sorted_attributes(x + y1))
expect_equivalent(sorted_attributes(x %x+% y2), sorted_attributes(x + y2))
expect_equivalent(sorted_attributes(x %x+% y3), sorted_attributes(x + y3))
expect_equivalent(sorted_attributes(y1 %x+% x), sorted_attributes(y1 + x))
expect_equivalent(sorted_attributes(y2 %x+% x), sorted_attributes(y2 + x))
expect_equivalent(sorted_attributes(y3 %x+% x), sorted_attributes(y3 + x))
expect_equivalent(sorted_attributes(x %x+% as.vector(y1)), sorted_attributes(x + as.vector(y1)))
expect_equivalent(sorted_attributes(x %x+% as.vector(y2)), sorted_attributes(x + as.vector(y2)))
expect_equivalent(sorted_attributes(x %x+% as.vector(y3)), sorted_attributes(x + as.vector(y3)))
expect_equivalent(sorted_attributes(as.vector(y1) %x+% x), sorted_attributes(as.vector(y1) + x))
expect_equivalent(sorted_attributes(as.vector(y2) %x+% x), sorted_attributes(as.vector(y2) + x))
expect_equivalent(sorted_attributes(as.vector(y3) %x+% x), sorted_attributes(as.vector(y3) + x))
expect_equivalent(sorted_attributes(x %x+% character(0)), NULL)
