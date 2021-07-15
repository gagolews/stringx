# sanity checks, empty vectors, NA propagation, recycling rule, coercion:

E(startsWith(character(0), "a"), logical(0))
E(endsWith(character(0), "a"), logical(0))
E(startsWith("a", character(0)), logical(0))
E(endsWith("a", character(0)), logical(0))

E(startsWith("ababa", prefix=c("a", "ab", "aba", "baba", NA)), c(TRUE, TRUE, TRUE, FALSE, NA))
E(endsWith("ababa", suffix=c("a", "ab", "aba", "baba", NA)), c(TRUE, FALSE, TRUE, TRUE, NA))

E(startsWith(c("a", "ab", "aba", "baba", NA, "a"), c("a", NA)), c(TRUE, NA, TRUE, NA, NA, NA))
E(endsWith(c("a", "ab", "aba", "baba", NA, "a"), c("a", NA)), c(TRUE, NA, TRUE, NA, NA, NA))

E(
    startsWith(c("a", "b"), c("a", "b", "c")),
    P(c(TRUE, TRUE, FALSE), warning=TRUE),
    bad=c(TRUE, TRUE, FALSE),
    .comment="recycling rule warning"
)

E(
    endsWith(c("a", "b", "c"), c("a", "b")),
    P(c(TRUE, TRUE, FALSE), warning=TRUE),
    bad=c(TRUE, TRUE, FALSE),
    .comment="recycling rule warning"
)

E(startsWith(1, 1), TRUE, bad=P(error=TRUE))
E(endsWith(1, 1), TRUE, bad=P(error=TRUE))

E(startsWith(1, 1), TRUE, bad=P(error=TRUE))
E(endsWith(1, 1), TRUE, bad=P(error=TRUE))


E(
    startsWith("ABABA", c("a", "ab", "aba", "baba", NA), ignore.case=TRUE),
    c(TRUE, TRUE, TRUE, FALSE, NA),
    bad=P(error=TRUE),
    .comment="`grep` has `ignore.case` argument"
)

E(
    endsWith("ABABA", c("a", "ab", "aba", "baba", NA), ignore.case=TRUE),
    c(TRUE, FALSE, TRUE, TRUE, NA),
    bad=P(error=TRUE),
    .comment="`grep` has `ignore.case` argument"
)


x0 <- c("a", "b", "c")  # attribs from x and y (x preferred)
x <- structure(x0, names=c("A", "B", "C"), attrib1="value1")
y <- structure(c(x="a", y="b", z="a"), attrib2="value2")
E(
    startsWith(x, y),
    `attributes<-`(c(TRUE, TRUE, FALSE), c(attributes(y), attributes(x))),
    bad=`attributes<-`(c(TRUE, TRUE, FALSE), attributes(x)),
    bad=structure(c(TRUE, TRUE, FALSE), names=names(x)),
    bad=c(TRUE, TRUE, FALSE),
    .comment="attribute preservation"
)
E(
    endsWith(x, y),
    `attributes<-`(c(TRUE, TRUE, FALSE), c(attributes(y), attributes(x))),
    bad=`attributes<-`(c(TRUE, TRUE, FALSE), attributes(x)),
    bad=structure(c(TRUE, TRUE, FALSE), names=names(x)),
    bad=c(TRUE, TRUE, FALSE),
    .comment="attribute preservation"
)

x0 <- "a"  # attribs from y
x <- structure(x0, names="A", attrib1="value1")
E(
    startsWith(x, y),
    `attributes<-`(c(TRUE, FALSE, TRUE), attributes(y)),
    bad=structure(c(TRUE, FALSE, TRUE), names=names(y)),
    bad=structure(c(TRUE, FALSE, TRUE), names=rep(names(x), length(y))),
    bad=c(TRUE, FALSE, TRUE),
    .comment="attribute preservation"
)
E(
    endsWith(x, y),
    `attributes<-`(c(TRUE, FALSE, TRUE), attributes(y)),
    bad=structure(c(TRUE, FALSE, TRUE), names=names(y)),
    bad=structure(c(TRUE, FALSE, TRUE), names=rep(names(x), length(y))),
    bad=c(TRUE, FALSE, TRUE),
    .comment="attribute preservation"
)
