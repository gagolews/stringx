x <- c("mario", "Mario M\u00E1rio M\u00C1RIO Mar\u00EDa Marios", "Rosario", NA)


regextr2(x, "mario", ignore_case=TRUE, fixed=TRUE)
gregextr2(x, "mario", ignore_case=TRUE, fixed=TRUE)

regextr2(x, "mario", fixed=NA, strength=1L)
gregextr2(x, "mario", fixed=NA, strength=1L)

regextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE)
gregextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE)

regextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE, capture_groups=TRUE)
gregextr2(x, "m(?<a>[a\u00E1])rio(?<plural>s)?", ignore_case=TRUE, capture_groups=TRUE)

regextr2(x, "mario", fixed=NA, strength=1L, capture_groups=TRUE)
gregextr2(x, "mario", fixed=NA, strength=1L, capture_groups=TRUE)

`regextr2<-`(x, "[mM]\\w+", value="x")

`regextr2<-`(x, "[mM]\\w+", value=LETTERS[1:5])  # ?????

`gregextr2<-`(x, "[mM]\\w+", value="x")  # ??????

`gregextr2<-`(x, "[mM]\\w+", value=LETTERS[1:5])  # ??????

`gregextr2<-`(x, "[mM]\\w+", value=list(LETTERS[1:5]))  # ??????

# TODO: simplify arg?

# TODO: no matches - what does strcapture and regmatches do??

# TODO: empty vectors

# TODO: attributes

# TODO: replacement versions

