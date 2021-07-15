E(gsub(character(0), "a", "a"), character(0), bad=P(error=TRUE))
E(gsub("a", character(0), "a"), character(0), bad=P(error=TRUE))
E(gsub("a", "a", character(0)), character(0), bad=P(error=TRUE))

E(sub(character(0), "a", "a"), character(0), bad=P(error=TRUE))
E(sub("a", character(0), "a"), character(0), bad=P(error=TRUE))
E(sub("a", "a", character(0)), character(0), bad=P(error=TRUE))

E(gsub("a", "a", NA_character_), NA_character_)
E(gsub("a", NA_character_, "a"), NA_character_)
E(gsub(NA_character_, "a", "a"), NA_character_)

E(sub("a", "a", NA_character_), NA_character_)
E(sub("a", NA_character_, "a"), NA_character_)
E(sub(NA_character_, "a", "a"), NA_character_)


E(sub("a", c("x", "y"), "abc"), c("xbc", "ybc"), bad=P(error=TRUE), bad=P("xbc", warning=TRUE))
E(sub(c("a", "b"), "x", "abc"), c("xbc", "axc"), bad=P(error=TRUE), bad=P("xbc", warning=TRUE))

E(gsub("a", c("x", "y"), "abc"), c("xbc", "ybc"), bad=P(error=TRUE), bad=P("xbc", warning=TRUE))
E(gsub(c("a", "b"), "x", "abc"), c("xbc", "axc"), bad=P(error=TRUE), bad=P("xbc", warning=TRUE))

E(
    sub(c("a", "b", "c"), c("x", "y"), "abc"),
    P(c("xbc", "ayc", "abx"), warning=TRUE),
    bad=P(error=TRUE),
    bad=P("xbc", warning=TRUE)
)
E(
    gsub(c("a", "b", "c"), c("x", "y"), "abc"),
    P(c("xbc", "ayc", "abx"), warning=TRUE),
    bad=P(error=TRUE),
    bad=P("xbc", warning=TRUE)
)

E(gsub("(.+)", "\\1", "(.+)", fixed=TRUE), "\\1")
E(sub("(.+)", "\\1", "(.+)", fixed=TRUE), "\\1")

E(gsub("(.+)", "\\1", "abc"), "abc")
E(gsub("(.+)", "\\\\1", "abc"), "\\1")
E(gsub("(.+)", "\\a\\1\\abc\\0", "xyz"), "axyzabc0")

E(sub("(.+)", "\\1", "abc"), "abc")
E(sub("(.+)", "\\\\1", "abc"), "\\1")
E(sub("(.+)", "\\a\\1\\abc\\0", "xyz"), "axyzabc0")

x <- "abcdefghijklmnopqrstuvwxyz"
p <- "(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)"

E(gsub(p, "${name}$1$9$13$$\\1\\9\\13\\\\1\\k<name>", x), "${name}$1$9$13$$aia3\\1k<name>${name}$1$9$13$$nvn3\\1k<name>")
E(gsub(p, "\\1\\9", x), "ainv")
E(gsub(p, "\\1\\13", x), better="amnz", "aa3nn3")  # well, we could do that, but compatibility...

x <- structure(c(x="abc", y="abd"), attrib1="value1")
E(sub("ab", "x", x), `attributes<-`(c("xc", "xd"), attributes(x)))
E(gsub("ab", "x", x), `attributes<-`(c("xc", "xd"), attributes(x)))
