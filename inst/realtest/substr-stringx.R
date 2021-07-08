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



x <- c("aaa", "1aa2aaa3", "a", "bb", NA)
substrl(x, regexpr2(x, "(?<x>a)(?<y>a)?(?<z>a)?"))

gsubstrl(x, regexec2(x, "(?<x>a)(?<y>a)?(?<z>a)?"))

gsubstrl(x, gregexec2(x, "(?<x>a)(?<y>a)?(?<z>a)?"))

`substrl<-`(x, regexpr2(x, "(?<x>a)(?<y>a)?(?<z>a)?"), value="xxxxx")

gsubstrl(x, gregexpr2(x, "(?<x>a)(?<y>a)?(?<z>a)?"))

`gsubstrl<-`(x, gregexpr2(x, "(?<x>a)(?<y>a)?(?<z>a)?"), value="xxxxx")


gsubstrl(x[2], gregexec2(x[2], "(?<x>a)(?<y>a)?(?<z>a)?"))

lapply(gregexec2(x[2], "(?<x>a)(?<y>a)?(?<z>a)?"), attr, "match.length")
