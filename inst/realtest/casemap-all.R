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


E(toupper(stringx::letters_greek), stringx::LETTERS_GREEK,   bad=stringx::letters_greek)
E(tolower(stringx::LETTERS_GREEK), stringx::letters_greek,   bad=stringx::LETTERS_GREEK)
E(toupper(stringx::letters_bf),    stringx::LETTERS_BF,      bad=stringx::letters_bf)
E(tolower(stringx::LETTERS_BF),    stringx::letters_bf,      bad=stringx::LETTERS_BF)
E(toupper(stringx::letters_bb),    stringx::LETTERS_BB,      bad=stringx::letters_bb)
E(tolower(stringx::LETTERS_BB),    stringx::letters_bb,      bad=stringx::LETTERS_BB)
E(toupper(stringx::letters_cal),   stringx::LETTERS_CAL,     bad=stringx::letters_cal)
E(tolower(stringx::LETTERS_CAL),   stringx::letters_cal,     bad=stringx::LETTERS_CAL)
E(toupper(stringx::letters_frak),  stringx::LETTERS_FRAK,    bad=stringx::letters_frak)
E(tolower(stringx::LETTERS_FRAK),  stringx::letters_frak,    bad=stringx::LETTERS_FRAK)



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
