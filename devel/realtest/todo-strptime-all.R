# TODO.... strptime........


# recycling rule, NA handling:
E(strftime(character(0)), character(0))
E(strftime(NA_character_), NA_character_)
E(strftime(NA_character_), base::strftime(NA_character_))
E(strftime(c("1970-01-01", NA), "%Y"), c("1970", NA))
E(strftime(factor(c("1970-01-01", NA)), "%Y"), c("1970", NA))
E(strftime(c("1970-01-01", NA), c("%Y-%m-%d", "%Y")), c("1970-01-01", NA))
E(strftime(c("1970-01-01"), c("%Y-%m-%d", "%Y")), c("1970-01-01", "1970"))

E(
    strftime(c("1970-01-01", "2021-05-26"), c("%Y-%m-%d", "%Y", "%y")),
    P(c("1970-01-01", "2021", "70"), warning="longer object length is not a multiple of shorter object length"),
    bad=P(c("1970-01-01", "2021", "70")),
    .comment="recycling rule warning"
)

E(
    strftime(c("1970-01-01"), character(0)),
    character(0),
    bad=P(error=TRUE),
    .comment="empty argument"
)

E(
    strftime(2021),
    bad=P(error="'origin' must be supplied"),
    P(error=TRUE),
    .comment="uninformative error message"
)


t <- ISOdate(2021, 05, 27)

E(
    strftime(t),
    better=strftime(t, "%Y-%m-%dT%H:%M:%S%z"),
    strftime(t, "%Y-%m-%d %H:%M:%S"),
    worst=strftime(t, "%m/%d/%Y %H:%M:%S"),
    .comment="default format should conform to ISO 8601, in particular display the current time zone"
)


# only names of x are preserved
f <- structure(c(x="%Y", y="%Y-%m-%d"), class="format", attrib1="val1")
x <- structure(c(a=t), attrib2="val2")
E(
    strftime(x, f),
    `attributes<-`(c("2021", "2021-05-27"), attributes(f)),
    bad=structure(c("2021", "2021-05-27"), names=c("a", "")),
    bad=structure(c("2021", "2021-05-27"), names=c("a", NA))
)


x <- structure(c(a=t, b=t), attrib2="val2")
E(
    strftime(x, "%Y"),
    structure(c("2021", "2021"), names=names(x), attrib2="val2"),
    bad=c(a="2021", b="2021")
)
