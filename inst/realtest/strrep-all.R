# sanity checks, empty vectors, NA propagation, recycling rule, coercion:

E(strrep("a", 5), c("aaaaa"))
E(strrep("a", 0:3), c("", "a", "aa", "aaa"))
E(strrep(c("a", "b", "c"), c(0, 5, 2)), c("", "bbbbb", "cc"))
E(strrep(c("a", "b", "c", "d"), c(2, 3)), c("aa", "bbb", "cc", "ddd"))
E(strrep(c("a", "b", NA, "d"), c(2, NA, 4, 1)), c("aa", NA, NA, "d"))
E(strrep(c("a", "b"), c(2, 3, 4, 1)), c("aa", "bbb", "aaaa", "b"))
E(strrep(LETTERS, integer(0)), character(0))
E(strrep(character(0), 1:10), character(0))
E(strrep(LETTERS, NULL), character(0))
E(strrep(NULL, 1:10), character(0))
E(strrep(NA, 3), NA_character_)
E(strrep(1:3, 1:3), c("1", "22", "333"))
E(strrep(c(TRUE, FALSE, NA), 2), c("TRUETRUE", "FALSEFALSE", NA))


E(
    strrep(1:3, 1:2),
    P(c("1", "22", "3"), warning=TRUE),
    bad=c("1", "22", "3"),
    .comment="recycling rule warning"
)

# preservation of attributes:

# structure(c(a=TRUE, b=FALSE), attrib1="value1") * 3
# # a b
# # 3 0
# # attr(,"attrib1")
# # [1] "value1"

# binary operators - attribute preservation
# take all attribs from longer
# or merge attribute list if of equal lengths
# **even if coercion occurs

# strrep should behave in the same way


x0 <- c("a", NA, "c")  # attribs from x and y (x preferred)
x <- structure(x0, names=c("A", "B", "C"), attrib1="value1")
y <- structure(c(x=1, y=1, z=1), attrib2="value2")
E(
    strrep(x, y),
    `attributes<-`(x0, c(attributes(y), attributes(x))),
    bad=`attributes<-`(x0, attributes(x)),
    bad=structure(x0, names=names(x)),
    bad=x0,
    .comment="attribute preservation"
)

x0 <- "a"  # attribs from y
x <- structure(x0, names="A", attrib1="value1")
E(
    strrep(x, y),
    `attributes<-`(rep(x0, length(y)), attributes(y)),
    bad=structure(rep(x0, length(y)), names=names(y)),
    bad=structure(rep(x0, length(y)), names=rep(names(x), length(y))),
    bad=rep(x0, length(y)),
    .comment="attribute preservation"
)
