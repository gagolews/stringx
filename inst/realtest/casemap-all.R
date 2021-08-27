E(tolower(character(0)), character(0))
E(tolower(c("a", NA_character_, "c")), c("a", NA_character_, "c"))
E(toupper(character(0)), character(0))
E(toupper(c("A", NA_character_, "C")), c("A", NA_character_, "C"))

E(
    toupper("gro\u00DF"),
    "GROSS",
    bad="GRO\u00DF"
)

E(
    tolower("gro\u00DF"),
    "gro\u00DF",
    bad="gross"
)


# see https://www.w3.org/TR/charmod-norm/#definitionCaseFolding
# "Case folding is the process of making two texts which differ only in
# case identical for comparison purposes, that is, it is meant
# for the purpose of string matching."
E(
    casefold(c("gro\u00DF", "gross", "GROSS")),
    c("gross", "gross", "gross"),
    c("gro\u00DF", "gro\u00DF", "gro\u00DF"),
    bad=c("gro\u00DF", "gross", "gross")
)


E(
    toupper(c("\u03B1", "\u03B2", "\u03B3", "\u03B4", "\u03B5", "\u03B6")),
    c("\u0391", "\u0392", "\u0393", "\u0394", "\u0395", "\u0396"),
    bad=c("\u03B1", "\u03B2", "\u03B3", "\u03B4", "\u03B5", "\u03B6")
)
E(
    tolower(c("\u0391", "\u0392", "\u0393", "\u0394", "\u0395", "\u0396")),
    c("\u03B1", "\u03B2", "\u03B3", "\u03B4", "\u03B5", "\u03B6"),
    bad=c("\u0391", "\u0392", "\u0393", "\u0394", "\u0395", "\u0396")
)
E(
    toupper(c("\U0001D41A", "\U0001D41B", "\U0001D41C", "\U0001D41D")),
    c("\U0001D400", "\U0001D401", "\U0001D402", "\U0001D403"),
    bad=c("\U0001D41A", "\U0001D41B", "\U0001D41C", "\U0001D41D")
)
E(
    tolower(c("\U0001D400", "\U0001D401", "\U0001D402", "\U0001D403")),
    c("\U0001D41A", "\U0001D41B", "\U0001D41C", "\U0001D41D"),
    bad=c("\U0001D400", "\U0001D401", "\U0001D402", "\U0001D403")
)




x <- structure(
    c(a="gross", b=NA, c="abcdefghi", d="ABCDEFGHI"),
    attrib1="value1"
)

E(
    tolower(x),
    `attributes<-`(c("gross", NA, "abcdefghi", "abcdefghi"), attributes(x)),
    bad=c("gross", NA, "abcdefghi", "abcdefghi"),
    .comment="attribute preservation"
)

E(
    tolower(structure(as.factor(x), attrib1="value1")),
    `attributes<-`(c("gross", NA, "abcdefghi", "abcdefghi"), attributes(x)),
    bad=c("gross", NA, "abcdefghi", "abcdefghi"),
    .comment="attribute preservation"
)

E(
    casefold(x),
    `attributes<-`(c("gross", NA, "abcdefghi", "abcdefghi"), attributes(x)),
    bad=c("gross", NA, "abcdefghi", "abcdefghi"),
    .comment="attribute preservation"
)

E(
    toupper(x),
    `attributes<-`(c("GROSS", NA, "ABCDEFGHI", "ABCDEFGHI"), attributes(x)),
    bad=c("GROSS", NA, "ABCDEFGHI", "ABCDEFGHI"),
    .comment="attribute preservation"
)
