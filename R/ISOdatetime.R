# kate: default-dictionary en_AU

## stringx package for R
## Copyleft (C) 2021-2024, Marek Gagolewski <https://www.gagolewski.com/>
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
#' Construct Date-time Objects
#'
#' @description
#' \code{ISOdate} and \code{ISOdatetime} construct date-time objects
#' from numeric representations.
#' \code{Sys.time} returns current time.
#'
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{ISOdatetime}}
#' and \code{\link[base]{ISOdate}} implemented with
#' \code{\link[stringi]{stri_datetime_create}}.
#'
#' \itemize{
#' \item \code{ISOdate} does not treat dates as being at midnight
#'     by default \bold{[fixed here]}
#' }
#'
#'
#' @param year,month,day,hour,min,sec numeric vectors
#'
#' @param tz \code{NULL} or \code{''} for the default time zone
#'    (see \code{\link[stringi]{stri_timezone_get}})
#'    or a single string with a timezone identifier,
#'    see \code{\link[stringi]{stri_timezone_list}}
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
#' These functions return an object of class \code{POSIXxt}, which
#' extends upon \code{\link[base]{POSIXct}}, \code{\link{strptime}}.
#'
#' You might wish to consider calling \code{\link{as.Date}} on
#' the result yielded by \code{ISOdate}.
#'
#' No attributes are preserved (because they are too many).
#'
#' @examples
#' ISOdate(1970, 1, 1)
#' ISOdatetime(1970, 1, 1, 12, 0, 0)
#'
#' @seealso
#' Related function(s): \code{\link{strptime}}
#'
#' @rdname ISOdatetime
ISOdatetime <- function(
    year, month, day, hour, min, sec, tz="", lenient=FALSE, locale=NULL
) {
    if (!is.numeric(year))  year  <- as.numeric(year)
    if (!is.numeric(month)) month <- as.numeric(month)
    if (!is.numeric(day))   day   <- as.numeric(day)
    if (!is.numeric(hour))  hour  <- as.numeric(hour)
    if (!is.numeric(min))   min   <- as.numeric(min)
    if (!is.numeric(sec))   sec   <- as.numeric(sec)

    as.POSIXxt(stringi::stri_datetime_create(
        year, month, day, hour, min, sec, lenient=lenient, tz=tz, locale=locale
    ))
}


#' @rdname ISOdatetime
ISOdate <- function(
    year, month, day,
    hour=0L, min=0L, sec=0L, tz="", lenient=FALSE, locale=NULL
) {
    ISOdatetime(year, month, day, hour, min, sec, tz, lenient, locale)
}


#' @rdname ISOdatetime
Sys.time <- function() {
    as.POSIXxt(stringi::stri_datetime_now())
}
