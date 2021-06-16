# kate: default-dictionary en_AU

## stringx package for R
## Copyleft (C) 2021, Marek Gagolewski <https://www.gagolewski.com>
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


# TODO: as.character.POSIXt
# TODO: format.POSIXct
# TODO: format.POSIXt

# TODO: as.character.Date
# TODO: format.Date

# TODO: as.POSIXlt.character
# TODO: as.Date.character

# default to ISO datetime?



#' @title
#' Date-time Parsing and Formatting
#'
#' @description
#' \code{strptime} parses strings representing date-time data
#' and converts it to a date-time object.
#' \code{strftime} formats a date-time object and outputs it as a
#' character vector.
#'
#'
#' @details
#' Note that the ISO 8601 guideline suggests a year-month-day
#' date format and a 24-hour time format always indicating the effective
#' time zone, e.g., \code{2015-12-31T23:59:59+0100}. This is so as to avoid
#' ambiguity.
#'
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{strptime}}
#' and \code{\link[base]{strftime}} implemented with
#' \code{\link[stringi]{stri_datetime_parse}} and
#' \code{\link[stringi]{stri_datetime_format}}.
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
#' \item \code{strftime} does not honour the \code{tzone} attribute,
#'     which is used whilst displaying time (via \code{\link[base]{format}})
#'     \bold{[not fixed here]}
#' }
#'
#'
#' @param x object to be converted: a character vector for \code{strptime}
#'    and an object of class \code{POSIXct} for \code{strftime},
#'    or objects coercible to
#'
#' @param tz \code{NULL} or \code{''} for the default time zone
#'    (see \code{\link[stringi]{stri_timezone_get}})
#'    or a single string with a timezone identifier,
#'    see \code{\link[stringi]{stri_timezone_list}};
#'    note that even when \code{x} is equipped with \code{tzone} attribute,
#'    this datum is not used
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
#' @param locale \code{NULL} or \code{''} for the default locale
#'    (see \code{\link[stringi]{stri_locale_get}})
#'    or a single string with a locale identifier,
#'    see \code{\link[stringi]{stri_locale_list}}
#'
#' @param lenient single logical value; should date/time parsing be lenient?
#'
#'
#' @return
#' \code{strftime} returns a character vector (in UTF-8).
#'
#' \code{strptime} returns an object of class \code{\link[base]{POSIXct}},
#' see also \link[base]{DateTimeClasses}.
#' If a string cannot be recognised as valid date/time specified
#' (as per the given format string), the corresponding output will be \code{NA}.
#'
#'
#' @examples
#' stringx::strftime(Sys.time())  # default format - ISO 8601
#' f <- c("date_full", "%Y-%m-%d", "date_relative_short", "datetime_full")
#' stringx::strftime(Sys.time(), f)  # current default locale
#' stringx::strftime(Sys.time(), f, locale="de_DE")
#' stringx::strftime(Sys.time(), "date_short", locale="en_IL@calendar=hebrew")
#' stringx::strptime("1970-01-01 00:00:00", "%Y-%m-%d %H:%M:%S", tz="GMT")
#' stringx::strptime("14 Nisan 5703", "date_short", locale="en_IL@calendar=hebrew")
#'
#'
#' @seealso
#' Related function(s): \code{\link{sprintf}}
#'
#' @rdname strptime
strptime <- function(x, format, tz="", lenient=FALSE, locale=NULL)
{
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(format)) format <- as.character(format)

    format_icu <- stringi::stri_datetime_fstr(format, ignore_special=FALSE)

    ret <- stringi::stri_datetime_parse(
        x,
        format=format_icu,
        lenient=lenient,
        tz=tz,
        locale=locale
    )
    # ret <- as.POSIXlt(ret)  # we don't want this

    # the following is not bullet proof:
    ret_attribs_before <- attributes(ret)
    ret <- .attribs_propagate_binary(ret, x, format)  # `format_icu` has no attribs
    attributes(ret) <- c(attributes(ret), ret_attribs_before)
    ret
}


#' @rdname strptime
strftime <- function(x, format="%Y-%m-%dT%H:%M:%S%z", tz="", usetz=FALSE, ..., locale=NULL)
{
    if (!inherits(x, "POSIXct")) x <- as.POSIXct(x)  # where is is.POSIXct?
    if (!is.character(format)) format <- as.character(format)

    if (!isFALSE(usetz)) warning("argument `usetz` has no effect in stringx")

    format_icu <- stringi::stri_datetime_fstr(format, ignore_special=FALSE)

    ret <- stringi::stri_datetime_format(
        x,
        format=format_icu,
        tz=tz,
        locale=locale
    )

    # let as.character.POSIXct determine which attributes
    # are to be considered for preservation
    x <- as.character(x)

    .attribs_propagate_binary(ret, x, format)  # `format_icu` has no attribs
}
