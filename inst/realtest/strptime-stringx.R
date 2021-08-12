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


# Testing date conversion in different timezones
times <- list(
    ISOdate(1970, 1, 1),  # POSIXct
    "1970-01-01",
    as.POSIXlt(ISOdate(1970, 1, 1)),
    as.POSIXlt("1970-01-01"),
    as.Date("1970-01-01"),
    as.POSIXlt(as.Date("1970-01-01")),
    ISOdatetime(1970, 1, 1, 12, 0, 0),  # POSIXct
    ISOdatetime(1970, 1, 1, 23, 59, 59),
    ISOdatetime(1970, 1, 1, 0, 0, 0),
    base::strptime("1970-01-01 12:00:00", "%Y-%M-%D %h:%m:%s"),  # POSIXlt
    base::strptime("1970-01-01 23:59:59", "%Y-%M-%D %h:%m:%s"),
    base::strptime("1970-01-01 00:00:00", "%Y-%M-%D %h:%m:%s"),
    "1970-01-01 12:00:00",
    "1970-01-01 23:59:59",
    "1970-01-01 00:00:00"
)
oldtz <- stringi::stri_timezone_get()

stringi::stri_timezone_set("Etc/GMT-14")
for (time in times)
    E(strftime(time, "%Y-%m-%d"), "1970-01-01")

stringi::stri_timezone_set("Etc/GMT+12")
for (time in times)
    E(strftime(time, "%Y-%m-%d"), "1970-01-01")

stringi::stri_timezone_set("UTC")
for (time in times)
    E(strftime(time, "%Y-%m-%d"), "1970-01-01")

stringi::stri_timezone_set("Australia/Melbourne")
for (time in times)
    E(strftime(time, "%Y-%m-%d"), "1970-01-01")

stringi::stri_timezone_set("Europe/Warsaw")
for (time in times)
    E(strftime(time, "%Y-%m-%d"), "1970-01-01")

stringi::stri_timezone_set("America/Montreal")
for (time in times)
    E(strftime(time, "%Y-%m-%d"), "1970-01-01")


stringi::stri_timezone_set(oldtz)
