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
#' Locate Pattern Occurrences
#'
#' @description
#' \code{regexpr} and \code{gregexpr} locate first and all
#' (i.e., \textbf{g}lobally) occurrences of a pattern.
#' \code{regexec} and \code{gregexec} can additionally
#' pinpoint the matches to parenthesised subexpressions (regex capture groups).
#'
#' @details
#' These functions are fully vectorised with respect to both \code{x} and
#' \code{pattern}.
#'
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{gregexpr}} (and others)
#' implemented with \code{\link[stringi]{stri_locate}}.
#'
#' \itemize{
#' \item there are inconsistencies between the argument order and naming
#'     in \code{\link[base]{grepl}}, \code{\link[base]{strsplit}},
#'     and \code{\link[base]{startsWith}} (amongst others); e.g.,
#'     where the needle can precede the haystack, the use of the forward
#'     pipe operator, \code{\link[base]{|>}}, is less convenient
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
#' @param text alias to the \code{x} argument [DEPRECATED]
#'
#' @param perl,useBytes not used (with a warning if
#'     attempting to do so) [DEPRECATED]
#'
#'
#' @return
#' Lack of matches are denoted with -1s.???
#'
#' \code{regexpr} returns an integer vector which gives the
#' start positions of the matches. The \code{match.length} attribute
#'
#'
#'
#' @examples
#' # ...
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{strsplit}}, \code{\link{gsub}}, \code{\link{substrl}},
#'     \code{\link{grepl}}
#'
#' @rdname gregexpr
regexpr2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname gregexpr
gregexpr2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname gregexpr
regexec2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname gregexpr
gregexec2 <- function(
    x, pattern, ...,
    ignore.case=FALSE, fixed=FALSE
) {
    # TODO
}


#' @rdname gregexpr
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


#' @rdname gregexpr
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


#' @rdname gregexpr
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


#' @rdname gregexpr
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
