E(startsWith("ABABA", c("a", "ab", "aba", "baba", NA), ignore.case=TRUE), c(TRUE, TRUE, TRUE, FALSE, NA))
E(endsWith("ABABA", c("a", "ab", "aba", "baba", NA), ignore.case=TRUE), c(TRUE, FALSE, TRUE, TRUE, NA))
