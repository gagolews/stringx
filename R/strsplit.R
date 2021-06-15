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
#' Split Strings into Tokens
#'
#' @description
#' Splits each string into chunks delimited by occurrences of a given pattern.
#'
#' @details
#' This function is fully vectorised with respect to both arguments.
#'
#' For splitting text into 'characters' (grapheme clusters), words,
#' or sentences, use \code{\link[stringi]{stri_split_boundaries}} instead.
#'
#' @section Differences from base R:
#' Replacements for base \code{\link[base]{strplit}}
#' implemented with \code{\link[stringi]{stri_split}}.
#'
#' \itemize{
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
#' \item \code{\link[base]{grepl}} and some other pattern matching functions
#'     have a different argument
#'     order, where the needle precedes the haystack and \code{ignore.case}
#'     is listed before \code{perl} and then \code{fixed} etc.
#'     \bold{[not fixed here]}
#' \item \code{\link[base]{grepl}} also features the \code{ignore.case} argument
#'     \bold{[added here]}
#' \item if \code{split} is a zero-length vector, it is treated as \code{""},
#'     which extracts individual code points (which is not the best idea
#'     for natural language processing tasks)
#'     \bold{[empty search patterns are not supported here, zero-length vectors
#'     are propagated correctly]}
#' \item missing values in \code{split} are not propagated correctly
#'     \bold{[fixed here]}
#' \item ...partial recycling without the usual warning ????????? is there recycling???
#'     \bold{[fixed here]}
#' \item ...no attributes preserved whatsoever
#'     \bold{[fixed here]}
#' }
#'
#'
#' @param x character vector whose elements are to be examined
#'
#' @param split character vector of nonempty search patterns,
#'      \link[stringi]{about_search_regex}
#'
#' @param fixed single logical value;
#'     \code{FALSE} for matching with regular expressions
#'         (see \link[stringi]{about_search_regex});
#'     \code{TRUE} for fixed pattern matching
#'         (\link[stringi]{about_search_fixed});
#'     \code{NA} for the Unicode collation algorithm
#'         (\link[stringi]{about_search_coll})
#'
#' @param ignore.case single logical value; indicates whether matching
#'     should be case-insensitive
#'
#' @param ... further arguments to \code{\link[stringi]{stri_split}}
#'
#' @param perl,useBytes not used (with a warning if
#'     attempting to do so) [DEPRECATED]
#'
#'
#' @return
#' Returns a list of character vectors representing the identified tokens.
#'
#'
#' @examples
#' x <- strcat(c(
#'     "abc", "123", ",!.", "\U0001F4A9",
#'     "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
#'     "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
#'     "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
#' ))
#' base::strsplit(x, "")  # stringx does not support this
#' stringx::strsplit(x, "(?s)(?=.)", omit_empty=TRUE)  # look-ahead for any char with dot-all
#' stringi::stri_split_boundaries(x, type="character")  # grapheme clusters
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{grep}}, \code{\link{substr}}
#'
#'
#'
#' @rdname strsplit
strsplit <- function(x, split, fixed=FALSE, perl=FALSE, useBytes=FALSE, ignore.case=FALSE, ...)
{
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    if (!is.character(split)) split <- as.character(split)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore.case) && length(ignore.case) == 1L && !is.na(ignore.case))

    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")

    ret <- {
        if (is.na(fixed)) {
            if (!ignore.case)
                stringi::stri_split_coll(x, pattern=split, ...)
            else
                stringi::stri_split_coll(x, pattern=split, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_split_fixed(x, pattern=split, case_insensitive=ignore.case, ...)
        } else {
            stringi::stri_split_regex(x, pattern=split, case_insensitive=ignore.case, ...)
        }
    }

    .attribs_propagate_binary(ret, x, split)
}
