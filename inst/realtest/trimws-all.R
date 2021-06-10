# sanity checks, empty vectors, NA propagation, recycling rule, coercion:

E(trimws(character(0)), character(0))

x <- c("    ", "", NA_character_, "a", "   a  ", "   a", "a  ")
E(trimws(x), c("", "", NA_character_, "a", "a", "a", "a"))
E(trimws(x, which="both"),  c("", "", NA_character_, "a", "a", "a", "a"))
E(trimws(x, which="left"),  c("", "", NA_character_, "a", "a  ", "a", "a  "))
E(trimws(x, which="right"), c("", "", NA_character_, "a", "   a", "   a", "a"))
E(trimws(x, which="bottom"), P(error=TRUE))
E(trimws(x, whitespace=" "), c("", "", NA_character_, "a", "a", "a", "a"))
E(trimws("ababab", whitespace="ab"), "", P(error=TRUE), bad="ab")
E(trimws("abbbbbbababbbbbb", whitespace="ab"), "", P(error=TRUE), bad="ab")
E(trimws(x, whitespace="[wrong]+++"), better=x, better=P(error=TRUE), P(error=TRUE, warning=TRUE))
E(trimws(x, whitespace="[ ]"), c("", "", NA_character_, "a", "a", "a", "a"))
E(trimws(x, whitespace="[a ]"), c("", "", NA_character_, "", "", "", ""))
E(trimws("NAAAAAAAA!!!", "both", NA), P(error=TRUE), bad="!!!")

x <- "   :)\v\u00a0 \n\r\t"
E(trimws(x), ":)", bad=":)\v\u00a0")

x0 <- c("a", NA, "c")  # attribs from x and y (x preferred)
x <- structure(x0, names=c("A", "B", "C"), attrib1="value1")
E(
    trimws(x),
    x,
    .comment="attribute preservation"
)
