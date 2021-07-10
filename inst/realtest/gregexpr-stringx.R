x <- c("mario", "Mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario", NA)

E(
    regexpr2(x, "mario")!=-1L,
    c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    regexpr2(x, "mario", fixed=NA)!=-1L,
    c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    regexpr2(x, "mario", ignore_case=TRUE)!=-1L,
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    regexpr2(x, "mario", fixed=NA, ignore_case=TRUE)!=-1L,
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    regexpr2(x, "mario", fixed=NA, strength=1L)!=-1L,
    c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, NA)
)


E(
    unlist(gregexpr2(x, "mario"))!=-1L,
    c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    unlist(gregexpr2(x, "mario", fixed=NA))!=-1L,
    c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    unlist(gregexpr2(x, "mario", ignore_case=TRUE))!=-1L,
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    unlist(gregexpr2(x, "mario", fixed=NA, ignore_case=TRUE))!=-1L,
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    unlist(gregexpr2(x, "mario", fixed=NA, strength=1L))!=-1L,
    c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, NA)
)

E(
    unlist(regexec2(x, "mario", fixed=NA, ignore_case=TRUE))!=-1L,
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    unlist(regexec2(x, "mario", fixed=NA, strength=1L))!=-1L,
    c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, NA)
)

E(
    unlist(gregexec2(x, "mario", fixed=NA, ignore_case=TRUE))!=-1L,
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA)
)

E(
    unlist(gregexec2(x, "mario", fixed=NA, strength=1L))!=-1L,
    c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, NA)
)
