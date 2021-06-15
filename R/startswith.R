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
#' Determines if a string starts or ends with a match to a specified
#' fixed pattern.
#'
#' @details
#' Both functions are fully vectorised with respect to both arguments.
#'
#' For matching with regular expressions, see \code{\link{grepl}}
#' with patterns like \code{"^prefix"} and \code{"suffix$"}.
#'
#'
#' @section Differences from base R:
#' Replacements for base \code{\link[base]{startsWith}}
#' and \code{\link[base]{endsWith}}
#' implemented with \code{\link[stringi]{stri_startswith}}
#' and \code{\link[stringi]{stri_endswith}}.
#'
#' \itemize{
#' \item \code{\link[base]{grepl}} and some other pattern matching functions
#'     have a different argument order, where the needle precedes the haystack
#'     \bold{[not fixed here]}
#' \item \code{\link[base]{grepl}} also features the \code{ignore.case} argument
#'     \bold{[added here]}
#' \item partial recycling without the usual warning
#'     \bold{[fixed here]}
#' \item no attributes preserved whatsoever
#'     \bold{[fixed here]}
#' \item not suitable for natural language processing
#'     \bold{[fixed here -- use \code{fixed=NA}]}
#' }
#'
#'
#' @param x character vector whose elements are to be examined
#'
#' @param prefix,suffix character vectors with patterns to search for
#'
#' @param fixed single logical value;
#'     \code{TRUE} for fixed pattern matching
#'         (see \link[stringi]{about_search_fixed});
#'     \code{NA} for the Unicode collation algorithm
#'         (\link[stringi]{about_search_coll});
#'     \code{FALSE} is not supported -- use \code{\link{grepl}} instead
#'
#' @param ignore.case single logical value; indicates whether matching
#'     should be case-insensitive
#'
#' @param ... further arguments to \code{\link[stringi]{stri_startswith}}
#'     and \code{\link[stringi]{stri_endswith}}
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
#' x <- c("Mario", "mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario")
#' x[stringx::startsWith(x, "mario", ignore.case=TRUE)]
#' x[stringx::startsWith(x, "mario", fixed=NA, strength=1L)]
#'
#' @seealso
#' Related function(s): \code{\link{grepl}}, \code{\link{substr}}
#'
#' @rdname startswith
startsWith <- function(x, prefix, fixed=TRUE, ignore.case=FALSE, ...)
{
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(prefix)) prefix <- as.character(prefix)  # S3 generics, you do you
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore.case) && length(ignore.case) == 1L && !is.na(ignore.case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore.case)
                stringi::stri_startswith_coll(x, pattern=prefix, ...)
            else
                stringi::stri_startswith_coll(x, pattern=prefix, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_startswith_fixed(x, pattern=prefix, case_insensitive=ignore.case, ...)
        } else {
            stop("use `grepl` instead")
        }
    }

    .attribs_propagate_binary(ret, x, prefix)
}


#' @rdname startswith
endsWith <- function(x, suffix, fixed=TRUE, ignore.case=FALSE, ...)
{
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(suffix)) suffix <- as.character(suffix)  # S3 generics, you do you
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore.case) && length(ignore.case) == 1L && !is.na(ignore.case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore.case)
                stringi::stri_endswith_coll(x, pattern=suffix, ...)
            else
                stringi::stri_endswith_coll(x, pattern=suffix, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_endswith_fixed(x, pattern=suffix, case_insensitive=ignore.case, ...)
        } else {
            stop("use `grepl` instead")
        }
    }

    .attribs_propagate_binary(ret, x, suffix)
}
