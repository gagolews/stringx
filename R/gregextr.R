# kate: default-dictionary en_AU

## stringx package for R
## Copyleft (C) 2021-2022, Marek Gagolewski <https://www.gagolewski.com>
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
#' Provided as pipe operator-friendly alternatives
#' to [DEPRECATED] \code{\link[base]{regmatches}} and
#' [DEPRECATED] \code{\link[utils]{strcapture}}.
#'
#' They are fully vectorised with respect to \code{x},
#' \code{pattern}, and \code{value}.
#'
#' Note that, unlike in \code{\link{gsub2}},
#' each substituted chunk can be replaced with different content.
#' However, references to matches to capture groups cannot be made.
#'
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
#'     defining the replacement strings
#'
#' @param ... further arguments to \code{\link[stringi]{stri_locate}},
#'     e.g., \code{omit_empty}, \code{locale}, \code{dotall}
#'
#' @param capture_groups single logical value; whether matches
#'     individual capture groups should be extracted separately
#'
#'
#' @return
#' \code{capture_groups} is \code{FALSE},
#' \code{regextr2} returns a character vector and
#' \code{gregextr2} gives a list of character vectors.
#'
#' Otherwise, \code{regextr2} returns a list of character vectors,
#' giving the whole match as well as matches to the individual capture groups.
#' In \code{gregextr2}, this will be a matrix with as many columns
#' as there are matches.
#'
#' Missing values in the inputs are propagated consistently.
#' In \code{regextr2}, a no-match is always denoted with \code{NA}
#' (or series thereof). In \code{gregextr2}, the corresponding result is
#' empty (unless we mean a no-match to an optional capture group within
#' a matching substring). Note that this function distinguishes
#' between a missing input and a no-match.
#'
#' Their replacement versions return a character vector.
#'
#' These functions preserve the attributes of the longest inputs (unless they
#' are dropped due to coercion).
#'
#'
#' @examples
#' x <- c(aca1="acacaca", aca2="gaca", noaca="actgggca", na=NA)
#' regextr2(x, "(?<x>a)(?<y>cac?)")
#' gregextr2(x, "(?<x>a)(?<y>cac?)")
#' regextr2(x, "(?<x>a)(?<y>cac?)", capture_groups=TRUE)
#' gregextr2(x, "(?<x>a)(?<y>cac?)", capture_groups=TRUE)
#'
#' # substitution - note the different replacement strings:
#' `gregextr2<-`(x, "(?<x>a)(?<y>cac?)", value=list(c("!", "?"), "#"))
#' # references to capture groups can only be used in gsub and sub:
#' gsub2(x, "(?<x>a)(?<y>cac?)", "{$1}{$2}")
#'
#' regextr2(x, "(?<x>a)(?<y>cac?)") <- "\U0001D554\U0001F4A9"
#' print(x)  # x was modified 'in-place'
#'
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
    if (!is.character(x)) x <- as.character(x)
    stopifnot(is.logical(capture_groups) && length(capture_groups) == 1L && !is.na(capture_groups))

    if (capture_groups) {
        m <- regexec2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed)
        v <- gsubstrl(x, m, ignore_negative_length=FALSE)
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
    if (!is.character(x)) x <- as.character(x)
    stopifnot(is.logical(capture_groups) && length(capture_groups) == 1L && !is.na(capture_groups))

    if (capture_groups) {
        m <- gregexec2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed)
        v <- gsubstrl(x, m, ignore_negative_length=FALSE)  # some capture groups may be missing
        stopifnot(length(v) == length(m))
        for (i in seq_along(v)) {
            # length -1 => no-match
            v[[i]] <- structure(v[[i]], dim=dim(m[[i]]), dimnames=dimnames(m[[i]]))
            v[[i]] <- v[[i]][, attr(m[[i]], "match.length")[1, ] > 0, drop=FALSE]  # remove no-matches
        }
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
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    if (!is.character(value))   value <- as.character(value)

    # we need to vectorise x manually if value is the longest input
    if (length(x) == 0 || length(pattern) == 0 || length(value) == 0)
        x <- character(0)
    else if (length(value) > length(x))
        x <- `attributes<-`(rep(x, length.out=length(value)), NULL)  # drop all attribs, they must be take from value

    `substrl<-`(x, regexpr2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed), value=value)
}


#' @rdname gregextr
`gregextr2<-` <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE, value
) {
    if (!is.character(x))       x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    if (!is.list(value))        value <- as.list(value)

    # we need to vectorise x manually if value is the longest input
    if (length(x) == 0 || length(pattern) == 0 || length(value) == 0)
        x <- character(0)
    else if (length(value) > length(x))
        x <- `attributes<-`(rep(x, length.out=length(value)), NULL)  # drop all attribs, they must be take from value

    `gsubstrl<-`(x, gregexpr2(x, pattern, ..., ignore_case=ignore_case, fixed=fixed), value=value)
}

