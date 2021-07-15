# empty vectors:
E(regextr2(character(0), "?"), character(0))
E(regextr2("?", character(0)), character(0))
E(`regextr2<-`(character(0), "?", value="!"), character(0))
E(`regextr2<-`("?", character(0), value="!"), character(0))
E(`regextr2<-`("?", "!", value=character(0)), character(0))

E(gregextr2(character(0), "?"), list())
E(gregextr2("?", character(0)), list())
E(`gregextr2<-`(character(0), "?", value="!"), character(0))
E(`gregextr2<-`("?", character(0), value="!"), character(0))
E(`gregextr2<-`("?", "!", value=character(0)), character(0))


# basic functionality:
x <- c("mario", "Mario M\u00E1rio M\u00C1RIO Mar\u00EDa Marios", "Rosario", NA)

E(regextr2(x, "mario", ignore_case=TRUE, fixed=TRUE), c("mario", "Mario", NA, NA))
E(gregextr2(x, "mario", ignore_case=TRUE, fixed=TRUE), list("mario", c("Mario", "Mario"), character(0), NA_character_))

E(regextr2(x, "mario", fixed=NA, strength=1L), c("mario", "Mario", NA, NA))
E(gregextr2(x, "mario", fixed=NA, strength=1L), list("mario", c("Mario", "M\u00E1rio", "M\u00C1RIO", "Mario"), character(0), NA_character_))

E(regextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE), c("mario", "Mario", NA, NA))
E(gregextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE), list("mario", c("Mario", "M\u00E1rio", "M\u00C1RIO", "Marios"), character(0), NA_character_))

E(
    regextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE, capture_groups=TRUE),
    list(
        c("mario", a="a", plural=NA),
        c("Mario", a="a", plural=NA),
        c(NA_character_, a=NA, plural=NA),
        c(NA_character_, a=NA, plural=NA)
    )
)

E(
    gregextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE, capture_groups=TRUE),
    list(
        cbind(c("mario", a="a", plural=NA)),
        cbind(c("Mario", a="a", plural=NA), c("M\u00E1rio", "\u00E1", NA), c("M\u00C1RIO", "\u00C1", NA), c("Marios", "a", "s")),
        cbind(c(NA_character_, a=NA, plural=NA))[, -1, drop=FALSE],
        cbind(c(NA_character_, a=NA, plural=NA))
    )
)

E(regextr2(x, "mario", fixed=NA, strength=1L, capture_groups=TRUE), list("mario", "Mario", NA_character_, NA_character_))

E(
    gregextr2(x, "mario", fixed=NA, strength=1L, capture_groups=TRUE),
    list(
        cbind("mario"),
        cbind("Mario", "M\u00E1rio", "M\u00C1RIO", "Mario"),
        cbind(NA_character_)[, -1, drop=FALSE],
        cbind(NA_character_)
    )
)

E(`regextr2<-`(x, "[mM]\\w+", value="x"), c("x", "x M\u00E1rio M\u00C1RIO Mar\u00EDa Marios", "Rosario", NA))
E(`regextr2<-`(x, "[mM]\\w+", value=LETTERS[1:5]), c("A", "B M\u00E1rio M\u00C1RIO Mar\u00EDa Marios", "Rosario", NA, "E"))
E(`gregextr2<-`(x, "[mM]\\w+", value="x"), c("x", "x x x x x", "Rosario", NA))
E(`gregextr2<-`(x, "[mM]\\w+", value=LETTERS[1:5]), c("A", "B B B B B", "Rosario", NA, "E"))
E(
    `gregextr2<-`(x, "[mM]\\w+", value=list(LETTERS[1:5])),
    P(
        c("A", "A B C D E", "Rosario", NA),
        warning=TRUE
    )
)

# recycling and attributes:
x <- structure(c(a="abaxabaab", b="bab", c="aba"), attr1="value1")

