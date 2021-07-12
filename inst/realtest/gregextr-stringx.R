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

regextr2(x, "mario", ignore_case=TRUE, fixed=TRUE)
gregextr2(x, "mario", ignore_case=TRUE, fixed=TRUE)

regextr2(x, "mario", fixed=NA, strength=1L)
gregextr2(x, "mario", fixed=NA, strength=1L)

regextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE)
gregextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE)

regextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE, capture_groups=TRUE)
gregextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE, capture_groups=TRUE)

regextr2(x, "mario", fixed=NA, strength=1L, capture_groups=TRUE)
gregextr2(x, "mario", fixed=NA, strength=1L, capture_groups=TRUE)

`regextr2<-`(x, "[mM]\\w+", value="x")

`regextr2<-`(x, "[mM]\\w+", value=LETTERS[1:5])  # ?????

`gregextr2<-`(x, "[mM]\\w+", value="x")  # ??????

`gregextr2<-`(x, "[mM]\\w+", value=LETTERS[1:5])  # ??????

`gregextr2<-`(x, "[mM]\\w+", value=list(LETTERS[1:5]))  # ??????

# TODO: simplify arg?



x <- c(aca1="acacaca", aca2="gaca", noaca="actgggca", na=NA)
p <- "(?<x>a)(?<y>cac?)"
regextr2(x,  p)
gregextr2(x, p)
regextr2(x,  p, capture_groups=TRUE)
gregextr2(x, p, capture_groups=TRUE)

regmatches(x, base::regexpr(p, x, perl=TRUE))
regmatches(x, base::gregexpr(p, x, perl=TRUE))

regmatches(x, base::regexec(p, x, perl=TRUE))
regmatches(x, base::gregexec(p, x, perl=TRUE))

regmatches(x, base::regexec(p, x, perl=TRUE))
regmatches(x, base::gregexec(p, x, perl=TRUE))

strcapture(p, x, perl=TRUE, proto=data.frame(a="", b=""))


# recycling and attributes:
x <- structure(c(a="abaxabaab", b="bab", c="aba"), attr1="value1")

E(
    regextr2(x, c("(?<a>.)b(\\1)?", "bab")),
    P(
        structure(c(a="aba", b="bab", c="aba"), attr1="value1"),
        warning="longer object length is not a multiple of shorter object length"
    )
)
E(
    regextr2(x, c("(?<a>.)b(\\1)?", "bab"), capture_groups=TRUE),
    P(
        structure(list(a=c("aba", a="a", "a"), b="bab", c=c("aba", a="a", "a")), attr1="value1"),
        warning="longer object length is not a multiple of shorter object length"
    )
)
E(
    gregextr2(x, c("(?<a>.)b(\\1)?", "bab")),
    P(
        structure(list(a=c("aba", "aba", "ab"), b=c("bab"), c=c("aba")), attr1="value1"),
        warning="longer object length is not a multiple of shorter object length"
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
        warning="longer object length is not a multiple of shorter object length"
    )
)

E(
    `regextr2<-`(x, c("(?<a>.)b(\\1)?", "bab"), value=c(f="!", g="?", h="@", i="$", j="&")),
    P(
        c(f="!xabaab", g="?", h="@", i="abaxabaab", j="b&"),
        warning="longer object length is not a multiple of shorter object length"
    )
)


E(
    `gregextr2<-`(x, c("(?<a>.)b(\\1)?", "bab"), value=c(f="!", g="?", h="@", i="$", j="&")),
    P(
        c(f="!x!!", g="?", h="@", i="abaxabaab", j="b&"),
        warning="longer object length is not a multiple of shorter object length"
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
        warning="longer object length is not a multiple of shorter object length"
    )
)

E(
    `gregextr2<-`(c("a", "b"), c("a", "b", "a"), value=c(f="!", g="?", h="@", i="$", j="&")),
    P(
        c(f="!", g="?", h="@", i="b", j="a"),
        warning="longer object length is not a multiple of shorter object length"
    )
)

E(
    `gregextr2<-`(x, c("(?<a>.)b(\\1)?", "bab"), value=list(c(f="!", g="?", h="@", i="$", j="&"))),
    P(
        structure(
            c(a="!x?@", b="!", c="!"),
            attr1="value1"
        ),
        warning=c(
            "longer object length is not a multiple of shorter object length",
            rep("vector length not consistent with other arguments", 3)
        )
    )
)
