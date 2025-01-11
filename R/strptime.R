# kate: default-dictionary en_AU

## stringx package for R
## Copyleft (C) 2021-2025, Marek Gagolewski <https://www.gagolewski.com/>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
## GNU General Public License for more details. You have received
## a copy of the GNU General Public License along with this program.




#' @title
#' Parse and Format Date-time Objects
#'
#' @description
#' Note that the date-time processing functions in \pkg{stringx} are a work
#' in progress. Feature requests/comments/remarks are welcome.
#'
#' \code{strptime} parses strings representing date-time data
#' and converts it to a date-time object.
#'
#' \code{strftime} formats a date-time object and outputs it as a
#' character vector.
#'
#' The functions are meant to be compatible with each other,
#' especially with regards to formatting/printing. This is why
#' they return/deal with objects of a new class, \code{POSIXxt}, which
#' expends upon the built-in \code{POSIXct}.
#'
#'
#'
#' @details
#' Note that the ISO 8601 guideline suggests a year-month-day
#' date format and a 24-hour time format always indicating the effective
#' time zone, e.g., \code{2015-12-31T23:59:59+0100}. This is so as to avoid
#' ambiguity.
#'
#' When parsing strings, missing fields are filled based on today's midnight
#' data.
#'
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{strptime}}
#' and \code{\link[base]{strftime}} implemented with
#' \code{\link[stringi]{stri_datetime_parse}} and
#' \code{\link[stringi]{stri_datetime_format}}.
#'
#' \code{format.POSIXxt} is a thin wrapper around \code{strftime}.
#'
#'
#' \itemize{
#' \item formatting/parsing date-time in different locales and calendars
#'     is difficult and non-portable across platforms
#'     \bold{[fixed here -- using services provided by ICU]}
#' \item default format not conforming to ISO 8601, in particular not
#'     displaying the current time zone
#'     \bold{[fixed here]}
#' \item only the names attribute in \code{x} is propagated
#'     \bold{[fixed here]}
#' \item partial recycling with no warning
#'     \bold{[fixed here]}
#' \item \code{strptime} returns an object of class \code{POSIXlt},
#'     which is not the most convenient to work with, e.g., when
#'     including in data frames
#'     \bold{[fixed here]}
#' \item Ideally, there should be only one class to represent dates
#'     and one to represent date/time; \code{POSIXlt}
#'     is no longer needed as we have
#'     \code{\link[stringi]{stri_datetime_fields}};
#'     our new \code{POSIXxt} class aims to solve the underlying problems
#'     with \code{POSIXct}'s not being consistent with regards to
#'     working in different time zones and dates
#'     (see, e.g., \code{as.Date(as.POSIXct(strftime(Sys.Date())))})
#'     \bold{[addressed here]}
#' \item dates without times are not always treated as being at midnight
#'     (despite that being stated in the help page for \code{as.POSIXct})
#'     \bold{[fixed here]}
#' \item \code{strftime} does not honour the \code{tzone} attribute,
#'     which is used whilst displaying time (via \code{\link[base]{format}})
#'     \bold{[fixed here]}
#' }
#'
#'
#' @param x object to be converted: a character vector for \code{strptime}
#'    and \code{as.POSIXxt.character},
#'    an object of class \code{POSIXxt} for \code{strftime}
#'    an object of class \code{Date} for \code{as.POSIXxt.Date},
#'    or objects coercible to
#'
#' @param tz \code{NULL} or \code{''} for the default time zone
#'    (see \code{\link[stringi]{stri_timezone_get}})
#'    or a single string with a timezone identifier,
#'    see \code{\link[stringi]{stri_timezone_list}};
#'    note that when \code{x} is equipped with \code{tzone} attribute,
#'    this datum is used;
#'    \code{as.POSIXxt.character} treats dates as being at midnight local time
#'
#' @param usetz not used (with a warning if attempting to do so) [DEPRECATED]
#'
#' @param ... not used
#'
#' @param format character vector of date-time format specifiers,
#'    see \code{\link[stringi]{stri_datetime_fstr}};
#'    e.g., \code{"\%Y-\%m-\%d"} or \code{"datetime_full"};
#'    the default conforms to the ISO 8601 guideline
#'
#'
#' @param locale \code{NULL} or \code{''} for the default locale
#'    (see \code{\link[stringi]{stri_locale_get}})
#'    or a single string with a locale identifier,
#'    see \code{\link[stringi]{stri_locale_list}}
#'
#' @param lenient single logical value; should date/time parsing be lenient?
#'
#' @param e1,e2,from,to,by,length.out,along.with,recursive
#'    arguments to \code{\link{c}}, \code{\link{rep}}, \code{\link{seq}}, etc.
#'
#'
#'
#' @return
#' \code{strftime} and \code{format} return a character vector (in UTF-8).
#'
#' \code{strptime}, \code{as.POSIXxt.Date},
#' and \code{asPOSIXxt.character} return an object
#' of class \code{POSIXxt}, which
#' extends upon \code{\link[base]{POSIXct}},
#' see also \link[base]{DateTimeClasses}.
#'
#' Subtraction returns an object of the class \code{difftime},
#' see \code{\link[base]{difftime}}.
#'
#'
#' If a string cannot be recognised as valid date/time specifier
#' (as per the given format string), the corresponding output will be \code{NA}.
#'
#'
#' @examples
#' strftime(Sys.time())  # default format - ISO 8601
#' f <- c("date_full", "%Y-%m-%d", "date_relative_short", "datetime_full")
#' strftime(Sys.time(), f)  # current default locale
#' strftime(Sys.time(), f, locale="de_DE")
#' strftime(Sys.time(), "date_short", locale="en_IL@calendar=hebrew")
#' strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S", tz="GMT")
#' strptime("14 Nisan 5703", "date_short", locale="en_IL@calendar=hebrew")
#' as.POSIXxt("1970-01-01")
#' as.POSIXxt("1970/01/01 12:00")
#'
#'
#' @seealso
#' Related function(s): \code{\link{sprintf}}, \code{\link{ISOdatetime}}
#'
#' @aliases POSIXxt
#'
#' @rdname strptime
strptime <- function(x, format, tz="", lenient=FALSE, locale=NULL)
{
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(format)) format <- as.character(format)

    format_icu <- stringi::stri_datetime_fstr(format, ignore_special=FALSE)

    ret <- as.POSIXxt(stringi::stri_datetime_parse(
        x,
        format=format_icu,
        lenient=lenient,
        tz=tz,
        locale=locale
    ))

    # the following is not bullet proof:
    ret_attribs_before <- attributes(ret)
    ret <- .attribs_propagate_binary(ret, x, format)  # `format_icu` has no attribs
    attributes(ret) <- c(attributes(ret), ret_attribs_before)
    ret
}


