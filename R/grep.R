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
#' ... g stands for 'global'=all
#'
#' @details
#' This function is fully vectorised with respect to both arguments.
#'
#' For splitting text into 'characters' (grapheme clusters), words,
#' or sentences, use \code{\link[stringi]{stri_split_boundaries}} instead.
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{strsplit}}
#' implemented with \code{\link[stringi]{stri_split}}.
#'
#' \itemize{
#' \item there are inconsistencies between the argument order and naming
#'     in \code{\link[base]{grepl}}, \code{\link[base]{strsplit}},
#'     and \code{\link[base]{startsWith}} (amongst others); e.g.,
#'     where the needle can precede the haystack, the use of the forward
#'     pipe operator \code{|>} is less convenient
#'     \bold{[fixed here]}
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
#'     \bold{[fixed here]}
#' \item ...
#' }
#'
#'
#' @param x character vector whose elements are to be examined
#'
#' @param pattern character vector of nonempty search patterns
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
#' @param ... further arguments to \code{\link[stringi]{stri_split}},
#'     e.g., \code{omit_empty}, \code{locale}, \code{dotall}
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
#' # ...
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{strsplit}}, \code{\link{gsub}}, \code{\link{substr}}
#'
#' @rdname grep
grep2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE, value=FALSE, invert=FALSE
) {
    # TODO
}


#' @rdname grep
grepl2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname grep
regexpr2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname grep
gregexpr2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname grep
regexec2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname grep
gregexec2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}



#' @rdname grep
grep <- function(
    pattern, x, ...,
    ignore.case=FALSE, fixed=FALSE, value=FALSE, invert=FALSE,
    perl=FALSE, useBytes=FALSE
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (!missing(x) && !missing(text)) stop("do not use `text` if `x` is given as well")
    grep2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed, value=value, invert=invert)
}


#' @rdname grep
grepl <- function(
    pattern, x, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (!missing(x) && !missing(text)) stop("do not use `text` if `x` is given as well")
    grepl2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed)
}


#' @rdname grep
regexpr <- function(
    pattern, x=text, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE, text
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (!missing(x) && !missing(text)) stop("do not use `text` if `x` is given as well")
    regexpr2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed)
}


#' @rdname grep
gregexpr <- function(
    pattern, x=text, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE, text
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (!missing(x) && !missing(text)) stop("do not use `text` if `x` is given as well")
    gregexpr2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed)
}


#' @rdname grep
regexec <- function(
    pattern, x=text, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE, text
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (!missing(x) && !missing(text)) stop("do not use `text` if `x` is given as well")
    regexec2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed)
}


#' @rdname grep
gregexec <- function(
    pattern, x=text, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE, text
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (!missing(x) && !missing(text)) stop("do not use `text` if `x` is given as well")
    gregexec2(x, pattern, ..., ignore.case=ignore.case, fixed=fixed)
}
