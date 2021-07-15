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

E(strsplit("123a456", split="a", fixed=FALSE), list(c("123", "456")))
E(strsplit("123a456", split="a", fixed=TRUE), list(c("123", "456")))
E(strsplit("123a456", "A", fixed=FALSE), list("123a456"))
E(strsplit("123a456", "A", fixed=TRUE),  list("123a456"))
E(strsplit("123aaa456", "a+", fixed=TRUE),  list("123aaa456"))
E(strsplit("123aaa456", "a+", fixed=FALSE), list(c("123", "456")))

E(
    strsplit("123a456", "A", fixed=FALSE, ignore.case=TRUE),
    list(c("123", "456")),
    bad=P(error=TRUE),
    .comment="`grep` has `ignore.case` argument"
)

E(
    strsplit("123a456", "A", fixed=TRUE, ignore.case=TRUE),
    list(c("123", "456")),
    bad=P(error=TRUE),
    .comment="`grep` has `ignore.case` argument"
)

E(
    strsplit(",a,b,", ","),
    list(c("", "a", "b", "")),
    list(c("a", "b")),
    bad=list(c("", "a", "b"))
)

# partial recycling
E(
    strsplit(c("a.b,c.d", "a,b.c,d"), c(",", "."), fixed=TRUE),
    list(c("a.b", "c.d"), c("a,b", "c,d"))
)

E(
    strsplit("a.b,c.d", c(",", "."), fixed=TRUE),
    list(c("a.b", "c.d"), c("a", "b,c", "d")),
    bad=list(c("a.b", "c.d"))
)

E(
    strsplit(c("a.b,c.d", "a,b.c,d"), ",", fixed=TRUE),
    list(c("a.b", "c.d"), c("a", "b.c", "d"))
)

E(
    strsplit(c(a="a.b,c.d", b="a,b.c,d", c="d,e,f"), c(",", "."), fixed=TRUE),
    P(list(a=c("a.b", "c.d"), b=c("a,b", "c,d"), c=c("d", "e", "f")), warning=TRUE),
    bad=list(a=c("a.b", "c.d"), b=c("a,b", "c,d"), c=c("d", "e", "f"))
)

E(
    strsplit(c("a.b,c.d", "a,b.c,d"), c(",", ".", "."), fixed=TRUE),
    P(list(c("a.b", "c.d"), c("a,b", "c,d"), c("a", "b,c", "d")), warning=TRUE),
    bad=list(c("a.b", "c.d"), c("a,b", "c,d"))
)


x <- structure(c("a,b", "c,d,e"), attrib1="value1", dim=c(1, 2))
y <- structure(c(u=","), attrib2="value2")
E(
    strsplit(x, y),
    `attributes<-`(list(c("a", "b"), c("c", "d", "e")), attributes(x)),
    bad=list(c("a", "b"), c("c", "d", "e"))
)


x <- structure(c(x="a,b", y="c,d,e"), attrib1="value1")
y <- structure(c(u=",", v=","), attrib2="value2")
E(
    strsplit(x, y),
    `attributes<-`(list(c("a", "b"), c("c", "d", "e")), c(attributes(x), attrib2="value2")),
    bad=list(x=c("a", "b"), y=c("c", "d", "e"))
)
