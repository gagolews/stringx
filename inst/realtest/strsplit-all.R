E(strsplit("aaa", character(0), fixed=FALSE), list(), bad=list(c("a", "a", "a")))
E(strsplit(character(0), "aaa", fixed=FALSE), list())
E(strsplit("aaa", NA, fixed=FALSE), list(NA_character_), bad=list("aaa"))
E(strsplit("aaa", NA_character_, fixed=FALSE), list(NA_character_), bad=list("aaa"))
E(strsplit(NA, "aaa", fixed=FALSE), list(NA_character_), bad=P(error=TRUE))
E(strsplit(NA_character_, "aaa", fixed=FALSE), list(NA_character_), bad=P(error=TRUE))

E(strsplit("aaa", character(0), fixed=TRUE), list(), bad=list(c("a", "a", "a")))
E(strsplit(character(0), "aaa", fixed=TRUE), list())
E(strsplit("aaa", NA, fixed=TRUE), list(NA_character_), bad=list("aaa"))
E(strsplit("aaa", NA_character_, fixed=TRUE), list(NA_character_), bad=list("aaa"))
E(strsplit(NA, "aaa", fixed=TRUE), list(NA_character_), bad=P(error=TRUE))
E(strsplit(NA_character_, "aaa", fixed=TRUE), list(NA_character_), bad=P(error=TRUE))

E(
    strsplit("a\U0001F4A9a", ""),
    P(list(NA_character_), warning=TRUE),
    list(c("a", "\U0001F4A9", "a"))  # well, it's a feature...
)

E(strsplit("123a456", "a", fixed=FALSE), list(c("123", "456")))
E(strsplit("123a456", "a", fixed=TRUE), list(c("123", "456")))
E(strsplit("123a456", "A", fixed=FALSE), list("123a456"))
E(strsplit("123a456", "A", fixed=TRUE),  list("123a456"))
E(strsplit("123aaa456", "a+", fixed=TRUE),  list("123aaa456"))
E(strsplit("123aaa456", "a+", fixed=FALSE), list(c("123", "456")))

E(
    strsplit("123a456", "A", fixed=FALSE, ignore.case=TRUE),
    list(c("123", "456")),
    bad=P(error="unused argument (ignore.case = TRUE)"),
    .comment="`grep` has `ignore.case` argument"
)

E(
    strsplit("123a456", "A", fixed=TRUE, ignore.case=TRUE),
    list(c("123", "456")),
    bad=P(error="unused argument (ignore.case = TRUE)"),
    .comment="`grep` has `ignore.case` argument"
)


# Note that this means that if there is a match at the beginning of a (non-empty) string, the first element of the output is "", but if there is a match at the end of the string, the output is the same as with the match removed.

strsplit(",a,b,", ",")
list(c("", "a", "b", ""))
list(c("", "a", "b"))

# partial recycling
strsplit(c("a.b,c.d", "a,b.c,d"), c(",", "."), fixed=TRUE)
strsplit(c("a.b,c.d"), c(",", "."), fixed=TRUE)
strsplit(c("a.b,c.d", "a,b.c,d"), ",", fixed=TRUE)
strsplit(c("a.b,c.d", "a,b.c,d", "d,e,f"), c(",", "."), fixed=TRUE)
strsplit(c("a.b,c.d", "a,b.c,d"), c(",", ".", "."), fixed=TRUE)

# attributes

