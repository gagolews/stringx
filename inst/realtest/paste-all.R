E(paste(c("a", "b"), c("X", "Y"), sep="-"), c("a-X", "b-Y"))
E(paste(c("a", "b"), c("X", "Y")), c("a X", "b Y"))
E(paste0(c("a", "b"), c("X", "Y")), c("aX", "bY"))
E(paste(c("a", "b"), c("X", "Y"), sep="-", collapse=";"), "a-X;b-Y")
E(paste("a", c("X", "Y"), 1:4, sep="-"), c("a-X-1", "a-Y-2", "a-X-3", "a-Y-4"))

E(
    paste0(1:2, character(0), 1:2, recycle0=TRUE),
    character(0)
)

E(
    paste0(1:2, character(0), 1:2),
    better=character(0),  # recycle0=TRUE should be the default
    c("11", "22")
)

E(paste0(character(0)), character(0))
E(paste0(), character(0))

E(
    paste0(1:2, 1:3),
    P(c("11", "22", "13"), warning=TRUE),
    bad=c("11", "22", "13"),
    .comment="recycling rule warning"
)

E(
    paste0(c(1, NA, 3), "a", collapse=","),
    NA_character_,
    bad="1a,NAa,3a",
    .comment="NA handling"
)

E(
    paste(1, character(0), "a", sep=",", recycle0=FALSE),
    "1,a",
    bad="1,,a"
)

E(
    paste0(1, 2, sep=","),
    "1,2",
    bad="12,"
)

# TODO: paste should preserve attributes?
x <- structure(c(u=""), class="foo", attrib1="val1")
y <- structure(c(a="1", b="2"), class="bar", attrib2="val2")
E(
    paste0(x, y),
    better=y,
    as.character(y)
)
