# kate: default-dictionary en_AU

## stringx package for R
## Copyleft (C) 2021-2023, Marek Gagolewski <https://www.gagolewski.com/>
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
#' \code{sub2} replaces the first pattern occurrence in each string
#' with a given replacement string.
#' \code{gsub2} replaces all (i.e., 'globally') pattern matches.
#'
#' @details
#' Not to be confused with \code{\link{substr}}.
#'
#' These functions are fully vectorised with respect to \code{x},
#' \code{pattern}, and \code{replacement}.
#'
#' \code{gsub2} uses \code{vectorise_all=TRUE} because of the attribute
#' preservation rules, \code{\link[stringi]{stri_replace_all}} should be
#' called directly if different behaviour is needed.
#'
#' The [DEPRECATED] \code{sub} and [DEPRECATED] \code{gsub} simply call
#' \code{sub2} and \code{gsub2}
#' which have a cleaned-up argument list. Additionally,
#' if \code{fixed=FALSE}, the back-references in \code{replacement} strings
#' are converted to these accepted by the \pkg{ICU} regex engine.
#'
#' @section Differences from Base R:
#' Replacements for base \code{\link[base]{sub}} and \code{\link[base]{gsub}}
#' implemented with \code{\link[stringi]{stri_replace_first}}
#' and \code{\link[stringi]{stri_replace_all}}, respectively.
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
#' \item not vectorised w.r.t. \code{pattern} and \code{replacement}
#'     \bold{[fixed here]}
#' \item only 9 (unnamed) back-references can be referred to in the
#'     replacement strings
#'     \bold{[fixed in \code{sub2} and \code{gsub2}]}
#' \item \code{perl=TRUE} supports \code{\\U}, \code{\\L}, and \code{\\E}
#'     in the replacement strings
#'     \bold{[not available here]}
#' }
#'
#'
#' @param x character vector with strings whose chunks are to be modified
#'
#' @param pattern character vector of nonempty search patterns
#'
#' @param replacement character vector with the corresponding replacement
#'     strings; in \code{sub2} and \code{gsub2}, back-references
#'     (whenever \code{fixed=FALSE})
#'     are indicated by \code{$0}..\code{$99} and \code{$<name>},
#'     whereas the base-R compatible \code{sub} and \code{gsub},
#'     only allow \code{\\1}..\code{\\9}
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
#' @param ... further arguments to \code{\link[stringi]{stri_replace_first}}
#'     or \code{\link[stringi]{stri_replace_all}},
#'     e.g., \code{locale}, \code{dotall}
#'
#' @param perl,useBytes not used (with a warning if
#'     attempting to do so) [DEPRECATED]
#'
#'
#' @return
#' Both functions return a character vector.
#' They preserve the attributes of the longest inputs (unless they are
#' dropped due to coercion).
#'
#'
#' @examples
#' "change \U0001f602 me \U0001f603" |> gsub2("\\p{L}+", "O_O")
#'
#' x <- c("mario", "Mario", "M\u00E1rio", "M\u00C1RIO", "Mar\u00EDa", "Rosario", NA)
#' sub2(x, "mario", "M\u00E1rio", fixed=NA, strength=1L)
#' sub2(x, "mario", "Mario", fixed=NA, strength=2L)
#'
#' x <- "abcdefghijklmnopqrstuvwxyz"
#' p <- "(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)(.)"
#' base::sub(p, "\\1\\9", x)
#' base::gsub(p, "\\1\\9", x)
#' base::gsub(p, "\\1\\9", x, perl=TRUE)
#' base::gsub(p, "\\1\\13", x)
#' sub2(x, p, "$1$13")
#' gsub2(x, p, "$1$13")
#'
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{nchar}},
#'     \code{\link{grepl2}}, \code{\link{gregexpr2}}, \code{\link{gregextr2}}
#'     \code{\link{strsplit}}, \code{\link{gsubstr}}
#'
#' \code{\link{trimws}} for removing whitespaces (amongst others)
#' from the start or end of strings
#'
#'
#' @rdname gsub
sub2 <- function(
    x, pattern, replacement, ...,
    ignore_case=FALSE, fixed=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    if (!is.character(replacement)) replacement <- as.character(replacement)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_replace_first_coll(x, pattern, replacement, ...)
            else
                stringi::stri_replace_first_coll(x, pattern, replacement, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_replace_first_fixed(x, pattern, replacement, case_insensitive=ignore_case, ...)
        } else {
            stringi::stri_replace_first_regex(x, pattern, replacement, case_insensitive=ignore_case, ...)
        }
    }

    .attribs_propagate_nary(ret, x, pattern, replacement)
}


#' @rdname gsub
gsub2 <- function(
    x, pattern, replacement, ...,
    ignore_case=FALSE, fixed=FALSE
) {
    if (!is.character(x)) x <- as.character(x)
    if (!is.character(pattern)) pattern <- as.character(pattern)
    if (!is.character(replacement)) replacement <- as.character(replacement)
    stopifnot(is.logical(fixed) && length(fixed) == 1L)  # can be NA
    stopifnot(is.logical(ignore_case) && length(ignore_case) == 1L && !is.na(ignore_case))

    ret <- {
        if (is.na(fixed)) {
            if (!ignore_case)
                stringi::stri_replace_all_coll(x, pattern, replacement, vectorise_all=TRUE, ...)
            else
                stringi::stri_replace_all_coll(x, pattern, replacement, vectorise_all=TRUE, strength=2L, ...)
        } else if (fixed == TRUE) {
            stringi::stri_replace_all_fixed(x, pattern, replacement, vectorise_all=TRUE, case_insensitive=ignore_case, ...)
        } else {
            stringi::stri_replace_all_regex(x, pattern, replacement, vectorise_all=TRUE, case_insensitive=ignore_case, ...)
        }
    }

    .attribs_propagate_nary(ret, x, pattern, replacement)
}


# internal
.convert_replacement_icu <- function(r)
{
    if (!is.character(r)) r <- as.character(r)
    stringi::stri_replace_rstr(r)
}


#' @rdname gsub
sub <- function(
    pattern, replacement, x, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (isFALSE(fixed)) replacement <- .convert_replacement_icu(replacement)
    sub2(x, pattern, replacement, ..., ignore_case=ignore.case, fixed=fixed)
}


#' @rdname gsub
gsub <- function(
    pattern, replacement, x, ...,
    ignore.case=FALSE, fixed=FALSE,
    perl=FALSE, useBytes=FALSE
) {
    if (!isFALSE(perl)) warning("argument `perl` has no effect in stringx")
    if (!isFALSE(useBytes)) warning("argument `useBytes` has no effect in stringx")
    if (isFALSE(fixed)) replacement <- .convert_replacement_icu(replacement)
    gsub2(x, pattern, replacement, ..., ignore_case=ignore.case, fixed=fixed)
}
