# kate: default-dictionary en_AU

## stringx package for R
## Copyleft (C) 2021-2023, Marek Gagolewski <https://www.gagolewski.com>
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
#' \code{regexpr2} and \code{gregexpr2} locate, respectively, first and all
#' (i.e., \bold{g}lobally) occurrences of a pattern.
#' \code{regexec2} and \code{gregexec2} can additionally
#' pinpoint the matches to parenthesised subexpressions (regex capture groups).
#'
#'
#' @details
#' These functions are fully vectorised with respect to both \code{x} and
#' \code{pattern}.
#'
#' Use \code{\link{substrl}} and \code{\link{gsubstrl}}
#' to extract or replace the identified chunks.
#' Also, consider using \code{\link{regextr2}} and
#' \code{\link{gregextr2}} directly instead.
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
#' \item \code{ignore.case=TRUE} cannot be used with \code{fixed=TRUE}
#'     \bold{[fixed here]}
#' \item no attributes are preserved
#'     \bold{[fixed here; see Value]}
#' \item in \code{regexec}, \code{match.length} attribute is unnamed
#'     even if the capture groups are (but \code{gregexec} sets dimnames
#'     of both start positions and lengths)
#'     \bold{[fixed here]}
#' \item \code{regexec} and \code{gregexec} with \code{fixed} other than
#'     \code{FALSE} make little sense.
#'     \bold{[this argument is [DEPRECATED] in \code{regexec2}
#'     and \code{gregexec2}]}
#' \item \code{gregexec} does not always yield a list of matrices
#'     \bold{[fixed here]}
#' \item a no-match to a conditional capture group is assigned length 0
#'     \bold{[fixed here]}
#' \item no-matches result in a single -1, even if capture groups are
#'     defined in the pattern
#'     \bold{[fixed here]}
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
#' @param ignore_case,ignore.case single logical value; indicates whether matching
#'     should be case-insensitive
#'
#' @param ... further arguments to \code{\link[stringi]{stri_locate}},
#'     e.g., \code{omit_empty}, \code{locale}, \code{dotall}
#'
#' @param text alias to the \code{x} argument [DEPRECATED]
#'
#' @param perl,useBytes not used (with a warning if
#'     attempting to do so) [DEPRECATED]
#'
#'
#' @return
#' \code{regexpr2} and [DEPRECATED] \code{regexpr} return an integer vector
#' which gives the start positions of the first substrings matching a pattern.
#' The \code{match.length} attribute gives the corresponding
#' match lengths. If there is no match, the two values are set to -1.
#'
#' \code{gregexpr2} and [DEPRECATED] \code{gregexpr} yield
#' a list whose elements are integer vectors with \code{match.length}
#' attributes, giving the positions of all the matches.
#' For consistency with \code{regexpr2}, a no-match is denoted with
#' a single -1, hence the output is guaranteed to consist of non-empty integer
#' vectors.
#'
#' \code{regexec2} and [DEPRECATED] \code{regexec} return
#' a list of integer vectors giving the positions of the first matches
#' and the locations of matches to the consecutive parenthesised subexpressions
#' (which can only be recognised if \code{fixed=FALSE}).
#' Each vector is equipped with the \code{match.length} attribute.
#'
#' \code{gregexec2} and [DEPRECATED] \code{gregexec} generate
#' a list of matrices, where each column corresponds to a separate match;
#' the first row is the start index of the match, the second row gives the
#' position of the first captured group, and so forth.
#' Their \code{match.length} attributes are matrices of corresponding sizes.
#'
#' These functions preserve the attributes of the longest inputs (unless they
#' are dropped due to coercion). Missing values in the inputs are propagated
#' consistently.
#'
#'
#' @examples
#' x <- c(aca1="acacaca", aca2="gaca", noaca="actgggca", na=NA)
#' regexpr2(x, "(A)[ACTG]\\1", ignore_case=TRUE)
#' regexpr2(x, "aca") >= 0  # like grepl2
#' gregexpr2(x, "aca", fixed=TRUE, overlap=TRUE)
#'
#' # two named capture groups:
#' regexec2(x, "(?<x>a)(?<y>cac?)")
#' gregexec2(x, "(?<x>a)(?<y>cac?)")
#'
#' # extraction:
#' gsubstrl(x, gregexpr2(x, "(A)[ACTG]\\1", ignore_case=TRUE))
#' gregextr2(x, "(A)[ACTG]\\1", ignore_case=TRUE)  # equivalent
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{strsplit}}, \code{\link{gsub2}},
#'     \code{\link{grepl2}}, \code{\link{gregextr2}}, \code{\link{gsubstrl}}
#'
#' @rdname gregexpr
regexpr2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_locate_first_coll(x, pattern, get_length=TRUE, ...)
            else
                stringi::stri_locate_first_coll(x, pattern, get_length=TRUE, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_locate_first_fixed(x, pattern, get_length=TRUE, case_insensitive=ignore_case, ...)
        } else {
            stringi::stri_locate_first_regex(x, pattern, get_length=TRUE, case_insensitive=ignore_case, ...)
        }
    }

    structure(  # as.integer will drop the "length"/"start" name
        .attribs_propagate_binary(as.integer(ret[, "start", drop=TRUE]), x, pattern),
        match.length=as.integer(ret[, "length", drop=TRUE])
    )
}


