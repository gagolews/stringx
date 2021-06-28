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
