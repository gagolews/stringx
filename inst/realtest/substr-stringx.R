x <- c("spam, spam, bacon, and spam", "eggs and spam")
E(substr(x, -4), c("spam", "spam"))
E(substr(x, -4, -4), c("s", "s"))
E(substr(x, -4, -5), c("", ""))
E(
    `substr<-`(x, -4, -5, value="spammity "),
    c("spam, spam, bacon, and spammity spam", "eggs and spammity spam")
)

E(substrl(x, -4, 4), c("spam", "spam"))
E(substrl(x, -4, c(-1, 0, 1, 3)), c(NA, "", "s", "spa"))
E(`substrl<-`(x, -4, 0, value="spammity "), c("spam, spam, bacon, and spammity spam", "eggs and spammity spam"))
E(`substrl<-`(x, -4, 2, value="j"), c("spam, spam, bacon, and jam", "eggs and jam"))
E(`substrl<-`(x, -4, -1, value="spammity "), x)

E(gsubstr(x, 1, 4), list("spam", "eggs"))
E(gsubstr(x, c(13, 1), c(17, 4)), list("bacon", "eggs"))
E(gsubstr(x, list(c(13, 1), 1), list(c(17, 4), 4)), list(c("bacon", "spam"), "eggs"))
E(`gsubstr<-`(x, -4, -1, value="buckwheat"), c("spam, spam, bacon, and buckwheat", "eggs and buckwheat"))

x <- c("aaa", "1aa2aaa3", "a", "bb", "\u0105\U0001F64Baaaaaaaa", NA)
p <- c("(?<x>a)(?<y>a)?(?<z>a)?", "a+")
E(substrl(x, regexpr2(x, p)), c("aaa", "aa", "a", NA, "aaa", NA))
E(`substrl<-`(x, regexpr2(x, p), value="!"), c("!", "1!2aaa3", "!", "bb", "\u0105\U0001F64B!aaaaa", NA))
E(gsubstrl(x, gregexpr2(x, p)), list("aaa", c("aa", "aaa"), "a", character(0), c("aaa", "aaa", "aa"), NA_character_))
E(`gsubstrl<-`(x, gregexpr2(x, p), value="!"), c("!", "1!2!3", "!", "bb", "\u0105\U0001F64B!!!", NA))
E(`gsubstrl<-`(x, gregexpr2(x, p), value=list(c("!", "?", "@"))), P(c("!", "1!2?3", "!", "bb", "\u0105\U0001F64B!?@", NA), warning=TRUE))

# gsubstrl(x, regexec2(x, p))
# gsubstrl(x, gregexec2(x, p))
