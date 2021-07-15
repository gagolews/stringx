x <- structure(
    c(a="gross", b=NA, c="abcdefghi", d="ABCDEFGHI"),
    attrib1="value1"
)

E(
    chartr("abc", "xyz", x),
    `attributes<-`(c("gross", NA, "xyzdefghi", "ABCDEFGHI"), attributes(x)),
    bad=c("gross", NA, "xyzdefghi", "ABCDEFGHI"),
    .comment="attribute preservation"
)


E(chartr("abc", "xyz", character(0)), character(0))

E(
    chartr(character(0), character(0), "unchanged"),
    "unchanged",
    P(error=TRUE)
)

E(
    chartr(NA_character_, "xyz", "aixbjyckz"),
    NA_character_,
    P(error=TRUE)
)

E(
    chartr("abc", NA_character_, "aixbjyckz"),
    NA_character_,
    P(error=TRUE)
)

E(
    chartr("abc", "xyz", NA_character_),
    NA_character_,
    P(error=TRUE)
)

E(
    chartr("ab", "xyz", "aixbjyckz"),
    P("xixyjyckz", warning=TRUE),
    P(error=TRUE),
    bad="xixyjyckz"
)

E(
    chartr("abc", "xy", "aixbjyckz"),
    P("xixyjyckz", warning=TRUE),
    P("xixyjyxkz", warning=TRUE),
    P(error=TRUE),
    bad=P("xixyjyckz")
)

E(
    chartr("\u00DF\U0001D554aba", "SCXBA", as.matrix(c(a="\u00DFpam ba\U0001D554on spam", b=NA))),
    as.matrix(c(a="SpAm BACon spAm", b=NA)),
    bad=c(a="SpAm BACon spAm", b=NA),
    worst=P(error=TRUE)
)



# PHP has strtr("abc", "ab", "bc") == "bcc"
# Bioinformatics prefers "bcc" (actg strings etc.)

E(
    chartr("ab", "bc", "abc"),
    P("bcc", warning=TRUE),  # controversial
    P("bcc"),
    bad=P(error=TRUE),
    bad=P("ccc", warning=TRUE),
    bad=P("ccc")
)
