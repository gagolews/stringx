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
#' \code{grepv2} returns a subset of \code{x} matching the corresponding
#' patterns. Its replacement version allows for substituting such a subset with
#' new content.
#'
#'
#' @details
#' These functions are fully vectorised with respect to \code{x} and
#' \code{pattern}.
#'
#' The [DEPRECATED] \code{grepl} simply calls
#' \code{grepl2} which have a cleaned-up argument list.
#'
#' The [DEPRECATED] \code{grep} with \code{value=FALSE} is actually redundant --
#' it can be trivially reproduced with \code{grepl} and
#' \code{\link[base]{which}}.
#'
#' \code{grepv2} and \code{grep} with \code{value=FALSE} combine
#' pattern matching and subsetting and some users may find it convenient
#' in conjunction with the forward pipe operator, \code{\link[base]{|>}}.
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
#'     pipe operator, \code{\link[base]{|>}}, is less convenient
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
#' \item missing values in haystack will result in a no-match
#'     \bold{[fixed in \code{grepl}; see Value]}
#' \item \code{ignore.case=TRUE} cannot be used with \code{fixed=TRUE}
#'     \bold{[fixed here]}
#' \item no attributes are preserved
#'     \bold{[fixed here; see Value]}
#' }
#'
#'
#' @param x character vector whose elements are to be examined
#'
#' @param pattern character vector of nonempty search patterns;
#'     for \code{grepv2} and \code{grep}, must not be longer than \code{x}
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
#' @param value character vector of replacement strings
#'     or a single logical value
#'     indicating whether indexes of strings in \code{x} matching
#'     patterns should be returned
#'
#' @param invert single logical value; indicates whether a no-match
#'     is rather of interest
#'
#' @param ignore_case,ignore.case single logical value; indicates whether matching
#'     should be case-insensitive
#'
#' @param perl,useBytes not used (with a warning if
#'     attempting to do so) [DEPRECATED]
#'
#'
#' @return
#' \code{grepl2} and [DEPRECATED] \code{grep} return a logical vector.
#' They preserve the attributes of the longest inputs (unless they are
#' dropped due to coercion). Missing values in the inputs are propagated
#' consistently.
#'
#' \code{grepv2} and [DEPRECATED] \code{grep} with \code{value=TRUE} returns
#' a subset of \code{x} with elements matching the corresponding patterns.
#' [DEPRECATED] \code{grep} with \code{value=FALSE} returns the indexes
#' in \code{x} where a match occurred.
#' Missing values are not included in the outputs and only the \code{names}
#' attribute is preserved, because the length of the result may be different
#' than that of \code{x}.
#'
#' The replacement version of \code{grepv2} modifies \code{x} 'in-place'.
#'
#'
#' @examples
#' x <- c("abc", "1237", "\U0001f602", "\U0001f603", "stringx\U0001f970", NA)
#' grepl2(x, "\\p{L}")
#' which(grepl2(x, "\\p{L}"))  # like grep
#'
#' # at least 1 letter or digit:
#' p <- c("\\p{L}", "\\p{N}")
#' `dimnames<-`(outer(x, p, grepl2), list(x, p))
#'
#' x |> grepv2("\\p{L}")
#' grepv2(x, "\\p{L}", invert=TRUE) <- "\U0001F496"
#' print(x)
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{strsplit}}, \code{\link{gsub2}},
#'     \code{\link{gregexpr2}}, \code{\link{gregextr2}},
#'     \code{\link{gsubstr}}
#'
#' @rdname grepl
grepl2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, invert=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))
    stopifnot(is.logical(invert) && length(invert) == 1L && !is.na(invert))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_detect_coll(x, pattern, negate=invert, ...)
            else
                stringi::stri_detect_coll(x, pattern, negate=invert, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_detect_fixed(x, pattern, negate=invert, case_insensitive=ignore_case, ...)
        } else {
            stringi::stri_detect_regex(x, pattern, negate=invert, case_insensitive=ignore_case, ...)
        }
    }

    .attribs_propagate_binary(ret, x, pattern)
}


#' @rdname grepl
grepv2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, invert=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    x[] <- stringi::stri_enc_toutf8(x)  # to UTF-8 and preserve attributes
    # pattern will be taken care of by grepl2

    idx <- grepl2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed, invert=invert)
    if (length(idx) != length(x)) stop("`pattern` cannot be longer than `x`")

    x[!is.na(idx) & idx]
}



#' @rdname grepl
`grepv2<-` <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, invert=FALSE,
    value
) {
    if (!is.character(x)) x <- as.character(x)
    x[] <- stringi::stri_enc_toutf8(x)  # to UTF-8 and preserve attributes
    # pattern will be taken care of by grepl2

    if (!is.character(value)) value <- as.character(value)
    value[] <- stringi::stri_enc_toutf8(value)  # to UTF-8 and preserve attributes

    idx <- grepl2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed, invert=invert)
    if (length(idx) != length(x)) stop("`pattern` cannot be longer than `x`")

    x[!is.na(idx) & idx] <- value  # will warn if incompatible lengths etc.
    x
}


#' @rdname grepl
grepl <- function(
    pattern, x, ...,
    ignore.case=FALSE, fixed=FALSE, invert=FALSE,
    perl=FALSE, useBytes=FALSE
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    grepl2(x, pattern, ..., ignore_case=ignore.case, fixed=fixed, invert=invert)
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

    if (value)
        grepv2(x, pattern, ..., ignore_case=ignore.case, fixed=fixed, invert=invert)
    else {
        if (!is.character(x)) x <- as.character(x)
        # pattern will taken care of by grepl2
        idx <- grepl2(x, pattern, ..., ignore_case=ignore.case, fixed=fixed, invert=invert)
        if (length(idx) != length(x)) stop("`pattern` cannot be longer than `x`")
        which(idx)
    }
}
