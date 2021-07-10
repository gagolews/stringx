E(gsub2("abca", "a", "x"), "xbcx")
E(sub2("abca", "a", "x"), "xbca")

E(gsub2("abca", "A", "x", ignore_case=TRUE), "xbcx")
E(sub2("abca", "A", "x", ignore_case=TRUE), "xbca")

x <- "abcdefghijklmnopqrstuvwxyz"
p <- "(?<first>.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(?<last>.)"
E(sub2(x, p, "${first}${last}"), "amnopqrstuvwxyz")
E(gsub2(x, p, "${first}${last}"), "amnz")

E(gsub("(.*)", "\\1", "(.*)", fixed=NA), "\\1")
E(sub("(.*)", "\\1", "(.*)", fixed=NA), "\\1")

E(gsub("(.*)", "\\1", "(.*)", fixed=TRUE), "\\1")
E(sub("(.*)", "\\1", "(.*)", fixed=TRUE), "\\1")

E(gsub("(.*)", "\\1", "(.*)", fixed=FALSE), "(.*)")
E(sub("(.*)", "\\1", "(.*)", fixed=FALSE), "(.*)")

x <- c("mario", "Mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario", NA)
E(sub2(x, "mario", "X", fixed=NA, strength=1L), `[<-`(x, c(1, 2, 3, 4), "X"))
E(sub2(x, "mario", "X", fixed=NA, strength=2L), `[<-`(x, c(1, 2), "X"))
