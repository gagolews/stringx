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
    substr(rep("abc", 9), c(-1, 0, 0, 1, 1, 2, NA, 1, NA), c(-1, -1, 0, -1, 0, 1, 1, NA, NA)),
    better=c("c", "abc", "", "abc", "", "", NA, NA, NA),
    c(rep("", 6), rep(NA_character_, 3))
)

E(
    substr(rep("abc", 4), c(3+1, 3, 3+1, 3), c(3+1, 3+1, 3, 3)),
    c("", "c", "", "c")
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
    P(c("spam", "bacon", "eggs"), warning=TRUE),
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
    `substr<-`(x, 1, 4, value="j\u0105m"),
    c("j\u0105m, spam, bacon, and spam", "j\u0105m and spam"),
    bad=c("j\u0105mm, spam, bacon, and spam", "j\u0105ms and spam"),
    worst=c("jamm, spam, bacon, and spam", "jams and spam"),
    worst=c("j<U+, spam, bacon, and spam", "j<U+ and spam")
)

E(
    `substr<-`(x, 1, 4, value="pe\u0105r"),
    c("pe\u0105r, spam, bacon, and spam", "pe\u0105r and spam"),
    worst=c("pear, spam, bacon, and spam", "pear and spam"),
    worst=c("pe<U, spam, bacon, and spam", "pe<U and spam")
)

E(
    `substr<-`(x, 1, 4, value="p\u00f3rridge"),
    c("p\u00f3rridge, spam, bacon, and spam", "p\u00f3rridge and spam"),
    bad=c("p\u00f3rr, spam, bacon, and spam", "p\u00f3rr and spam"),
    worst=c("porr, spam, bacon, and spam", "porr and spam"),
    worst=c("p<U+, spam, bacon, and spam", "p<U+ and spam")
)

E(
    `substr<-`(x, 1, 4, value=c("jam", "pear", "porridge")),
    P(c("jam, spam, bacon, and spam", "pear and spam", "porridge, spam, bacon, and spam"), warning=TRUE),
    bad=c("jamm, spam, bacon, and spam", "pear and spam", "porr, spam, bacon, and spam"),
    worst=c("jamm, spam, bacon, and spam", "pear and spam")
)

E(
    `substr<-`(x, 0, 0, value="jam, "),
    c("jam, spam, spam, bacon, and spam", "jam, eggs and spam"),
    bad=c("spam, spam, bacon, and spam", "eggs and spam")
)

E(
    `substr<-`(rep("abc", 4), c(3+1, 3, 3+1, 3), c(3+1, 3+1, 3, 3), value="x"),
    better=c("abcx", "abx", "abcx", "abx"),
    c("abc", "abx", "abc", "abx")
)

E(
    `substr<-`(rep("abc", 9), c(-1, 0, 0, 1, 1, 2, NA, 1, NA), c(-1, -1, 0, -1, 0, 1, 1, NA, NA), value="x"),
    better=c("abx", "x", "xabc", "x", "xabc", "axbc", NA, NA, NA),
    c("xbc", "xbc", "abc", "xbc", "abc", "abc", NA, NA, NA)
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
