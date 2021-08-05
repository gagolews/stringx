E(strwrap(c("aaa", NA, "ccc")), c("aaa", NA, "ccc"), bad=c("aaa", "NA", "ccc"))
E(strwrap(c("aaa", NA, "ccc"), simplify=FALSE), list("aaa", NA_character_, "ccc"), bad=list("aaa", "NA", "ccc"))

E(strwrap("aaa    \n bbb     ccc", 80), "aaa bbb ccc")
E(strwrap("aaa.    \n bbb,     ccc. ddd", 80), "aaa. bbb, ccc. ddd", "aaa.  bbb, ccc. ddd")  # hmmm....

E(
    strwrap(strrep("abcd ", 4), 20, indent=5, exdent=10),
    c("     abcd abcd abcd", "          abcd")
)

E(
    strwrap(strrep("abcd ", 4), 20, prefix="          ", initial="     "),
    c("     abcd abcd abcd", "          abcd")
)

E(
    strwrap(strrep("abcd ", 4), 20, prefix="          ", initial="     ", indent=5),
    c("          abcd abcd", "          abcd abcd")
)

E(
    strwrap(strrep("abcd ", 4), 20, prefix="          ", initial="     ", indent=5, exdent=5),
    c("          abcd abcd", "               abcd", "               abcd")
)


E(strwrap(character(0)), character(0))
E(strwrap(character(0), simplify=FALSE), list())

E(stringi::stri_width(strwrap(strrep("az ", 20), 60)), 59L)
E(stringi::stri_width(strwrap(strrep("\u0105\u20AC ", 20), 60)), 59L)
E(stringi::stri_width(strwrap(strrep("\U0001F643 ", 20), 60)), 59L, bad=39L)
E(stringi::stri_width(strwrap(strrep("\U0001F3F3\U0000FE0F\U0000200D\U0001F308 ", 20), 60)), 59L, bad=c(44L, 14L), bad=c(74L, 24L), bad=c(59L, 39L))

# attribute preservation (lack thereof)
E(attributes(strwrap(structure(c(a="aaa", attrib1="value1")), simplify=TRUE)), NULL)
E(attributes(strwrap(structure(c(a="aaa", attrib1="value1")), simplify=FALSE)), NULL)