#' @rdname strptime
strftime <- function(
    x, format="%Y-%m-%dT%H:%M:%S%z", tz=attr(x, "tzone")[1L],
    usetz=FALSE, ..., locale=NULL
) {
    if (!inherits(x, "POSIXxt")) x <- as.POSIXxt(x)  # where is is.POSIXct?
    if (!is.character(format)) format <- as.character(format)

    if (!isFALSE(usetz)) warning("argument `usetz` has no effect in stringx")

    format_icu <- stringi::stri_datetime_fstr(format, ignore_special=FALSE)

    ret <- stringi::stri_datetime_format(
        x,
        format=format_icu,
        tz=tz,
        locale=locale
    )

    # the following is not bullet proof:
    attr(x, "class") <- NULL
    attr(x, "tzone") <- NULL

    .attribs_propagate_binary(ret, x, format)  # `format_icu` has no attribs
}


#' @rdname strptime
format.POSIXxt <- function(
    x, format="%Y-%m-%dT%H:%M:%S%z", tz=attr(x, "tzone")[1L],
    usetz=FALSE, ..., locale=NULL
) {
    # usetz set by print(), we want no warnings
    strftime(x, format=format, tz=tz, usetz=FALSE, ..., locale=locale)
}


#' @rdname strptime
is.POSIXxt <- function(x) inherits(x, "POSIXxt")


#' @rdname strptime
as.POSIXxt <- function(x, tz="", ...) UseMethod("as.POSIXxt")


#' @rdname strptime
as.POSIXxt.POSIXt <- function(x, tz=attr(x, "tzone")[1L], ...)
{
    if (is.POSIXxt(x)) return(x)

    if (inherits(x, "POSIXlt")) {
        x <- unclass(x)
        return(ISOdatetime(
            x[["year"]]+1900L,
            x[["mon"]]+1L,
            x[["mday"]],
            x[["hour"]],
            x[["min"]],
            x[["sec"]],
            tz=tz
        ))
    }
    else {
        if (!inherits(x, "POSIXct")) {
            if (is.null(tz)) tz <- ""
            x <- as.POSIXct(x, tz=tz, ...)
        }

        attr(x, "class") <- c("POSIXxt", attr(x, "class"))
        return(x)
    }
}


