E(nzchar(c()), logical(0))
E(nchar(c()), integer(0))
E(nchar(c(), "width"), integer(0))
E(nchar(c(), "bytes"), integer(0))


x <- c(
    "a",
    "",
    NA_character_,
    "\u0105",
    "abcdefgh",
    "\u03c0\u00b2\U0001f602\U0001f603",
    "\U0001F3F4\U000E0067\U000E0062\U000E0065\U000E006E\U000E0067\U000E007F",
    "\U0001F4AA\U0001F3FF"
)

E(
    nzchar(x),  # default keepNA argument
    c(TRUE, FALSE, NA, TRUE, TRUE, TRUE, TRUE, TRUE),
    bad=c(TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
)

E(
    nzchar(x, keepNA=TRUE),
    c(TRUE, FALSE, NA, TRUE, TRUE, TRUE, TRUE, TRUE)
)

E(
    nchar(x, keepNA=FALSE),
    c(1L, 0L, 2L, 1L, 8L, 4L, 7L, 2L)
)

E(
    nchar(x, keepNA=TRUE),
    c(1L, 0L, NA, 1L, 8L, 4L, 7L, 2L)
)

E(
    nchar(x, "width", keepNA=FALSE),
    c(1L, 0L, 2L, 1L, 8L, 6L, 2L, 2L),
    bad=c(1L, 0L, 2L, 1L, 8L, 6L, 2L, 4L),
    bad=c(1L, 0L, 2L, 1L, 8L, 6L, 2L, 3L)
)

E(
    nchar(x, "width", keepNA=TRUE),
    c(1L, 0L, NA, 1L, 8L, 6L, 2L, 2L),
    bad=c(1L, 0L, NA, 1L, 8L, 6L, 2L, 4L),
    bad=c(1L, 0L, NA, 1L, 8L, 6L, 2L, 3L)
)

E(
    nchar(x, "bytes", keepNA=FALSE),
    c(1L, 0L, 2L, 2L, 8L, 12L, 28L, 8L)
)

E(
    nchar(x, "bytes", keepNA=TRUE),
    c(1L, 0L, NA, 2L, 8L, 12L, 28L, 8L)
)


x <- structure(c(a="1", b="22"), attrib2="val2")
E(
    nchar(x),
    better=structure(c(a=1L, b=2L), attrib2="val2"),
    structure(c(a=1L, b=2L)),
    c(1L, 2L)
)

x <- structure(cbind(x=c("a", "bb"), y=c("ccc", "dddd")), attrib2="val2")
E(
    nchar(x),
    best=structure(cbind(x=c(1L, 2L), y=c(3L, 4L)), attrib2="val2"),
    better=cbind(x=c(1L, 2L), y=c(3L, 4L)),
    cbind(c(1L, 2L), c(3L, 4L)),
    bad=1:4
)

x <- structure(cbind(x=c(1, 22), y=c(333, 4444)), attrib1="val1")
E(
    nchar(x),
    best=structure(cbind(x=c(1L, 2L), y=c(3L, 4L)), attrib1="val1"),
    better=cbind(x=c(1L, 2L), y=c(3L, 4L)),
    cbind(c(1L, 2L), c(3L, 4L)),
    1:4  # as.character drops attribs...
)
