E(grepl2(character(0), "a", fixed=NA), logical(0))
E(grepl2("a", character(0), fixed=NA), logical(0))

x <- c("mario", "Mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario", NA)
E(grepl2(x, "mario"), c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA))
E(grepl2(x, "mario", fixed=NA), c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA))
E(grepl2(x, "mario", ignore_case=TRUE), c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA))
E(
    grepl2(x, "mario", fixed=NA, ignore_case=TRUE),
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA),
    bad=c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)  # C locale
)
E(
    grepl2(x, "mario", fixed=NA, strength=1L),
    c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, NA),
    bad=c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)  # C locale
)

E(grepl2("abc", ".{3,3}"), TRUE)  # default fixed=FALSE

E(grepv2(c("abc", "def", NA, ""), "a"), "abc")
E(grepv2(c("abc", "def"), c("a", "d")), c("abc", "def"))

E(c(x="abc", y="def") |> grepv2("a"), c(x="abc"))

E(grepv2(c("abc", c("abc", "def"))), P(error=TRUE))
E(`grepv2<-`(c("abc", c("abc", "def"), value=7)), P(error=TRUE))

E(`grepv2<-`(c(x="abc", y="def"), "a", value="xyz"), c(x="xyz", y="def"))
E(`grepv2<-`(c(x="abc", y="def"), c("a", "d"), value="xyz"), c(x="xyz", y="xyz"))
E(`grepv2<-`(c(x="abc", y="def"), c("a", "d"), value=c("xyz", "uvw")), c(x="xyz", y="uvw"))
E(`grepv2<-`(c("abc", "def", NA, ""), "a", value=c("X", "Y")), P(c("X", "def", NA, ""), warning=TRUE))