#' @rdname strptime
as.POSIXlt.POSIXxt <- function(x, tz=attr(x, "tzone")[1L], ..., locale=NULL)
{
    if (!is.POSIXxt(x)) x <- as.POSIXxt(x)

    zone <- stringi::stri_timezone_info(tz=tz)
    isdst <- as.integer(zone[["UsesDaylightTime"]])
    isdst[is.na(isdst)] <- -1L

    y <- stringi::stri_datetime_fields(x, tz=tz, locale=locale)
    n <- length(y[["Second"]])
    structure(
        list(
            sec=y[["Second"]],
            min=as.integer(y[["Minute"]]),
            hour=as.integer(y[["Hour"]]),
            mday=as.integer(y[["Day"]]),
            mon=as.integer(y[["Month"]]-1L),
            year=structure(as.integer(y[["Year"]]-1900L), names=names(x)),
            wday=as.integer(y[["DayOfWeek"]]-1L),
            yday=as.integer(y[["DayOfYear"]]-1L),
            isdst=rep(isdst, n),
            zone=rep(zone[["Name"]], n),
            gmtoff=rep(zone[["RawOffset"]]*3600, n)
        ),
        tzone=tz,
        class=c("POSIXlt", "POSIXt")
    )
}



#' @rdname strptime
as.POSIXxt.default <- function(x, tz="", ...)
{
    x <- as.POSIXct(x, tz=tz, ...)
    attr(x, "class") <- c("POSIXxt", attr(x, "class"))
    x
}


#' @rdname strptime
as.Date.POSIXxt <- function(x, ...)
{
    if (!is.POSIXxt(x)) x <- as.POSIXxt(x)

    x_date_str <- strftime(x, "%Y-%m-%d")
    x_utc <- strptime(paste0(x_date_str, " 00:00:00"), "%Y-%m-%d %H:%M:%S", tz="UTC")

    structure(
        `attributes<-`(
            floor(unclass(x_utc)/86400),
            attributes(x)
        ),
        class="Date",
        tzone=NULL
    )
}


#' @rdname strptime
as.POSIXxt.Date <- function(x, ...)
{
    if (!inherits(x, "Date")) x <- as.Date(x)

    x_time_utc <- structure(unclass(x) * 86400, class=c("POSIXxt", "POSIXct", "POSIXt"), tzone="UTC")

    ret <- strptime(
        paste0(strftime(x_time_utc, "%Y-%m-%d"), " 00:00:00"),
        "%Y-%m-%d %H:%M:%S"
    )

    `attributes<-`(floor(unclass(ret)), attributes(ret))
}


#' @rdname strptime
as.POSIXxt.character <- function(
    x,
    tz="",
    format=NULL,
    ...,
    lenient=FALSE,
    locale=NULL
) {
    if (!is.null(format))
        return(strptime(x, format=format, tz=tz, lenient=lenient, locale=locale))

    if (!is.character(x)) x <- as.character(x)


    na_before <- is.na(x)

    ret <- strptime(x, format="%Y-%m-%dT%H:%M:%S%z", tz=tz, lenient=lenient, locale=locale)
    if (all(is.na(ret) == na_before)) return(ret)

    for (fmt in c("%Y-%m-%d %H:%M:%S", "%Y/%m/%d %H:%M:%S")) {
        for (suffix in c("", ":00", ":00:00", " 00:00:00")) {
            ret <- strptime(
                paste0(x, suffix),
                format=fmt,
                tz=tz,
                lenient=lenient,
                locale=locale
            )
            if (all(is.na(ret) == na_before))
                return(ret)
        }
    }
}


#' @rdname strptime
Ops.POSIXxt <- function(e1, e2) {
    if (.Generic == "+")
        as.POSIXxt(NextMethod(.Generic))
    else
        NextMethod(.Generic)
}


#' @rdname strptime
seq.POSIXxt <- function(
    from, to, by, length.out = NULL, along.with = NULL, ...
) {
    as.POSIXxt(NextMethod(.Generic))
}


#' @rdname strptime
c.POSIXxt <- function(..., recursive = FALSE) {
    as.POSIXxt(NextMethod(.Generic))
}


#' @rdname strptime
rep.POSIXxt <- function(..., recursive = FALSE) {
    as.POSIXxt(NextMethod(.Generic))
}
