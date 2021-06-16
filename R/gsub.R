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
#' Replace Pattern Occurrences
#'
#' @description
#' Splits each string into chunks delimited by occurrences of a given pattern.
#'
#' @details
#' These functions are fully vectorised with respect to \code{pattern},
#' \code{replacement}, and \code{x}.
#'
#' For splitting text into 'characters' (grapheme clusters), words,
#' or sentences, use \code{\link[stringi]{stri_split_boundaries}} instead.
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{strsplit}}
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
#' \item there are inconsistencies between the argument order and naming
#'     in \code{\link[base]{grepl}}, \code{\link[base]{strsplit}},
#'     and \code{\link[base]{startsWith}} (amongst others); e.g.,
#'     where the needle can precede the haystack, the use of the forward
#'     pipe operator \code{|>} is less convenient
#'     \bold{[...........fixed here]}
#' \item \code{\link[base]{grepl}} also features the \code{ignore.case} argument
#'     \bold{[added here]}
#' \item if \code{split} is a zero-length vector, it is treated as \code{""},
#'     which extracts individual code points (which is not the best idea
#'     for natural language processing tasks)
#'     \bold{[empty search patterns are not supported here, zero-length vectors
#'     are propagated correctly]}
#' \item last empty token is removed from the output, but first is not
#'     \bold{[fixed here -- see also the \code{omit_empty} argument]}
#' \item missing values in \code{split} are not propagated correctly
#'     \bold{[fixed here]}
#' \item partial recycling without the usual warning, not fully vectorised
#'     w.r.t. the \code{split} argument
#'     \bold{[fixed here]}
#' \item only the \code{names} attribute of \code{x} is preserved
#'     \bold{[fixed here]}
#' \item ...different syntax....
#' }
#'
#'
#' @param x character vector with strings whose chunks are to be modified
#'
#' @param pattern character vector of nonempty search patterns
#'
#' @param replacement character vector with the corresponding replacement
#'     strings
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
#' @param ... further arguments to \code{\link[stringi]{stri_replace}},
#'     e.g., \code{omit_empty}, \code{locale}, \code{dotall}
#'
#' @param text alias to the \code{x} argument [DEPRECATED]
#' @param perl,useBytes not used (with a warning if
#'     attempting to do so) [DEPRECATED]
#'
#'
#' @return
#' Both functions return a character vector.
#' Attributes are copied from the longest inputs.
#'
#'
#' @examples
#' # ...
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{grep}}, \code{\link{strsplit}}, \code{\link{substr}}
#'
#' @rdname gsub
sub <- function(
    pattern, replacement, x, ...,
    ignore.case=FALSE, fixed=FALSE, perl=FALSE, useBytes=FALSE
) {

}


#' @rdname gsub
gsub <- function(
    pattern, replacement, x, ...,
    ignore.case=FALSE, fixed=FALSE, perl=FALSE, useBytes=FALSE
) {

}
