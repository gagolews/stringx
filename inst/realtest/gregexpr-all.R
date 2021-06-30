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
        warning="longer object length is not a multiple of shorter object length"
    ),
    P(
        structure(c(1L, -1L, -1L), match.length=c(1L, -1L, -1L)),
        warning=c(
            "argument 'ignore.case = TRUE' will be ignored",
            "argument 'pattern' has length > 1 and only the first element will be used"
        )
    )
)

E(
    regexpr(c("a", "b"), c("aa", "b", "A"), fixed=FALSE, ignore.case=TRUE),
    better=P(
        structure(c(1L, 1L, 1L), match.length=c(1L, 1L, 1L)),
        warning="longer object length is not a multiple of shorter object length"
    ),
    P(
        structure(c(1L, -1L, 1L), match.length=c(1L, -1L, 1L)),
        warning="argument 'pattern' has length > 1 and only the first element will be used"
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
        warning="longer object length is not a multiple of shorter object length"
    ),
    P(
        list(
            structure(c(1L, 2L), match.length=c(1L, 1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(-1L), match.length=c(-1L))
        ),
        warning=c(
            "argument 'ignore.case = TRUE' will be ignored",
            "argument 'pattern' has length > 1 and only the first element will be used"
        )
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
        warning="longer object length is not a multiple of shorter object length"
    ),
    P(
        list(
            structure(c(1L, 2L), match.length=c(1L, 1L)),
            structure(c(-1L), match.length=c(-1L)),
            structure(c(1L), match.length=c(1L))
        ),
        warning=c(
            "argument 'pattern' has length > 1 and only the first element will be used"
        )
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




################################################################################
## gregexec

#gregexec(c("azabaz", "a", "az", "b", NA), pattern="(a)(z)?")
#regexec(c("azabaz", "a", "az", "b", NA), pattern="(a)(z)?")
# grep("(?<a>.)(\\k<a>)", c("aa", "ab", "bb"), perl=TRUE)
#


################################################################################
## realtest: reset to the default comparer

options(realtest_value_comparer=NULL)
