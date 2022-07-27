# sanity checks, empty vectors, NA propagation, recycling rule, coercion:

E(strtrim("aaaaa", 5), c("aaaaa"))
E(strtrim("a", 5), c("a"))
E(strtrim("", 5), c(""))
E(
    strtrim("aaaaa", 0:3),
    c("", "a", "aa", "aaa"),
    bad=""
)
E(strtrim(c("aaaaa", "bbbbb", "ccccc"), c(0, 5, 2)), c("", "bbbbb", "cc"))
E(strtrim(c("aaaaa", "bbbbb", "ccccc", "ddddd"), c(2, 3)), c("aa", "bbb", "cc", "ddd"))
E(
    strtrim(c("aaaaa", "bbbbb", NA, "ddddd"), c(2, NA, 4, 1)),
    c("aa", NA, NA, "d"),
    bad=P(error=TRUE)
)
E(
    strtrim(c("aaaaa", "bbbbb"), c(2, 3, 4, 1)),
    c("aa", "bbb", "aaaa", "b"),
    bad=c("aa", "bbb")
)
E(
    strtrim(LETTERS, integer(0)),
    character(0),
    bad=P(error=TRUE)
)
E(strtrim(character(0), 1:10), character(0))
E(
    strtrim(LETTERS, NULL),
    character(0),
    bad=P(error=TRUE)
)
E(strtrim(NULL, 1:10), character(0))
E(strtrim(NA, 3), NA_character_)
E(strtrim(c(1111, 2222, 3333), 1:3), c("1", "22", "333"))
E(strtrim(c(TRUE, FALSE, NA), 1), c("T", "F", NA))

x <- c(
    "\U0001F4A9",
    "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
    "\U0001F64D\U0001F3FB\U0000200D\U00002642",
    "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
    "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
)
E(
    strtrim(x, 1),
    rep("", length(x)),
    bad=c("", "", "", "\u26F9", ""),
    bad=substr(x, 1, 1),
    worst=c("<", "<", "<", "<", "<")
)
E(
    strtrim(x, 2),
    x,
    bad=c("\U0001F4A9", "\U0001F64D", "\U0001F64D", "\u26F9",
        "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"),
    bad=substr(x, 1, 2),
    bad=c("\U0001F4A9", "\U0001F64D\U0001F3FC\u200D", "\U0001F64D\U0001F3FB\u200D",
        "\u26F9\U0001F3FF\u200D", "\U0001F3F4\U000E0067"),
    worst=c("<U", "<U", "<U", "<U", "<U")
)
E(
    strtrim(x, 3),
    x,
    bad=c("\U0001F4A9", "\U0001F64D", "\U0001F64D", "\u26F9\U0001F3FF\u200D",
        "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"),
    bad=c(
        "\U0001F4A9",
        "\U0001F64D\U0001F3FC\U0000200D",
        "\U0001F64D\U0001F3FB\U0000200D",
        "\U000026F9\U0001F3FF\U0000200D",
        "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
    ),
    bad=c("\U0001F4A9", "\U0001F64D\U0001F3FC\u200D\u2642\uFE0F",
        "\U0001F64D\U0001F3FB\u200D\u2642", "\u26F9\U0001F3FF\u200D\u2640\uFE0F",
        "\U0001F3F4\U000E0067\U000E0062"),
    bad=substr(x, 1, 3),
    worst=c("<U+", "<U+", "<U+", "<U+", "<U+")
)
E(
    strtrim(x, 4),
    x,
    bad=c("\U0001F4A9", "\U0001F64D\U0001F3FC\u200D",
        "\U0001F64D\U0001F3FB\u200D", "\u26F9\U0001F3FF\u200D\u2640\uFE0F",
        "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"),
    bad=c(
        "\U0001F4A9",
        "\U0001F64D\U0001F3FC\U0000200D",
        "\U0001F64D\U0001F3FB\U0000200D",
        "\U000026F9\U0001F3FF\U0000200D",
        "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
    ),
    bad=c("\U0001F4A9", "\U0001F64D\U0001F3FC\u200D\u2642\uFE0F",
        "\U0001F64D\U0001F3FB\u200D\u2642",
        "\u26F9\U0001F3FF\u200D\u2640\uFE0F",
        "\U0001F3F4\U000E0067\U000E0062\U000E0073"),
    bad=substr(x, 1, 4),
    worst=c("<U+0", "<U+0", "<U+0", "<U+2", "<U+0")
)
E(
    strtrim(x, 5),
    x,
    bad=substr(x, 1, 5),
    worst=c("<U+00", "<U+00", "<U+00", "<U+26", "<U+00")
)

E(
    strtrim(c(1111, 2222, 3333), 1:2),
    P(c("1", "22", "3"), warning=TRUE),
    bad=c("1", "22", "3"),
    bad=P(error=TRUE),
    .comment="recycling rule warning"
)


x0 <- c("a", NA, "c")  # attribs from x and y (x preferred)
x <- structure(x0, names=c("A", "B", "C"), attrib1="value1")
y <- structure(c(x=1, y=1, z=1), attrib2="value2")
E(
    strtrim(x, y),
    `attributes<-`(x0, c(attributes(y), attributes(x))),
    bad=`attributes<-`(x0, attributes(x)),
    bad=structure(x0, names=names(x)),
    bad=x0,
    .comment="attribute preservation"
)

x0 <- "a"  # attribs from y
x <- structure(x0, names="A", attrib1="value1")
E(
    strtrim(x, y),
    `attributes<-`(rep(x0, length(y)), attributes(y)),
    bad=structure(rep(x0, length(y)), names=names(y)),
    bad=structure(rep(x0, length(y)), names=rep(names(x), length(y))),
    bad=rep(x0, length(y)),
    bad=x,
    .comment="attribute preservation"
)
