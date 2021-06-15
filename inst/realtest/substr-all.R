# replace "substr" with "substring" to test the "S-compatible" version in base R
# (not big of a difference though)


x <- c("spam, spam, bacon, and spam", "eggs and spam")

E(
    substr(character(0), 1, 4),
    character(0)
)

E(
    substr(x, numeric(0), 10000),
    character(0),
    bad=P(error=TRUE)
)

E(
    substr(x, 1, 4),
    c("spam", "eggs")
)

E(
    substr(x, nchar(x)-3),
    c("spam", "spam"),
    bad=P(error=TRUE)
)

E(
    substr(x, 0, 1),
    c("s", "e")
)

E(
    substr(x, 1, 0),
    c("", "")
)

E(
    substr(x, nchar(x)+1, nchar(x)+1),
    c("", "")
)

E(
    substr(x, nchar(x), nchar(x)+1),
    c("m", "m")
)

E(
    substr(x[1], c(1, 13), c(4, 17)),
    c("spam", "bacon"),
    bad="spam"
)

E(
    substr(x[c(1, 1)], c(1, 13), c(4, 17)),
    c("spam", "bacon")
)

E(
    substr(x[c(1, 1, 2)], c(1, 13), c(4, 17)),
    P(c("spam", "bacon", "eggs"), warning="longer object length is not a multiple of shorter object length"),
    bad=c("spam", "bacon", "eggs")
)

E(
    substr(NA_character_, 1, 4),
    NA_character_
)

E(
    substr(x, NA, 4),
    c(NA_character_, NA_character_)
)

E(
    substr(x, 1, NA),
    c(NA_character_, NA_character_)
)


E(
    `substr<-`(x, 1, 4, value="jam"),
    c("jam, spam, bacon, and spam", "jam and spam"),
    bad=c("jamm, spam, bacon, and spam", "jams and spam")
)

E(
    `substr<-`(x, 1, 4, value="pear"),
    c("pear, spam, bacon, and spam", "pear and spam")
)

E(
    `substr<-`(x, 1, 4, value="porridge"),
    c("porridge, spam, bacon, and spam", "porridge and spam"),
    bad=c("porr, spam, bacon, and spam", "porr and spam")
)

E(
    `substr<-`(x, 1, 4, value=c("jam", "pear", "porridge")),
    P(c("jam, spam, bacon, and spam", "pear and spam", "porridge, spam, bacon, and spam"), warning="longer object length is not a multiple of shorter object length"),
    bad=c("jamm, spam, bacon, and spam", "pear and spam", "porr, spam, bacon, and spam"),
    worst=c("jamm, spam, bacon, and spam", "pear and spam")
)

E(
    `substr<-`(x, 0, 0, value="jam, "),
    c("jam, spam, spam, bacon, and spam", "jam, eggs and spam"),
    bad=c("spam, spam, bacon, and spam", "eggs and spam")
)


x1 <- structure(c(a="a"), attrib1="value1")
x2 <- structure(c(a="a", b="b"), attrib1="value1")
y <- structure(c(x="x", y="y"), attrib2="value2")

E(
    `substr<-`(x1, 1, 1, value=y),
    y,
    bad="x"
)

E(
    `substr<-`(x2, 1, 1, value=y),
    structure(c(a="x", b="y"), attrib1="value1", attrib2="value2"),
    bad=c("x", "y")
)
