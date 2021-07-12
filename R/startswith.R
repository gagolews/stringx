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
#' These functions are fully vectorised with respect to both arguments.
#'
#' For matching with regular expressions, see \code{\link{grepl}}
#' with patterns like \code{"^prefix"} and \code{"suffix$"}.
#'
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{startsWith}}
#' and \code{\link[base]{endsWith}}
#' implemented with \code{\link[stringi]{stri_startswith}}
#' and \code{\link[stringi]{stri_endswith}}.
#'
#' \itemize{
#' \item there are inconsistencies between the argument order and naming
#'     in \code{\link[base]{grepl}}, \code{\link[base]{strsplit}},
#'     and \code{\link[base]{startsWith}} (amongst others); e.g.,
#'     where the needle can precede the haystack, the use of the forward
#'     pipe operator, \code{\link[base]{|>}}, is less convenient
#'     \bold{[fixed here]}
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
#' @param pattern character vector with patterns to search for
#'
#' @param fixed single logical value;
#'     \code{TRUE} for fixed pattern matching
#'         (see \link[stringi]{about_search_fixed});
#'     \code{NA} for the Unicode collation algorithm
#'         (\link[stringi]{about_search_coll});
#'     \code{FALSE} is not supported -- use \code{\link{grepl}} instead
#'
#' @param ignore_case single logical value; indicates whether matching
#'     should be case-insensitive
#'
#' @param prefix,suffix aliases to the \code{pattern} argument [DEPRECATED]
#' @param ignore.case alias to the \code{ignore_case} argument [DEPRECATED]
#' @param ... further arguments to \code{\link[stringi]{stri_startswith}}
#'     and \code{\link[stringi]{stri_endswith}}, e.g., \code{locale}
#'
#'
#' @return
#' Each function returns a logical vector, indicating whether a pattern
#' match has been detected or not.
#' They preserve the attributes of the longest inputs (unless they are
#' dropped due to coercion).
#'
#' @examples
#' startsWith("ababa", c("a", "ab", "aba", "baba", NA))
#' outer(
#'     c("aba", "abb", "abc", "baba", "bac"),
#'     c("A", "B", "C"),
#'     endsWith,
#'     ignore_case=TRUE
#' )
#' x <- c("Mario", "mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario")
#' x[startsWith(x, "mario", ignore_case=TRUE)]
#' x[startsWith(x, "mario", fixed=NA, strength=1L)]
#'
#' @seealso
#' Related function(s): \code{\link{grepl}}, \code{\link{substr}}
#'
#' @rdname startswith
startsWith <- function(x, pattern=prefix, ..., ignore_case=ignore.case, fixed=TRUE, ignore.case=FALSE, prefix)
{
    if (!missing(prefix) && !missing(pattern)) stop("do not use [DEPRECATED] `prefix` if `pattern` is given as well")
    if (!missing(ignore.case) && !missing(ignore_case)) stop("do not use [DEPRECATED] `ignore.case` if `ignore_case` is given as well")
    if (any(is.na(...names()))) stop("further arguments can only be passed as keywords")

    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(pattern)) pattern <- as.character(pattern)  # S3 generics, you do you
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_startswith_coll(x, pattern, ...)
            else
                stringi::stri_startswith_coll(x, pattern, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_startswith_fixed(x, pattern, case_insensitive=ignore_case, ...)
        } else {
            stop("use `grepl` instead")
        }
    }

    .attribs_propagate_binary(ret, x, pattern)
}


#' @rdname startswith
endsWith <- function(x, pattern=suffix, ..., ignore_case=ignore.case, fixed=TRUE, ignore.case=FALSE, suffix)
{
    if (!missing(suffix) && !missing(pattern)) stop("do not use [DEPRECATED] `suffix` if `pattern` is given as well")
    if (!missing(ignore.case) && !missing(ignore_case)) stop("do not use [DEPRECATED] `ignore.case` if `ignore_case` is given as well")
    if (any(is.na(...names()))) stop("further arguments can only be passed as keywords")

    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(pattern)) pattern <- as.character(pattern)  # S3 generics, you do you
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_endswith_coll(x, pattern, ...)
            else
                stringi::stri_endswith_coll(x, pattern, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_endswith_fixed(x, pattern, case_insensitive=ignore_case, ...)
        } else {
            stop("use `grepl` instead")
        }
    }

    .attribs_propagate_binary(ret, x, pattern)
}
