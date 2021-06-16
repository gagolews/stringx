E(gsub2("abca", "a", "x"), "xbcx")
E(sub2("abca", "a", "x"), "xbca")

x <- "abcdefghijklmnopqrstuvwxyz"
p <- "(?<first>.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(?<last>.)"
E(sub2(x, p, "${first}${last}"), "amnopqrstuvwxyz")
E(gsub2(x, p, "${first}${last}"), "amnz")


E(gsub("(.*)", "\\1", "(.*)", fixed=NA), "\\1")
E(sub("(.*)", "\\1", "(.*)", fixed=NA), "\\1")


E(gsub("(.*)", "\\1", "(.*)", fixed=FALSE), "\\1")
E(sub("(.*)", "\\1", "(.*)", fixed=FALSE), "\\1")

x <- c("mario", "Mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario", NA)
stringx::sub2(x, "mario", "M\u00E1rio", fixed=NA, strength=1L)
stringx::sub2(x, "mario", "Mario", fixed=NA, strength=2L)
