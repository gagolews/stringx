
# grep("(?<a>.)(\\k<a>)", c("aa", "ab", "bb"), perl=TRUE)
#

regexpr("aba", c("ab\u0105", "babababa", NA), fixed=TRUE)
regexec("aba", c("ab\u0105", "babababa", NA), fixed=TRUE)

gregexpr("aba", c("ab\u0105", "babababa", NA), fixed=TRUE)
gregexec("aba", c("ab\u0105", "babababa", NA), fixed=TRUE)

regexpr("(ab)(a)", c("ab\u0105", "babababa", NA))
regexec("(ab)(a)", c("ab\u0105", "babababa", NA))

gregexpr("(ab)(a)", c("ab\u0105", "babababa", NA))
gregexec("(ab)(a)", c("ab\u0105", "babababa", NA))

