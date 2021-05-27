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
#' Replacements for base \code{\link[base]{strptime}}
#' and \code{\link[base]{strftime}} implemented with
#' \code{\link[stringi]{stri_datetime_parse}} and
#' \code{\link[stringi]{stri_datetime_format}}.
#'
#' Inconsistencies/limitations in base R and the way we have addressed them:
#'
#' \itemize{
#' \item formatting/parsing date-time in different locales and calendars
#'     is difficult and non-portable
#'     \bold{[fixed here - using services provided by ICU]};
#' \item default format not conforming to ISO 8601, in particular not
#'     displaying the current time zone
#'     \bold{[fixed here]};
#' \item partial recycling with no warning
#'     \bold{[fixed here]};
#' ...
#' }
#'
#'
#' @param x object to be converted
#'
#' @param tz \code{NULL} or \code{''} for the default time zone
#'    (see \code{\link[stringi]{stri_timezone_get}})
#'    or a single string with a timezone identifier,
#'    see \code{\link[stringi]{stri_timezone_list}}
#'
#' @param ... not used
#'
#' @param format character vector of date-time format specifiers,
#'    see \code{\link[stringi]{stri_datetime_fstr}};
#'    e.g., \code{"\%Y-\%m-\%d"} or \code{"datetime_full"};
#'    the default conforms to the ISO 8601 guideline,
#'    e.g., '2015-12-31T23:59:59+0100'
#'
#' @locale \code{NULL} or \code{''} for the default locale
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
#' \code{strptime} returns an object of class \code{\link{POSIXlt}}.
#'
#'
#' @examples
#' f <- c("date_full", "%Y-%m-%d", "date_relative_short", "datetime_full")
#' stringx::strftime(Sys.time(), f))  # current default locale
#' stringx::strftime(Sys.time(), f, locale="de_DE")
#' stringx::strftime(Sys.time(), "date_short", locale="en_IL@calendar=hebrew")
#'
#'
#' @seealso
#' Related function(s): \code{\link{sprintf}}
#'
#' @export
#' @rdname strptime
strptime <- function(x, format="%Y-%m-%dT%H:%M:%S%z", tz="", lenient=FALSE, locale=NULL)
{
    format <- stringi::stri_datetime_fstr(format, ignore_special=FALSE)

    y <- stringi::stri_datetime_parse(
        x,
        format=format,
        lenient=lenient,
        tz=tz,
        locale=locale
    )
    y <- as.POSIXlt(y)
    names(y$year) <- names(x)  # base::strptime has it
    y
}


#' @export
#' @rdname strptime
strftime <- function(x, format="%Y-%m-%dT%H:%M:%S%z", tz="", usetz=FALSE, ..., locale=NULL)
{
    format_icu <- stringi::stri_datetime_fstr(format, ignore_special=FALSE)

    ret <- stringi::stri_datetime_format(
        x,
        format=format_icu,
        tz=tz,
        locale=locale
    )

    .attribs_propagate_binary(ret, x, format)  # format_icu as no attribs
}