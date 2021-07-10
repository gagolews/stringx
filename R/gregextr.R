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
#' Extract Pattern Occurrences
#'
#' @description
#' \code{regextr2} and \code{gregextr2} extract, respectively, first and all
#' (i.e., \bold{g}lobally) occurrences of a pattern.
#' Their replacement versions substitute the matching substrings with
#' new content.
#'
#'
#' @details
#' Convenience functions based on \code{\link{gregexpr2}}
#' and \code{\link{gsubstrl}} (amongst others).
#'
#' They are fully vectorised with respect to both \code{x} and
#' \code{pattern}.
#'
#' Provided as pipe operator-friendly alternative
#' to [DEPRECATED] \code{\link[base]{regmatches}}
#' [DEPRECATED] \code{\link[utils]{strcapture}}.
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
#' @param ignore_case single logical value; indicates whether matching
#'     should be case-insensitive
#'
#' @param capture_groups single logical value; whether to extract
#'     matches to regex capture groups as well
#'
#' @param value character vector  (for \code{regextr})
#'     or list of character vectors  (for \code{gregextr})
#'     defining the replacements strings
#'
#' @param ... further arguments to \code{\link[stringi]{stri_locate}},
#'     e.g., \code{omit_empty}, \code{locale}, \code{dotall}
#'
#' @param ..........
#'
#'
#' @return
#' \code{regextr2} ......
#'
#' \code{gregextr2} ......
#'
#' \code{capture_groups} ...
#'
#' These functions preserve the attributes of the longest inputs (unless they
#' are dropped due to coercion). Missing values in the inputs are propagated
#' consistently.
#'
#'
#' @examples
#' # ...
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{strsplit}}, \code{\link{gsub2}}
#'     \code{\link{grepl2}}, \code{\link{gregexpr2}}, \code{\link{gsubstrl}},
#'
#' @rdname gregextr
regextr2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, capture_groups=FALSE
) {
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    stopifnot(is.logical(capture_groups) && length(capture_groups) == 1L && !is.na(capture_groups))

    if (capture_groups) {
        m <- regexec2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed)
        v <- gsubstrl(x, m)
        stopifnot(length(v) == length(m))
        for (i in seq_along(v))
            v[[i]] <- structure(v[[i]], names=names(m[[i]]))
        v
    }
    else
        substrl(x, regexpr2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed))
}


#' @rdname gregextr
gregextr2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, capture_groups=FALSE
) {
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you
    stopifnot(is.logical(capture_groups) && length(capture_groups) == 1L && !is.na(capture_groups))

    if (capture_groups) {
        m <- gregexec2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed)
        v <- gsubstrl(x, m)
        stopifnot(length(v) == length(m))
        for (i in seq_along(v))
            v[[i]] <- structure(v[[i]], dim=dim(m[[i]]), dimnames=dimnames(m[[i]]))
        v
    }
    else
        gsubstrl(x, gregexpr2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed))
}


#' @rdname gregextr
`regextr2<-` <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, value
) {
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you

    `substrl<-`(x, regexpr2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed), value=value)
}


#' @rdname gregextr
`gregextr2<-` <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, value
) {
    if (!is.character(x)) x <- as.character(x)    # S3 generics, you do you

    `gsubstrl<-`(x, gregexpr2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed), value=value)
}