#' @rdname gregexpr
gregexpr2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_locate_all_coll(x, pattern, get_length=TRUE, ...)
            else
                stringi::stri_locate_all_coll(x, pattern, get_length=TRUE, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_locate_all_fixed(x, pattern, get_length=TRUE, case_insensitive=ignore_case, ...)
        } else {
            stringi::stri_locate_all_regex(x, pattern, get_length=TRUE, case_insensitive=ignore_case, ...)
        }
    }

    .attribs_propagate_binary(
        lapply(ret, function(e)
            structure(  # as.integer will drop the "length"/"start" name
                as.integer(e[, "start", drop=TRUE]),
                match.length=as.integer(e[, "length", drop=TRUE])
            )
        ),
        x, pattern
    )
}


#' @rdname gregexpr
regexec2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_locate_first_coll(x, pattern, get_length=TRUE, ...)
            else
                stringi::stri_locate_first_coll(x, pattern, get_length=TRUE, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_locate_first_fixed(x, pattern, get_length=TRUE, case_insensitive=ignore_case, ...)
        } else {
            NULL
        }
    }

    if (!is.null(ret)) {  # TODO: DEPRECATED case
        # there are definitely no capture groups

        # as.integer will drop the "length"/"start" name
        starts  <- as.integer(ret[, "start", drop=TRUE])
        lengths <- as.integer(ret[, "length", drop=TRUE])

        ret <- lapply(
            seq_along(starts),
            function(i) structure(
                starts[i],
                match.length=lengths[i]
            )
        )
    }
    else {
        # TODO: currently stri_locate_first_regex does not distinguish
        # between a non-existing capture group and a no-match to a capture
        # group in the case of many patterns

        # see stringi/#424

        # ret <- stringi::stri_locate_first_regex(x, pattern, get_length=TRUE, case_insensitive=ignore_case, capture_groups=TRUE, ...)
        #
        # cnames <- names(attr(ret, "capture_groups"))
        # if (!is.null(cnames)) cnames <- c("", cnames)
        # ret <- c(list(ret), attr(ret, "capture_groups"))
        #
        # starts <- do.call(rbind, lapply(ret, function(e) as.integer(e[, "start", drop=TRUE])))
        # lengths <- do.call(rbind, lapply(ret, function(e) as.integer(e[, "length", drop=TRUE])))
        #
        # ret <- lapply(
        #     seq_len(NCOL(starts)),
        #     function(i) structure(
        #         starts[, i],
        #         match.length=structure(lengths[, i], names=cnames),
        #         names=cnames
        #     )
        # )

        ret <- stringi::stri_locate_all_regex(x, pattern, get_length=TRUE, case_insensitive=ignore_case, capture_groups=TRUE, ...)

        ret <- lapply(ret, function(e) {
            cnames <- names(attr(e, "capture_groups"))
            if (!is.null(cnames)) cnames <- c("", cnames)
            structure(
                c(
                    as.integer(e[1L, "start", drop=TRUE]),
                    unlist(lapply(
                        attr(e, "capture_groups"),
                        function(e2) as.integer(e2[1L, "start", drop=TRUE])
                    ))
                ),
                match.length=structure(
                    c(
                        as.integer(e[1L, "length", drop=TRUE]),
                        unlist(lapply(
                            attr(e, "capture_groups"),
                            function(e2) as.integer(e2[1L, "length", drop=TRUE])
                        ))
                    ),
                    names=cnames
                ),
                names=cnames
            )
        })
    }

    .attribs_propagate_binary(ret, x, pattern)
}


#' @rdname gregexpr
gregexec2 <- function(
    x, pattern, ...,
    ignore_case=FALSE, fixed=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_locate_all_coll(x, pattern, get_length=TRUE, ...)
            else
                stringi::stri_locate_all_coll(x, pattern, get_length=TRUE, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_locate_all_fixed(x, pattern, get_length=TRUE, case_insensitive=ignore_case, ...)
        } else {
            NULL
        }
    }

    if (!is.null(ret)) {  # TODO: DEPRECATED case
        # there are definitely no capture groups

        ret <- lapply(
            ret,
            function(e) structure(  # as.integer will drop the "length"/"start" name
                as.integer(e[, "start", drop=TRUE]),
                match.length=structure(
                    as.integer(e[, "length", drop=TRUE]),
                    dim=c(1L, NROW(e))
                ),
                dim=c(1L, NROW(e))
            )
        )
    }
    else {
        ret <- stringi::stri_locate_all_regex(x, pattern, get_length=TRUE, case_insensitive=ignore_case, capture_groups=TRUE, ...)

        ret <- lapply(ret, function(e) {
            cnames <- names(attr(e, "capture_groups"))
            if (!is.null(cnames)) cnames <- c("", cnames)
            structure(
                do.call(rbind, c(
                    list(as.integer(e[, "start", drop=TRUE])),
                    lapply(
                        attr(e, "capture_groups"),
                        function(e2) as.integer(e2[, "start", drop=TRUE])
                    )
                )),
                match.length=structure(
                    do.call(rbind, c(
                        list(as.integer(e[, "length", drop=TRUE])),
                        lapply(
                            attr(e, "capture_groups"),
                            function(e2) as.integer(e2[, "length", drop=TRUE])
                        )
                    )),
                    dimnames=if (!is.null(cnames)) list(cnames, NULL) else NULL
                ),
                dimnames=if (!is.null(cnames)) list(cnames, NULL) else NULL
            )
        })
    }

    .attribs_propagate_binary(ret, x, pattern)
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
    regexpr2(x, pattern, ..., ignore_case=ignore.case, fixed=fixed)
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
    gregexpr2(x, pattern, ..., ignore_case=ignore.case, fixed=fixed)
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
    regexec2(x, pattern, ..., ignore_case=ignore.case, fixed=fixed)
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
    gregexec2(x, pattern, ..., ignore_case=ignore.case, fixed=fixed)
}