E(
    regextr2(x, c("(?<a>.)b(\\1)?", "bab")),
    P(
        structure(c(a="aba", b="bab", c="aba"), attr1="value1"),
        warning=TRUE
    )
)
E(
    regextr2(x, c("(?<a>.)b(\\1)?", "bab"), capture_groups=TRUE),
    P(
        structure(list(a=c("aba", a="a", "a"), b="bab", c=c("aba", a="a", "a")), attr1="value1"),
        warning=TRUE
    )
)
E(
    gregextr2(x, c("(?<a>.)b(\\1)?", "bab")),
    P(
        structure(list(a=c("aba", "aba", "ab"), b=c("bab"), c=c("aba")), attr1="value1"),
        warning=TRUE
    )
)
E(
    gregextr2(x, c("(?<a>.)b(\\1)?", "bab"), capture_groups=TRUE),
    P(
        structure(list(
            a=cbind(c("aba", a="a", "a"), c("aba", a="a", "a"), c("ab", a="a", NA)),
            b=cbind(c("bab")),
            c=cbind(c("aba", a="a", "a"))
        ), attr1="value1"),
        warning=TRUE
    )
)

E(
    `regextr2<-`(x, c("(?<a>.)b(\\1)?", "bab"), value=c(f="!", g="?", h="@", i="$", j="&")),
    P(
        c(f="!xabaab", g="?", h="@", i="abaxabaab", j="b&"),
        warning=TRUE
    )
)


E(
    `gregextr2<-`(x, c("(?<a>.)b(\\1)?", "bab"), value=c(f="!", g="?", h="@", i="$", j="&")),
    P(
        c(f="!x!!", g="?", h="@", i="abaxabaab", j="b&"),
        warning=TRUE
    )
)


E(`regextr2<-`("a", c("a", "b", "a"), value=c(f="!", g="?")),     P(c("!", "a", "!"), warning=TRUE))
E(`regextr2<-`(c("a", "b", "a"), "a", value=c(f="!", g="?")),     P(c("!", "b", "!"), warning=TRUE))
E(`gregextr2<-`("a", c("a", "b", "a"), value=list(f="!", g="?")), P(c("!", "a", "!"), warning=TRUE))
E(`gregextr2<-`(c("a", "b", "a"), "a", value=list(f="!", g="?")), P(c("!", "b", "!"), warning=TRUE))

E(
    `regextr2<-`(c("a", "b"), c("a", "b", "a"), value=c(f="!", g="?", h="@", i="$", j="&")),
    P(
        c(f="!", g="?", h="@", i="b", j="a"),
        warning=TRUE
    )
)

E(
    `gregextr2<-`(c("a", "b"), c("a", "b", "a"), value=c(f="!", g="?", h="@", i="$", j="&")),
    P(
        c(f="!", g="?", h="@", i="b", j="a"),
        warning=TRUE
    )
)

E(
    `gregextr2<-`(x, c("(?<a>.)b(\\1)?", "bab"), value=list(c(f="!", g="?", h="@", i="$", j="&"))),
    P(
        structure(
            c(a="!x?@", b="!", c="!"),
            attr1="value1"
        ),
        warning=TRUE
    )
)


# TODO: regmatches and strcapture compare
# x <- c(aca1="acacaca", aca2="gaca", noaca="actgggca", na=NA)
# p <- "(?<x>a)(?<y>cac?)"
# regextr2(x,  p)
# gregextr2(x, p)
# regextr2(x,  p, capture_groups=TRUE)
# gregextr2(x, p, capture_groups=TRUE)
#
# regmatches(x, base::regexpr(p, x, perl=TRUE))
# regmatches(x, base::gregexpr(p, x, perl=TRUE))
# regmatches(x, base::regexec(p, x, perl=TRUE))
# regmatches(x, base::gregexec(p, x, perl=TRUE))
#
# regmatches(x, regexpr(p, x))
# regmatches(x, gregexpr(p, x))
# regmatches(x, regexec(p, x))
# regmatches(x, gregexec(p, x))
#
# strcapture(p, x, perl=TRUE, proto=data.frame(a="", b=""))
