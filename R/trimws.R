# kate: default-dictionary en_AU

## stringx package for R
## Copyleft (C) 2021-2023, Marek Gagolewski <https://www.gagolewski.com/>
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
#' Trim Leading or Trailing Whitespaces
#'
#' @description
#' Removes whitespaces (or other code points as specified by the
#' \code{whitespace} argument) from left, right, or both sides of each string.
#'
#' @details
#' Not to be confused with \code{\link{strtrim}}.
#'
#'
#' @section Differences from Base R:
#' Replacement for base \code{\link[base]{trimws}}
#' implemented with \code{\link[stringi]{stri_replace_all_regex}}
#' (and not \code{\link[stringi]{stri_trim}}, which uses a slightly different
#' syntax for pattern specifiers).
#'
#' \itemize{
#' \item the default \code{whitespace} argument does not reflect the
#'     'contemporary' definition of whitespaces
#'     (e.g., does not include zero-width spaces)
#'     \bold{[fixed here]}
#' \item base R implementation is not portable as it is based on
#'     the system PCRE library
#'     (e.g., some Unicode classes may not be available or matching thereof
#'     can depend on the current \code{LC_CTYPE} category)
#'     \bold{[fixed here]}
#' \item no sanity checks are performed on \code{whitespace}
#'     \bold{[fixed here]}
#' }
#'
#'
#' @param x character vector
#'     whose elements are to be trimmed
#'
#' @param which single string; either \code{"both"}, \code{"left"},
#'     or \code{"right"}; side(s) from which the code points matching
#'     the \code{whitespace} pattern are to be removed
#'
#' @param whitespace single string; specifies the set of Unicode code points
#'     for removal, see 'Character Classes' in
#'     \link[stringi]{about_search_regex} for more details
#'
#'
#' @return
#' Returns a character vector (in UTF-8).
#'
#'
#' @examples
#' base::trimws("NAAAAANA!!!NANAAAAA", whitespace=NA)  # stringx raises an error
#' x <- "   :)\v\u00a0 \n\r\t"
#' base::trimws(x)
#' stringx::trimws(x)
#'
#' @seealso
#' Related function(s): \code{\link{sub}}
#'
#' @rdname trimws
trimws <- function(x, which="both", whitespace="\\p{Wspace}")
{
    # stri_trim is vectorised w.r.t. whitespace as well
    stopifnot(is.character(whitespace), length(whitespace) == 1, !is.na(whitespace))

    which <- match.arg(which, c("both", "left", "right"))  # less non-standard eval

    if (!is.character(x)) x <- as.character(x)

    if (which == "left")
        pattern <- stringi::stri_sprintf("^[%1$s]+", whitespace)
    else if (which == "right")
        pattern <- stringi::stri_sprintf("[%1$s]+$", whitespace)
    else
        pattern <- stringi::stri_sprintf("^[%1$s]+|[%1$s]+$", whitespace)

    ret <- stringi::stri_replace_all_regex(x, pattern, "")

    .attribs_propagate_unary(ret, x)
}
