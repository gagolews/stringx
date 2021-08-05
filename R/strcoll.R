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


#' @title
#' Compare Strings
#'
#' @description
#' These functions provide means to compare strings in any locale
#' using the Unicode collation algorithm.
#'
#' @details
#' These functions are fully vectorised with respect to both arguments.
#'
#' For a locale-insensitive behaviour like that of
#' \code{strcmp} from the standard C library, call
#' \code{strcoll(e1, e2, locale="C", strength=4L, normalisation=FALSE)}.
#' However, some normalisation will still be performed.
#'
#'
#' @section Differences from Base R:
#' Replacements for base \link[base]{Comparison} operators
#' implemented with \code{\link[stringi]{stri_cmp}}.
#'
#' \itemize{
#' \item collation in different locales is difficult and non-portable across
#'     platforms
#'     \bold{[fixed here -- using services provided by ICU]}
#' \item overloading \code{`<.character`} has no effect in R, because S3
#'     method dispatch is done internally with hard-coded support for
#'     character arguments. We could have replaced the generic \code{`<`}
#'     with the one that calls \code{\link[base]{UseMethod}}, but
#'     it feels like a too intrusive solution
#'     \bold{[fixed by introducing the \code{`\%x<\%`} operator]}
#' }
#'
#'
#' @param e1,e2 character vector whose corresponding elements are to be
#'      compared
#'
#' @param locale \code{NULL} or \code{""} for the default locale
#'    (see \code{\link[stringi]{stri_locale_get}})
#'    or a single string with a locale identifier,
#'    see \code{\link[stringi]{stri_locale_list}}
#'
#' @param strength see \code{\link[stringi]{stri_opts_collator}}
#' @param alternate_shifted see \code{\link[stringi]{stri_opts_collator}}
#' @param french see \code{\link[stringi]{stri_opts_collator}}
#' @param uppercase_first see \code{\link[stringi]{stri_opts_collator}}
#' @param case_level see \code{\link[stringi]{stri_opts_collator}}
#' @param normalisation see \code{\link[stringi]{stri_opts_collator}}
#' @param numeric see \code{\link[stringi]{stri_opts_collator}}
#'
#'
#' @return
#' \code{strcmp} returns an integer vector representing the comparison results:
#' if a string in \code{e1} is smaller than the corresponding string in
#' \code{e2}, the corresponding result will be equal to \code{-1}, and
#' \code{0} if they are canonically equivalent,
#' as well as \code{1} if the former is greater than the latter.
#'
#' The binary operators call \code{strcoll} with default arguments and
#' return logical vectors.
#'
#'
#'
#' @examples
#' # lexicographic vs. numeric sort
#' strcoll("100", c("1", "10", "11", "99", "100", "101", "1000"))
#' strcoll("100", c("1", "10", "11", "99", "100", "101", "1000"), numeric=TRUE)
#' strcoll("hladn\u00FD", "chladn\u00FD", locale="sk_SK")
#'
#' @seealso
#' Related function(s): \code{\link{xtfrm}}
#'
#' @rdname strcoll
strcoll <- function(
    e1,
    e2,
    locale=NULL,
    strength=3L,
    alternate_shifted=FALSE,
    french=FALSE,
    uppercase_first=NA,
    case_level=FALSE,
    normalisation=FALSE,
    numeric=FALSE
) {
    if (!is.character(e1)) e1 <- as.character(e1)
    if (!is.character(e2)) e2 <- as.character(e2)
    ret <- stringi::stri_cmp(
        e1,
        e2,
        locale=locale,
        strength=strength,
        alternate_shifted=alternate_shifted,
        french=french,
        uppercase_first=uppercase_first,
        case_level=case_level,
        normalisation=normalisation,
        numeric=numeric
    )
    .attribs_propagate_binary(ret, e1, e2)
}


#' @rdname strcoll
`%x<%` <- function(e1, e2)
{
    strcoll(e1, e2) < 0L
}


#' @rdname strcoll
`%x<=%` <- function(e1, e2)
{
    strcoll(e1, e2) <= 0L
}


#' @rdname strcoll
`%x==%` <- function(e1, e2)
{
    strcoll(e1, e2) == 0L
}


#' @rdname strcoll
`%x!=%` <- function(e1, e2)
{
    strcoll(e1, e2) != 0L
}


#' @rdname strcoll
`%x>%` <- function(e1, e2)
{
    strcoll(e1, e2) > 0L
}


#' @rdname strcoll
`%x>=%` <- function(e1, e2)
{
    strcoll(e1, e2) >= 0L
}
