E(strptime(character(0), "%Y-%m-%d"),
    structure(as.POSIXct(c()), class=c("POSIXxt", "POSIXct", "POSIXt")),
    structure(as.POSIXct(c()), class=c("POSIXxt", "POSIXct", "POSIXt"), tzone=""),
    as.POSIXct(c()),
    as.POSIXlt(c()),
    value_comparer=all.equal  # storage mode may be 'double' or 'integer'
)

E(strftime(strptime(NA_character_, "%Y-%m-%d")), NA_character_)

E(
    strptime("1970-01-01", character(0)),
    structure(as.POSIXct(c()), class=c("POSIXxt", "POSIXct", "POSIXt")),
    structure(as.POSIXct(c()), class=c("POSIXxt", "POSIXct", "POSIXt"), tzone=""),
    as.POSIXct(c()),
    as.POSIXlt(c()),
    bad=P(error=TRUE),
    value_comparer=all.equal  # storage mode may be 'double' or 'integer'
)

E(strftime(strptime("1970-01-01", NA_character_)), NA_character_)

E(strptime("2020-01-01 12:23:54"), P(error=TRUE))
E(
    as.integer(as.POSIXct(strptime(
        "1970-01-01 00:00:00",
        c("%Y-%m-%d %H:%M:%S", "%Y-%m-%d", "%b"),
        tz="UTC"
    ))),
    c(0L, 0L, NA_integer_),
    value_comparer=all.equal  # storage mode may be 'double' or 'integer'
)

E(
    class(strptime("1970-01-01", "%Y-%m-%d")),
    better=c("POSIXxt", "POSIXct", "POSIXt"),
    better=c("POSIXct", "POSIXt"),
    c("POSIXlt", "POSIXt")
)

E(
    strftime(strptime(c("1905-1806", "1704-1603", "1502-1401"), c("%Y-%d%m", "%d%m-%Y")), "%Y-%m-%d"),
    P(c("1905-06-18", "1603-04-17", "1502-01-14"), warning=TRUE),
    worst=P(c("--", "--", "--"), warning=TRUE),
    bad=c("1905-06-18", "1603-04-17", "1502-01-14"),
    .comment="recycling rule warning"
)

f <- structure(c(x="%Y-%d%m", y="%d%m-%Y"), class="format", attrib1="val1")
x <- structure(c(a="1603-1502"), attrib2="val2")
E(
    names(strptime(x, f)),
    better=names(f),
    c("a", "a"),
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
E(strftime(c("1970-01-01", NA), "%Y"), c("1970", NA), worst=c("--", NA_character_), worst=c("", NA_character_))
E(strftime(factor(c("1970-01-01", NA)), "%Y"), c("1970", NA), worst=c("--", NA_character_), worst=c("", NA_character_))
E(strftime(c("1970-01-01", NA), c("%Y-%m-%d", "%Y")), c("1970-01-01", NA), worst=c("--", NA_character_))
E(strftime(c("1970-01-01"), c("%Y-%m-%d", "%Y")), c("1970-01-01", "1970"), worst=c("--", ""))

E(
    strftime(c("1970-01-01", "2021-05-26"), c("%Y-%m-%d", "%Y", "%y")),
    P(c("1970-01-01", "2021", "70"), warning=TRUE),
    worst=P(c("--", "", ""), warning=TRUE),
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
    bad="1969-12-31T12:33:41-1200",
    bad="1969-12-31T13:33:41-1100",
    bad="1969-12-31T14:33:41-1000",
    bad="1969-12-31T15:33:41-0900",
    bad="1969-12-31T16:33:41-0800",
    bad="1969-12-31T17:33:41-0700",
    bad="1969-12-31T18:33:41-0600",
    bad="1969-12-31T19:33:41-0500",
    bad="1969-12-31T20:33:41-0400",
    bad="1969-12-31T21:33:41-0300",
    bad="1969-12-31T22:33:41-0200",
    bad="1969-12-31T23:33:41-0100",
    bad="1970-01-01T00:33:41+0000",
    bad="1970-01-01T01:33:41+0100",
    bad="1970-01-01T02:33:41+0200",
    bad="1970-01-01T03:33:41+0300",
    bad="1970-01-01T04:33:41+0400",
    bad="1970-01-01T05:33:41+0500",
    bad="1970-01-01T06:33:41+0600",
    bad="1970-01-01T07:33:41+0700",
    bad="1970-01-01T08:33:41+0800",
    bad="1970-01-01T09:33:41+0900",
    bad="1970-01-01T10:33:41+1000",
    bad="1970-01-01T11:33:41+1100",
    bad="1970-01-01T12:33:41+1200",
    bad="1970-01-01 00:33:41",
    bad="1970-01-01 01:33:41",
    bad="1970-01-01 02:33:41",
    bad="1970-01-01 03:33:41",
    bad="1970-01-01 04:33:41",
    bad="1970-01-01 05:33:41",
    bad="1970-01-01 06:33:41",
    bad="1970-01-01 07:33:41",
    bad="1970-01-01 08:33:41",
    bad="1970-01-01 09:33:41",
    bad="1970-01-01 10:33:41",
    bad="1970-01-01 11:33:41",
    bad="1970-01-01 12:33:41",
    worst="--T::+0100",
    worst="--T::+0000",
    P(error=TRUE),
    .comment="uninformative error message"
)


t <- ISOdatetime(2021, 05, 27, 12, 0, 0)  # default time zone

E(
    strftime(t),
    better=strftime(t, "%Y-%m-%dT%H:%M:%S%z"),
    strftime(t, "%Y-%m-%d %H:%M:%S"),
    worst=strftime(t, "%m/%d/%Y %H:%M:%S"),
    .comment="default format should conform to ISO 8601, in particular display the current time zone"
)

E(
    strftime(t, "%Y-%m-%d"),
    "2021-05-27",
    bad="2021-05-26",
    bad="2021-05-28",
    worst="--"
)

E(
    strftime(as.POSIXlt(t), "%Y-%m-%d"),
    "2021-05-27",
    bad="2021-05-26",
    bad="2021-05-28",
    worst="--"
)

E(
    strftime(as.POSIXct(t), "%Y-%m-%d"),
    "2021-05-27",
    bad="2021-05-26",
    bad="2021-05-28",
    worst="--"
)

E(
    strftime(as.Date(t), "%Y-%m-%d"),
    "2021-05-27",
    bad="2021-05-26",
    bad="2021-05-28",
    worst=NA_character_
)

# only names of x are preserved
f <- structure(c(x="%Y", y="%Y-%m-%d"), class="format", attrib1="val1")
x <- structure(c(a=t), attrib2="val2")
E(
    strftime(x, f),
    better=`attributes<-`(c("2021", "2021-05-27"), attributes(f)),
    structure(c("2021", "2021-05-27"), names=c("a", "a")),
    bad=structure(c("2021", "2021-05-27"), names=c("a", "")),
    bad=structure(c("2021", "2021-05-27"), names=c("a", NA)),
    worst=`attributes<-`(c("", "--"), attributes(f))
)


x <- structure(c(a=t, b=t), attrib2="val2")
E(
    strftime(x, "%Y"),
    structure(c("2021", "2021"), names=names(x), attrib2="val2"),
    bad=c(a="2021", b="2021"),
    worst=structure(c("", ""), names=names(x), attrib2="val2")
)
