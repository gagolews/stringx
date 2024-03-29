x <- c("mario", "Mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario", NA)
E(startsWith(x, "mario"), c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA))
E(endsWith(x, "mario"), c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA))

E(startsWith(x, "mario", fixed=NA), c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA))
E(endsWith(x, "mario", fixed=NA), c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA))

E(startsWith(x, "mario", ignore_case=TRUE), c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA))
E(endsWith(x, "mario", ignore_case=TRUE), c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA))

E(
    startsWith(x, "mario", fixed=NA, ignore_case=TRUE),
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA),
    bad=c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)  # C locale
)

E(
    endsWith(x, "mario", fixed=NA, ignore_case=TRUE),
    c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, NA),
    bad=c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)  # C locale
)

E(
    startsWith(x, "mario", fixed=NA, strength=1L),
    c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, NA),
    bad=c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)  # C locale
)

E(
    endsWith(x, "mario", fixed=NA, strength=1L),
    c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, NA),
    bad=c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, NA)  # C locale
)
