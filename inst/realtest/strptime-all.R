E(strptime(character(0), "%Y-%m-%d"),
    as.POSIXct(c()),
    as.POSIXlt(c())
)

E(strftime(strptime(NA_character_, "%Y-%m-%d")), NA_character_)

E(
    strptime("1970-01-01", character(0)),
    as.POSIXct(c()),
    as.POSIXlt(c()),
    bad=P(error=TRUE)
)

E(strftime(strptime("1970-01-01", NA_character_)), NA_character_)

E(strptime("2020-01-01 12:23:54"), P(error=TRUE))
E(
    as.integer(as.POSIXct(strptime(
        "1970-01-01 00:00:00",
        c("%Y-%m-%d %H:%M:%S", "%Y-%m-%d", "%b"),
        tz="UTC"
    ))),
    c(0L, 0L, NA_integer_)
)

E(
    class(strptime("1970-01-01", "%Y-%m-%d")),
    better=c("POSIXct", "POSIXt"),
    c("POSIXlt", "POSIXt")
)

E(
    strftime(strptime(c("1905-1806", "1704-1603", "1502-1401"), c("%Y-%d%m", "%d%m-%Y")), "%Y-%m-%d"),
    P(c("1905-06-18", "1603-04-17", "1502-01-14"), warning=TRUE),
    bad=c("1905-06-18", "1603-04-17", "1502-01-14"),
    .comment="recycling rule warning"
)

f <- structure(c(x="%Y-%d%m", y="%d%m-%Y"), class="format", attrib1="val1")
x <- structure(c(a="1603-1502"), attrib2="val2")
E(
    names(strptime(x, f)),
    names(f),
    bad=c("a", NA)
)


x <- structure(c(a="1603-1502", b="1603-1502"), attrib2="val2")
E(
    names(strptime(x, "%Y-%d%m")),
    names(x)
)


# recycling rule, NA handling:
E(strftime(character(0)), character(0))
E(strftime(NA_character_), NA_character_)
E(strftime(c("1970-01-01", NA), "%Y"), c("1970", NA))
E(strftime(factor(c("1970-01-01", NA)), "%Y"), c("1970", NA))
E(strftime(c("1970-01-01", NA), c("%Y-%m-%d", "%Y")), c("1970-01-01", NA))
E(strftime(c("1970-01-01"), c("%Y-%m-%d", "%Y")), c("1970-01-01", "1970"))

E(
    strftime(c("1970-01-01", "2021-05-26"), c("%Y-%m-%d", "%Y", "%y")),
    P(c("1970-01-01", "2021", "70"), warning=TRUE),
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
    bad=P(error="'origin' must be supplied"),  # more specific - list first - LANGUAGE="en" only though
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

E(
    strftime(as.POSIXlt(t), "%Y-%m-%d"),
    strftime(t, "%Y-%m-%d")
)

E(
    strftime(as.POSIXct(t), "%Y-%m-%d"),
    strftime(t, "%Y-%m-%d")
)

E(
    strftime(as.Date(t), "%Y-%m-%d"),
    strftime(t, "%Y-%m-%d")
)

E(
    strftime(as.character(t), "%Y-%m-%d"),
    strftime(t, "%Y-%m-%d")
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
