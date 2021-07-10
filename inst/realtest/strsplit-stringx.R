E(strsplit("aaa", character(0), fixed=NA), list(), bad=list(c("a", "a", "a")))
E(strsplit(character(0), "aaa", fixed=NA), list())
E(strsplit("aaa", NA, fixed=NA), list(NA_character_), bad=list("aaa"))
E(strsplit("aaa", NA_character_, fixed=NA), list(NA_character_), bad=list("aaa"))
E(strsplit(NA, "aaa", fixed=NA), list(NA_character_), bad=P(error=TRUE))
E(strsplit(NA_character_, "aaa", fixed=NA), list(NA_character_), bad=P(error=TRUE))

E(strsplit("123a456", "A", fixed=NA), list("123a456"))
E(strsplit("123a456", "A", fixed=NA, ignore_case=TRUE), list(c("123", "456")))

E(strsplit("123a456", "\u00E1", fixed=NA), list("123a456"))
E(strsplit("123a456", "\u00E1", fixed=NA, strength=1L), list(c("123", "456")))

E(strsplit(",,,,a,,,b,,,", ",", omit_empty=TRUE), list(c("a", "b")))
