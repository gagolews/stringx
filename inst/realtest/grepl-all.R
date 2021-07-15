E(grepl("a{3,3}", "aaa"), TRUE)  # default fixed=FALSE
E(grepl("a{3,3}", "aaa", fixed=FALSE), TRUE)
E(grepl("a{3,3}", "aaa", fixed=TRUE), FALSE)

E(grep("a{3,3}", "aaa"), 1L)  # default fixed=FALSE
E(grep("a{3,3}", "aaa", fixed=FALSE), 1L)
E(grep("a{3,3}", "aaa", fixed=TRUE), integer(0))

E(grep("a{3,3}", "aaa", value=TRUE), "aaa")  # default fixed=FALSE
E(grep("a{3,3}", "aaa", value=TRUE, fixed=FALSE), "aaa")
E(grep("a{3,3}", "aaa", value=TRUE, fixed=TRUE), character(0))


E(grepl(character(0), "a"), better=logical(0), P(error=TRUE))
E(grepl(character(0), "a", fixed=TRUE), better=logical(0), P(error=TRUE))

E(grep(character(0), "a"), better=integer(0), P(error=TRUE))
E(grep(character(0), "a", fixed=TRUE), better=integer(0), P(error=TRUE))

E(grep(character(0), "a", value=TRUE), better=character(0), P(error=TRUE))
E(grep(character(0), "a", value=TRUE, fixed=TRUE), better=character(0), P(error=TRUE))


E(grepl("a", character(0)), logical(0))
E(grepl("a", character(0), fixed=TRUE), logical(0))

E(grep("a", character(0)), integer(0))
E(grep("a", character(0), fixed=TRUE), integer(0))

E(grep("a", character(0), value=TRUE), character(0))
E(grep("a", character(0), value=TRUE, fixed=TRUE), character(0))


E(grepl("NA", NA), NA, bad=FALSE)
E(grepl("NA", NA, fixed=TRUE), NA, bad=FALSE)

E(grep("NA", NA), NA_integer_, better=integer(0))  # hard to say, it's subsetting after all
E(grep("NA", NA, fixed=TRUE), NA_integer_, better=integer(0))

E(grep("NA", NA, value=TRUE), NA_character_, better=character(0))
E(grep("NA", NA, value=TRUE, fixed=TRUE), NA_character_, better=character(0))


E(grepl(NA, "NA"), NA)
E(grepl(NA, "NA", fixed=TRUE), NA)

E(grep(NA, "NA"), NA_integer_, better=integer(0))   # hard to say, it's subsetting after all
E(grep(NA, "NA", fixed=TRUE), NA_integer_, better=integer(0))

E(grep(NA, "NA", value=TRUE), NA_character_, better=character(0))
E(grep(NA, "NA", value=TRUE, fixed=TRUE), NA_character_, better=character(0))


E(grepl("a", c("a", "A", "b")), c(TRUE, FALSE, FALSE))
E(grepl("a", c("a", "A", "b"), fixed=TRUE), c(TRUE, FALSE, FALSE))
E(grepl("a", c("a", "A", "b"), ignore.case=TRUE), c(TRUE, TRUE, FALSE))
E(
    grepl("a", c("a", "A", "b"), ignore.case=TRUE, fixed=TRUE),
    c(TRUE, TRUE, FALSE),
    bad=P(c(TRUE, FALSE, FALSE), warning=TRUE)
)

E(grep("a", c("a", "A", "b")), c(1L))
E(grep("a", c("a", "A", "b"), fixed=TRUE), c(1L))
E(grep("a", c("a", "A", "b"), ignore.case=TRUE), c(1L, 2L))
E(
    grep("a", c("a", "A", "b"), ignore.case=TRUE, fixed=TRUE),
    c(1L, 2L),
    bad=P(c(1L), warning=TRUE)
)

E(grep("a", c("a", "A", "b"), value=TRUE), c("a"))
E(grep("a", c("a", "A", "b"), value=TRUE, fixed=TRUE), c("a"))
E(grep("a", c("a", "A", "b"), value=TRUE, ignore.case=TRUE), c("a", "A"))
E(
    grep("a", c("a", "A", "b"), value=TRUE, ignore.case=TRUE, fixed=TRUE),
    c("a", "A"),
    bad=P(c("a"), warning=TRUE)
)


E(
    grepl(1:2, 1:3),
    better=P(c(TRUE, TRUE, FALSE), warning=TRUE),
    P(c(TRUE, FALSE, FALSE), warning=TRUE)
)
E(
    grepl(1:2, 1:3, fixed=TRUE),
    better=P(c(TRUE, TRUE, FALSE), warning=TRUE),
    P(c(TRUE, FALSE, FALSE), warning=TRUE)
)

E(
    grep(1:2, 1:3),
    better=P(c(1L, 2L), warning=TRUE),
    P(c(1L), warning=TRUE)
)
E(
    grep(1:2, 1:3, fixed=TRUE),
    better=P(c(1L, 2L), warning=TRUE),
    P(c(1L), warning=TRUE)
)

E(
    grep(1:2, 1:3, value=TRUE),
    better=P(c("1", "2"), warning=TRUE),
    P(c("1"), warning=TRUE)
)
E(
    grep(1:2, 1:3, value=TRUE, fixed=TRUE),
    better=P(c("1", "2"), warning=TRUE),
    P(c("1"), warning=TRUE)
)


x <- structure(c(A="a", B="b", C="c"), attrib1="value1")
E(
    grepl("a", x),
    better=`attributes<-`(c(TRUE, FALSE, FALSE), attributes(x)),
    `attributes<-`(c(TRUE, FALSE, FALSE), attributes(x)["names"]),
    bad=c(TRUE, FALSE, FALSE)
)

E(
    grepl("a", x, fixed=TRUE),
    better=`attributes<-`(c(TRUE, FALSE, FALSE), attributes(x)),
    `attributes<-`(c(TRUE, FALSE, FALSE), attributes(x)["names"]),
    bad=c(TRUE, FALSE, FALSE)
)

E(
    grep("a", x),
    better=c(A=1L),
    bad=1L
)

E(
    grep("a", x, fixed=TRUE),
    better=c(A=1L),
    bad=1L
)

E(
    grep("a", x, value=TRUE),
    better=x[1],
    bad=unname(x[1])
)

E(
    grep("a", x, fixed=TRUE, value=TRUE),
    better=x[1],
    bad=unname(x[1])
)
