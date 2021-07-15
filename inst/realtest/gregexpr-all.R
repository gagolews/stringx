################################################################################
## realtest: set up a comparer that ignores the useBytes and index.type attribs:

options(realtest_value_comparer=function(x, y) {
    if (is.list(x))
        x <- lapply(x, structure, index.type=NULL, useBytes=NULL)
    else if (is.atomic(x) && !is.null(x))  # and hence not NULL
        x <- structure(x, index.type=NULL, useBytes=NULL)

    if (is.list(y))
        y <- lapply(y, structure, index.type=NULL, useBytes=NULL)
    else if (is.atomic(y) && !is.null(y))  # and hence not NULL
        y <- structure(y, index.type=NULL, useBytes=NULL)

    identical(x, y)
})


################################################################################
## regexpr

E(
    regexpr("aba", character(0), fixed=TRUE),
    structure(integer(0), match.length=integer(0))
)

E(
    regexpr("aba", character(0), fixed=FALSE),
    structure(integer(0), match.length=integer(0))
)

E(
    regexpr("aba", c("ab\u0105", "babababa", NA), fixed=TRUE),
    structure(c(-1L, 2L, NA), match.length=c(-1L, 3L, NA))
)

E(
    regexpr("(ab)(a)", c("ab\u0105", "babababa", NA)),
    structure(c(-1L, 2L, NA), match.length=c(-1L, 3L, NA))
)

E(
    regexpr(NA_character_, "NA", fixed=TRUE),
    structure(NA_integer_, match.length=NA_integer_),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    regexpr(NA_character_, "NA", fixed=FALSE),
    structure(NA_integer_, match.length=NA_integer_),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    regexpr(c("a", "b"), c("aa", "b", "A"), fixed=TRUE, ignore.case=TRUE),
    better=P(
        structure(c(1L, 1L, 1L), match.length=c(1L, 1L, 1L)),
        warning=TRUE
    ),
    P(
        structure(c(1L, -1L, -1L), match.length=c(1L, -1L, -1L)),
        warning=TRUE
    )
)

E(
    regexpr(c("a", "b"), c("aa", "b", "A"), fixed=FALSE, ignore.case=TRUE),
    better=P(
        structure(c(1L, 1L, 1L), match.length=c(1L, 1L, 1L)),
        warning=TRUE
    ),
    P(
        structure(c(1L, -1L, 1L), match.length=c(1L, -1L, 1L)),
        warning=TRUE
    )
)

E(
    regexpr("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1"), fixed=TRUE),
    structure(c(1L, -1L), match.length=c(3L, -1L), names=c("a", "b"), attrib1="value1"),
    bad=structure(c(1L, -1L), match.length=c(3L, -1L))
)

E(
    regexpr("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1")),
    structure(c(1L, -1L), match.length=c(3L, -1L), names=c("a", "b"), attrib1="value1"),
    bad=structure(c(1L, -1L), match.length=c(3L, -1L))
)


################################################################################
## gregexpr

E(
    gregexpr("aba", character(0), fixed=TRUE),
    list()
)

E(
    gregexpr("aba", character(0), fixed=FALSE),
    list()
)

E(
    gregexpr("aba", c("ab\u0105", "babababa", NA), fixed=TRUE),
    list(
        structure(c(-1L), match.length=c(-1L)),
        structure(c(2L, 6L), match.length=c(3L, 3L)),
        structure(c(NA_integer_), match.length=c(NA_integer_))
    )
)

E(
    gregexpr("(ab)(a)", c("ab\u0105", "babababa", NA)),
    list(
        structure(c(-1L), match.length=c(-1L)),
        structure(c(2L, 6L), match.length=c(3L, 3L)),
        structure(c(NA_integer_), match.length=c(NA_integer_))
    )
)

