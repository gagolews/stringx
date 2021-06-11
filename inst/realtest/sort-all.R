E(sort(character(0)), character(0))
E(sort(c(NA_character_, NA_character_, NA_character_)), character(0))

# drop all atribs except for names, because length of out <= length of in and other sort methods do so too
x <- structure(c(a="1", b=NA_character_, c="2"), attrib1="value1")
E(sort(x), c(a="1", c="2"))
E(sort(x, na.last=FALSE), c(b=NA_character_, a="1", c="2"))
E(sort(x, na.last=TRUE), c(a="1", c="2", b=NA_character_))

E(xtfrm(character(0)), integer(0))
E(
    xtfrm(structure(c(a=NA_character_, b=NA_character_, c=NA_character_), attrib1="value1")),
    structure(c(a=NA_integer_, b=NA_integer_, c=NA_integer_), attrib1="value1"),
    bad=rep(NA_integer_, 3)
)
E(
    structure(xtfrm(c(a="1", b=NA_character_, c="2")), attrib1="value1"),
    structure(c(a=1L, b=NA_integer_, c=2L), attrib1="value1"),
    bad=c(1L, NA_integer_, 2L),
    bad=structure(c(1L, NA_integer_, 2L), attrib1="value1")
)
