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
#' Detect Pattern Occurrences at Start or End of Strings
#'
#' @description
#' Determines if a string starts or ends if with a match to a specified
#' fixed pattern.
#'
#' @details
#' Replacements for base \code{\link[base]{startsWith}}
#' and \code{\link[base]{endsWith}}
#' implemented with \code{\link[stringi]{stri_startswith_fixed}}
#' and \code{\link[stringi]{stri_endswith_fixed}}
#'
#' For matching with regular expressions, see \code{\link{grepl}}
#' with patterns like \code{"^prefix"} and \code{"suffix$"}.
#'
#' Vectorised with respect to both arguments.
#'
#' Inconsistencies in/differences from base R:
#'
#' \itemize{
#' \item note that other pattern matching functions have a different argument
#'     order, where the needle precedes the haystack
#'     \bold{[not fixed here]}
#' \item \code{\link[base]{grepl}} also features the \code{ignore.case} argument
#'     \bold{[added here]}
#' \item partial recycling without the usual warning
#'     \bold{[fixed here]}
#' \item no attributes preserved whatsoever
#'     \bold{[fixed here]}
#' }
#'
#'
#' @param x character vector whose elements are to be examined
#'
#' @param prefix,suffix character vectors with fixed (literal) patterns
#'     to search for
#'
#' @param ignore.case single logical value
#'
#'
#' @return
#' Each function returns a logical vector, indicating whether a pattern
#' match has been detected or not.
#'
#'
#' @examples
#' stringx::startsWith("ababa", c("a", "ab", "aba", "baba", NA))
#' outer(
#'     c("aba", "abb", "abc", "baba", "bac"),
#'     c("A", "B", "C"),
#'     stringx::endsWith,
#'     ignore.case=TRUE
#' )
#'
#' @seealso
#' Related function(s): \code{\link{grepl}}, \code{\link{substr}}
#'
#' @rdname startswith
startsWith <- function(x, prefix, ignore.case=FALSE)
{
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(prefix)) x <- as.character(prefix)    # S3 generics, you do you

    ret <- stringi::stri_startswith_fixed(
        x,
        pattern=prefix,
        case_insensitive=ignore.case
    )

    .attribs_propagate_binary(ret, x, prefix)
}


#' @rdname startswith
endsWith <- function(x, suffix, ignore.case=FALSE)
{
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(suffix)) x <- as.character(suffix)    # S3 generics, you do you

    ret <- stringi::stri_endswith_fixed(
        x,
        pattern=suffix,
        case_insensitive=ignore.case
    )

    .attribs_propagate_binary(ret, x, suffix)
}