E(
    gregexpr(NA_character_, "NA", fixed=TRUE),
    list(structure(NA_integer_, match.length=NA_integer_)),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    gregexpr(NA_character_, "NA", fixed=FALSE),
    list(structure(NA_integer_, match.length=NA_integer_)),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    gregexpr(c("a", "b"), c("aa", "b", "A"), fixed=TRUE, ignore.case=TRUE),
    better=P(
        list(
            structure(c(1L, 2L), match.length=c(1L, 1L)),
            structure(c(1L), match.length=c(1L)),
            structure(c(1L), match.length=c(1L))
        ),
        warning=TRUE
    ),
    P(
        list(
            structure(c(1L, 2L), match.length=c(1L, 1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        warning=TRUE
    )
)

E(
    gregexpr(c("a", "b"), c("aa", "b", "A"), fixed=FALSE, ignore.case=TRUE),
    better=P(
        list(
            structure(c(1L, 2L), match.length=c(1L, 1L)),
            structure(c(1L), match.length=c(1L)),
            structure(c(1L), match.length=c(1L))
        ),
        warning=TRUE
    ),
    P(
        list(
            structure(c(1L, 2L), match.length=c(1L, 1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(1L), match.length=c(1L))
        ),
        warning=TRUE
    )
)

E(
    gregexpr("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1"), fixed=TRUE),
    structure(
        list(
            structure(c(1L), match.length=c(3L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        names=c("a", "b"),
        attrib1="value1"
    ),
    bad=list(
        structure(c(1L), match.length=c(3L)),
        structure(c(-1L), match.length=c(-1L))
    )
)

E(
    gregexpr("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1")),
    structure(
        list(
            structure(c(1L), match.length=c(3L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        names=c("a", "b"),
        attrib1="value1"
    ),
    bad=list(
        structure(c(1L), match.length=c(3L)),
        structure(c(-1L), match.length=c(-1L))
    )
)



################################################################################
## regexec

E(
    regexec("aba", character(0), fixed=TRUE),
    list()
)

E(
    regexec("aba", character(0), fixed=FALSE),
    list()
)

E(
    regexec("aba", c("ab\u0105", "babababa", NA), fixed=TRUE),
    list(
        structure(c(-1L), match.length=c(-1L)),
        structure(c(2L), match.length=c(3L)),
        structure(c(NA_integer_), match.length=c(NA_integer_))
    )
)

E(
    regexec("aba", c("ab\u0105", "babababa", NA)),
    list(
        structure(c(-1L), match.length=c(-1L)),
        structure(c(2L), match.length=c(3L)),
        structure(c(NA_integer_), match.length=c(NA_integer_))
    )
)

E(
    regexec("(?<x>ab)(?<y>a)", c("ab\u0105", "babababa", NA), perl=TRUE),
    better=P(
        list(
            structure(c(-1L, x=-1L, y=-1L), match.length=c(-1L, x=-1L, y=-1L)),
            structure(c(2L, x=2L, y=4L), match.length=c(3L, x=2L, y=1L)),
            structure(c(NA_integer_, x=NA_integer_, y=NA_integer_), match.length=c(NA_integer_, x=NA_integer_, y=NA_integer_))
        ),
        warning=NA  # argument `perl` has no effect in stringx  (ignore)
    ),
    worse=list(
        structure(c(-1L), match.length=c(-1L)),
        structure(c(2L, x=2L, y=4L), match.length=c(3L, 2L, 1L)),
        structure(c(NA_integer_), match.length=c(NA_integer_))
    )
)

E(
    regexec(NA_character_, "NA", fixed=TRUE),
    list(structure(NA_integer_, match.length=NA_integer_)),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    regexec(NA_character_, "NA", fixed=FALSE),
    list(structure(NA_integer_, match.length=NA_integer_)),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    regexec(c("a", "b"), c("aa", "b", "A"), fixed=TRUE, ignore.case=TRUE),
    better=P(
        list(
            structure(c(1L), match.length=c(1L)),
            structure(c(1L), match.length=c(1L)),
            structure(c(1L), match.length=c(1L))
        ),
        warning=TRUE
    ),
    P(
        list(
            structure(c(1L), match.length=c(1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        warning=TRUE
    )
)

E(
    regexec(c("a", "b"), c("aa", "b", "A"), fixed=FALSE, ignore.case=TRUE),
    better=P(
        list(
            structure(c(1L), match.length=c(1L)),
            structure(c(1L), match.length=c(1L)),
            structure(c(1L), match.length=c(1L))
        ),
        warning=TRUE
    ),
    P(
        list(
            structure(c(1L), match.length=c(1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(1L), match.length=c(1L))
        ),
        warning=TRUE
    )
)

E(
    regexec(c("(?<x>a)(?<y>a)?", "(?<u>b)(?<v>b)(?<w>b)"), c("aaa", "1bbb2bbb3", "a", "bb", NA), perl=TRUE),
    better=P(
        list(
            structure(c(1L, x=1L, y=2L), match.length=c(2L, x=1L, y=1L)),
            structure(c(2L, u=2L, v=3L, w=4L), match.length=c(3L, u=1L, v=1L, w=1L)),
            structure(c(1L, x=1L, y=-1L), match.length=c(1L, x=1L, y=-1L)),
            structure(c(-1L, u=-1L, v=-1L, w=-1L), match.length=c(-1L, u=-1L, v=-1L, w=-1L)),
            structure(c(NA_integer_, x=NA_integer_, y=NA_integer_), match.length=c(NA_integer_, x=NA_integer_, y=NA_integer_))
        ),
        warning=NA  # argument `perl` has no effect in stringx, longer object length is not a multiple of shorter object length
    ),
    P(
        list(
            structure(c(1L, x=1L, y=2L), match.length=c(2L, x=1L, y=1L)),
            structure(c(-1L, x=-1L, y=-1L), match.length=c(-1L, x=-1L, y=-1L)),
            structure(c(1L, x=1L, y=-1L), match.length=c(1L, x=1L, y=-1L)),
            structure(c(-1L, x=-1L, y=-1L), match.length=c(-1L, x=-1L, y=-1L)),
            structure(c(NA_integer_, x=NA_integer_, y=NA_integer_), match.length=c(NA_integer_, x=NA_integer_, y=NA_integer_))
        ),
        warning=TRUE
    ),
    worse=P(
        list(
            structure(c(1L, x=1L, y=2L), match.length=c(2L, 1L, 1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(1L, x=1L, y=0L), match.length=c(1L, 1L, 0L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(NA_integer_), match.length=c(NA_integer_))
        ),
        warning=TRUE
    )
)

E(
    regexec("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1"), fixed=TRUE),
    structure(
        list(
            structure(c(1L), match.length=c(3L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        names=c("a", "b"),
        attrib1="value1"
    ),
    bad=list(
        structure(c(1L), match.length=c(3L)),
        structure(c(-1L), match.length=c(-1L))
    )
)

E(
    regexec("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1")),
    structure(
        list(
            structure(c(1L), match.length=c(3L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        names=c("a", "b"),
        attrib1="value1"
    ),
    bad=list(
        structure(c(1L), match.length=c(3L)),
        structure(c(-1L), match.length=c(-1L))
    )
)



################################################################################
## gregexec

E(
    gregexec("aba", character(0), fixed=TRUE),
    list()
)

E(
    gregexec("aba", character(0), fixed=FALSE),
    list()
)

E(
    gregexec("aba", c("ab\u0105", "babababa", NA), fixed=TRUE),
    better=list(
        structure(c(-1L), match.length=structure(c(-1L), dim=c(1L, 1L)), dim=c(1L, 1L)),
        structure(c(2L, 6L), match.length=structure(c(3L, 3L), dim=c(1L, 2L)), dim=c(1L, 2L)),
        structure(c(NA_integer_), match.length=structure(c(NA_integer_), dim=c(1L, 1L)), dim=c(1L, 1L))
    ),
    list(
        structure(c(-1L), match.length=c(-1L)),
        structure(c(2L, 6L), match.length=structure(c(3L, 3L), dim=c(1L, 2L)), dim=c(1L, 2L)),
        structure(c(NA_integer_), match.length=c(NA_integer_))
    )
)

E(
    gregexec("aba", c("ab\u0105", "babababa", NA)),
    better=list(
        structure(c(-1L), match.length=structure(c(-1L), dim=c(1L, 1L)), dim=c(1L, 1L)),
        structure(c(2L, 6L), match.length=structure(c(3L, 3L), dim=c(1L, 2L)), dim=c(1L, 2L)),
        structure(c(NA_integer_), match.length=structure(c(NA_integer_), dim=c(1L, 1L)), dim=c(1L, 1L))
    ),
    list(
        structure(c(-1L), match.length=c(-1L)),
        structure(c(2L, 6L), match.length=structure(c(3L, 3L), dim=c(1L, 2L)), dim=c(1L, 2L)),
        structure(c(NA_integer_), match.length=c(NA_integer_))
    )
)

E(
    gregexec("(?<x>ab)(?<y>a)", c("ab\u0105", "babababa", NA), perl=TRUE),
    better=P(
        list(
            structure(cbind(c(-1L, x=-1L, y=-1L)), match.length=cbind(c(-1L, x=-1L, y=-1L))),
            structure(cbind(c(2L, x=2L, y=4L), c(6L, x=6L, y=8L)), match.length=cbind(c(3L, x=2L, y=1L), c(3L, x=2L, y=1L))),
            structure(cbind(c(NA_integer_, x=NA_integer_, y=NA_integer_)), match.length=cbind(c(NA_integer_, x=NA_integer_, y=NA_integer_)))
        ),
        warning=NA  # argument `perl` has no effect in stringx  (ignore)
    ),
    P(
        list(
            structure(c(-1L), match.length=c(-1L)),
            structure(cbind(c(2L, x=2L, y=4L), c(6L, x=6L, y=8L)), match.length=cbind(c(3L, x=2L, y=1L), c(3L, x=2L, y=1L))),
            structure(c(NA_integer_), match.length=c(NA_integer_))
        )
    )
)

E(
    gregexec(NA_character_, "NA", fixed=TRUE),
    list(structure(cbind(NA_integer_), match.length=cbind(NA_integer_))),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    gregexec(NA_character_, "NA", fixed=FALSE),
    list(structure(cbind(NA_integer_), match.length=cbind(NA_integer_))),
    bad=P(error=TRUE)  # grepl gives NA
)

E(
    gregexec(c("a", "b"), c("aa", "b", "A"), fixed=TRUE, ignore.case=TRUE),
    better=P(
        list(
            structure(cbind(1L, 2L), match.length=cbind(1L, 1L)),
            structure(cbind(1L), match.length=cbind(1L)),
            structure(cbind(1L), match.length=cbind(1L))
        ),
        warning=TRUE
    ),
    P(
        list(
            structure(cbind(1L, 2L),  match.length=cbind(1L, 1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        warning=TRUE  # this actually generates 8 warnings...
    )
)

E(
    gregexec(c("a", "b"), c("aa", "b", "A"), fixed=FALSE, ignore.case=TRUE),
    better=P(
        list(
            structure(cbind(1L, 2L), match.length=cbind(1L, 1L)),
            structure(cbind(1L), match.length=cbind(1L)),
            structure(cbind(1L), match.length=cbind(1L))
        ),
        warning=TRUE
    ),
    P(
        list(
            structure(cbind(1L, 2L), match.length=cbind(1L, 1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(cbind(1L),  match.length=cbind(1L))
        ),
        warning=TRUE  # this actually generates 4 warnings...
    )
)

E(
    gregexec(c("(?<x>a)(?<y>a)?", "(?<u>b)(?<v>b)(?<w>b)"), c("aaa", "1bbb2bbb3", "a", "bb", NA), perl=TRUE),
    better=P(
        list(
            structure(cbind(c(1L, x=1L, y=2L), c(3L, x=3L, y=-1L)),            match.length=cbind(c(2L, x=1L, y=1L), c(1L, x=1L, y=-1L))),
            structure(cbind(c(2L, u=2L, v=3L, w=4L), c(6L, u=6L, v=7L, w=8L)), match.length=cbind(c(3L, u=1L, v=1L, w=1L), c(3L, u=1L, v=1L, w=1L))),
            structure(cbind(c(1L, x=1L, y=-1L)),                               match.length=cbind(c(1L, x=1L, y=-1L))),
            structure(cbind(c(-1L, u=-1L, v=-1L, w=-1L)),                      match.length=cbind(c(-1L, u=-1L, v=-1L, w=-1L))),
            structure(cbind(c(NA_integer_, x=NA_integer_, y=NA_integer_)),     match.length=cbind(c(NA_integer_, x=NA_integer_, y=NA_integer_)))
        ),
        warning=TRUE  # argument `perl` has no effect in stringx, longer object length is not a multiple of shorter object length
    ),
    P(
        list(
            structure(cbind(c(1L, x=1L, y=2L), c(3L, x=3L, y=0L)),         match.length=cbind(c(2L, x=1L, y=1L), c(1L, x=1L, y=0L))),
            structure(cbind(c(-1L, x=-1L, y=-1L)),                         match.length=cbind(c(-1L, x=-1L, y=-1L))),
            structure(cbind(c(1L, x=1L, y=-1L)),                           match.length=cbind(c(1L, x=1L, y=-1L))),
            structure(cbind(c(-1L, x=-1L, y=-1L)),                         match.length=cbind(c(-1L, x=-1L, y=-1L))),
            structure(cbind(c(NA_integer_, x=NA_integer_, y=NA_integer_)), match.length=cbind(c(NA_integer_, x=NA_integer_, y=NA_integer_)))
        ),
        warning=TRUE
    ),
    worse=P(
        list(
            structure(cbind(c(1L, x=1L, y=2L), c(3L, x=3L, y=0L)), match.length=cbind(c(2L, 1L, 1L), c(1L, x=1L, y=0L))),
            structure((c(-1L)),            match.length=(c(-1L))),
            structure(cbind(c(1L, x=1L, y=0L)), match.length=cbind(c(1L, x=1L, y=0L))),
            structure((c(-1L)),            match.length=(c(-1L))),
            structure((c(NA_integer_)),    match.length=(c(NA_integer_)))
        ),
        warning=TRUE
    )
)

E(
    gregexec("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1"), fixed=TRUE),
    structure(
        list(
            structure(cbind(1L),  match.length=cbind(3L)),
            structure(cbind(-1L), match.length=cbind(-1L))
        ),
        names=c("a", "b"),
        attrib1="value1"
    ),
    bad=list(
        structure(cbind(1L),  match.length=cbind(3L)),
        structure(c(-1L), match.length=c(-1L))
    )
)

E(
    gregexec("aaa", structure(c(a="aaa", b="bbb"), attrib1="value1")),
    structure(
        list(
            structure(cbind(1L),  match.length=cbind(3L)),
            structure(cbind(-1L), match.length=cbind(-1L))
        ),
        names=c("a", "b"),
        attrib1="value1"
    ),
    bad=list(
        structure(cbind(1L),  match.length=cbind(3L)),
        structure(c(-1L), match.length=c(-1L))
    )
)


################################################################################
## realtest: reset to the default comparer

# grep("(?<a>.)(\\k<a>)", c("aa", "ab", "bb"), perl=TRUE)

options(realtest_value_comparer=NULL)
