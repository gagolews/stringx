t <- structure(ISOdatetime(2021, 05, 27, 12, 0, 0), names="t")  # default time zone

# different calendar/locale - easy with stringx:

E(
    strftime(t, "%Y", locale="@calendar=hebrew"),
    c(t="5781")
)

E(
    strftime(t, "%A", locale="pl-PL"),
    c(t="czwartek")
)

E(
    strftime(t, "%A", locale="de-DE"),
    c(t="Donnerstag")
)


t <- structure(ISOdatetime(2021, 05, 27, 12, 0, 0, tz="GMT"), names="t")

E(
    strftime(t, "%H:%M:%S", tz="UTC", usetz=TRUE),
    P(c(t="12:00:00"), warning=TRUE)
)

E(
    strftime(t, "%H:%M:%S", tz="Europe/Berlin"),
    c(t="14:00:00")
)

f <- structure(c(x="%Y-%d%m", y="%d%m-%Y"), attrib1="val1")
x <- structure(c(a="1603-1502"), attrib2="val2")
E(
    attr(strptime(x, f, tz="UTC"), "tzone"),
    "UTC"
)

E(
    strftime(strptime(x, f, tz="UTC"), "%Y"),
    better=`attributes<-`(c("1603", "1502"), attributes(f)),
    `attributes<-`(c("1603", "1502"), list(names=names(f)))
)

x <- structure(c(a="1603-1502", b="1602-1502"), attrib2="val2")
E(
    strftime(strptime(x, "%Y-%d%m", tz="UTC"), "%Y"),
    better=`attributes<-`(c("1603", "1602"), attributes(x)),
    `attributes<-`(c("1603", "1602"), list(names=names(x)))
)
