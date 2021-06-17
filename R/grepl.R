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
#' Detect Pattern Occurrences
#'
#' @description
#' \code{grepl2} indicates whether a string matches the corresponding pattern
#' or not.
#'
#' @details
#' These functions are fully vectorised with respect to \code{x} and
#' \code{pattern}.
#'
#' The [DEPRECATED] \code{grepl} simply calls
#' \code{grepl2} which have a cleaned-up argument list.
#'
#' The [DEPRECATED] \code{grep} is actually redundant -- it can be
#' trivially reproduced
#' with \code{grepl}, subsetting (if \code{value=TRUE}),
#' and \code{\link[base]{which}} (if \code{value=FALSE}).
#'
#'
#' @section Differences from Base R:
#' \code{grepl} and \code{grep} are [DEPRECATED] replacements for base
#' \code{\link[base]{grep}} and \code{\link[base]{grepl}}
#' implemented with \code{\link[stringi]{stri_detect}}.
#'
#' \itemize{
#' \item there are inconsistencies between the argument order and naming
#'     in \code{\link[base]{grepl}}, \code{\link[base]{strsplit}},
#'     and \code{\link[base]{startsWith}} (amongst others); e.g.,
#'     where the needle can precede the haystack, the use of the forward
#'     pipe operator \code{|>} is less convenient
#'     \bold{[fixed by introducing \code{grepl2}]}
#' \item base R implementation is not portable as it is based on
#'     the system PCRE or TRE library
#'     (e.g., some Unicode classes may not be available or matching thereof
#'     can depend on the current \code{LC_CTYPE} category
#'     \bold{[fixed here]}
#' \item not suitable for natural language processing
#'     \bold{[fixed here -- use \code{fixed=NA}]}
#' \item two different regular expression libraries are used
#'     (and historically, ERE was used in place of TRE)
#'     \bold{[here, \pkg{ICU} Java-like regular expression engine
#'     is only available, hence the \code{perl} argument has no meaning]}
#' \item not vectorised w.r.t. \code{pattern}
#'     \bold{[fixed here, however, in \code{grep}, \code{pattern} cannot be
#'     longer than \code{x}]}
#' \item ...
#' }
#'
#'
#' @param x character vector whose elements are to be examined
#'
#' @param pattern character vector of nonempty search patterns
#'
#' @param ... further arguments to \code{\link[stringi]{stri_detect}},
#'     e.g., \code{max_count}, \code{locale}, \code{dotall}
#'
#' @param fixed single logical value;
#'     \code{FALSE} for matching with regular expressions
#'         (see \link[stringi]{about_search_regex});
#'     \code{TRUE} for fixed pattern matching
#'         (\link[stringi]{about_search_fixed});
#'     \code{NA} for the Unicode collation algorithm
#'         (\link[stringi]{about_search_coll})
#'
#' @param value single logical value
#'     indicating whether indexes of strings in \code{x} matching
#'     patterns should be returned [DEPRECATED]
#'
#' @param invert single logical value; indicates whether a no-match
#'     is rather of interest [DEPRECATED]
#'
#' @param ignore.case single logical value; indicates whether matching
#'     should be case-insensitive
#'
#' @param perl,useBytes not used (with a warning if
#'     attempting to do so) [DEPRECATED]
#'
#'
#' @return
#' \code{grepl2} and [DEPRECATED] \code{grep} return a logical vector.
#' They preserve the attributes of the longest inputs (unless they are
#' dropped due to coercion).
#'
#' [DEPRECATED] \code{grep} with \code{value=TRUE} returns
#' a subset of \code{x} with elements matching the corresponding patterns.
#' [DEPRECATED] \code{grep} with \code{value=FALSE} returns the indexes
#' in \code{x} where a match occurred.
#' Missing values are not included in the outputs and only the \code{names}
#' attribute is preserved, because the length of the result may be different
#' than that of \code{x}.
#'
#'
#' @examples
#' # ...
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{strsplit}}, \code{\link{gsub}}, \code{\link{gregexpr}},
#'     \code{\link{substr}}
#'
#' @rdname grepl
grepl2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(pattern)) pattern <- as.character(pattern)  # S3 generics, you do you
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore.case) && length(ignore.case) == 1L && !is.na(ignore.case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore.case)
                stringi::stri_detect_coll(x, pattern, ...)
            else
                stringi::stri_detect_coll(x, pattern, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_detect_fixed(x, pattern, case_insensitive=ignore.case, ...)
        } else {
            stringi::stri_detect_regex(x, pattern, case_insensitive=ignore.case, ...)
        }
    }

    .attribs_propagate_binary(ret, x, pattern)
}


#' @rdname grepl
grepl <- function(
    pattern, x, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    grepl2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed)
}


#' @rdname grepl
grep <- function(
    pattern, x, ...,
    ignore.case=FALSE, fixed=FALSE, value=FALSE, invert=FALSE,
    perl=FALSE, useBytes=FALSE
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    stopifnot(is.logical(value) && length(value) == 1L && !is.na(value))

    x[] <- stringi::stri_enc_toutf8(x)  # to UTF-8 and preserve attributes
    idx <- grepl2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed, negate=invert)
    if (length(idx) != length(x)) stop("`pattern` cannot be longer than `x`")

    if (value)
        x[!is.na(idx) & idx]
    else
        which(idx)
}

