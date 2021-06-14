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
#' Sort Strings
#'
#' @description
#' The \code{sort} method for objects of class \code{character}
#' (\code{sort.character}) uses the locale-sensitive Unicode collation
#' algorithm to arrange strings in a vector in a lexicographic order.
#' \code{xtfrm} (TODO: does anyone know what does this name stand for?)
#' generates an integer vector that sorts in the same way
#' as its input, and hence can be used in conjunction with
#' \code{\link[base]{order}} or \code{\link[base]{rank}}.
#'
#' @details
#' Replacements for the default S3 methods \code{\link[base]{sort}}
#' and \code{\link[base]{xtfrm}} for character vectors
#' implemented with \code{\link[stringi]{stri_sort}}
#' and \code{\link[stringi]{stri_rank}}.
#'
#' Inconsistencies in base R and the way we have addressed them here:
#'
#' \itemize{
#' \item Collation in different locales is difficult and non-portable across
#'     platforms
#'     \bold{[fixed here -- using services provided by ICU]}
#' \item Overloading \code{xtfrm.character} has no effect in R, because S3
#'     method dispatch is done internally with hard-coded support for
#'     character arguments. Thus, we needed to replace the generic
#'     \code{xtfrm} with the one that calls \code{\link[base]{UseMethod}}
#'     \bold{[fixed here]}
#' \item \code{xtfrm} does not support customisation of the linear ordering
#'     relation it is based upon
#'     \bold{[fixed by introducing \code{...} argument to the generic]}
#' \item Neither \code{\link[base]{order}}, \code{\link[base]{rank}}, nor
#'     \code{\link[base]{sort.list}} is a generic, therefore
#'     they should have to be rewritten from scratch to allow the inclusion of
#'     our patches; interestingly, \code{order} even calls \code{xtfrm},
#'     but only for classed objects
#'     \bold{[not fixed here -- see Examples for a workaround]}
#' \item \code{xtfrm} for objects of type \code{character}
#'     does not preserve the names attribute (but does so for \code{numeric})
#'     \bold{[fixed here]}
#' \item \code{sort} seems to preserve only the names attribute
#'     which makes sense if \code{na.last} is \code{NA}, because the resulting
#'     vector might be shorter
#'     \bold{[not fixed here as it would break compatibility with other
#'     sorting methods]}
#' \item Note that \code{sort} by default removes missing values whatsoever,
#'     whereas \code{\link[base]{order}} has \code{na.last=TRUE}
#'     \bold{[not fixed here as it would break compatibility with other
#'     sorting methods]}
#' }
#'
#'
#' @param x character vector whose elements are to be sorted
#'
#' @param decreasing single logical value; if \code{FALSE}, the ordering
#'     is nondecreasing (weakly increasing)
#'
#' @param na.last single logical value; if \code{TRUE}, then missing values
#'     are placed at the end; if \code{FALSE}, they are put at the beginning;
#'     if \code{NA}, then they are removed from the output whatsoever.
#'
#' @param ... further arguments passed to other methods
#'
#' @param locale see \code{\link[stringi]{stri_opts_collator}}
#' @param strength see \code{\link[stringi]{stri_opts_collator}}
#' @param alternate_shifted see \code{\link[stringi]{stri_opts_collator}}
#' @param french see \code{\link[stringi]{stri_opts_collator}}
#' @param uppercase_first see \code{\link[stringi]{stri_opts_collator}}
#' @param case_level see \code{\link[stringi]{stri_opts_collator}}
#' @param normalisation see \code{\link[stringi]{stri_opts_collator}}
#' @param numeric see \code{\link[stringi]{stri_opts_collator}}
#'
#'
#' @return
#' \code{sort.character} returns a character vector, with only
#' the \code{names} attribute preserved. Note that the output vector
#' may be shorter than the input one.
#'
#' \code{xtfrm.character} returns an integer vector;
#' most attributes are preserved.
#'
#'
#' @examples
#' x <- c("a1", "a100", "a101", "a1000", "a10", "a10", "a11", "a99", "a10", "a1")
#' base::sort.default(x)   # lexicographic sort
#' sort(x, numeric=TRUE)   # calls stringx:::sort.character
#' xtfrm(x, numeric=TRUE)  # calls stringx:::xtfrm.character
#'
#' rank(xtfrm(x, numeric=TRUE), ties.method="average")  # ranks with averaged ties
#' order(xtfrm(x, numeric=TRUE))    # ordering permutation
#' x[order(xtfrm(x, numeric=TRUE))] # equivalent to sort()
#'
#' # order a data frame w.r.t. decreasing ids and increasing vals
#' d <- data.frame(vals=round(runif(length(x)), 1), ids=x)
#' d[order(-xtfrm(d[["ids"]], numeric=TRUE), d[["vals"]]), ]
#'
#'
#' @seealso
#' Related function(s): \code{\link{strcoll}}
#'
#' @rdname sort
xtfrm <- function(x, ...) UseMethod("xtfrm")
# we need to overload the built-in C-level dispatcher
# because it only supports 1 argument and does not recognise
# the method overloaded for objects of class 'character'


#' @rdname sort
xtfrm.default <- function(x, ...) base::xtfrm.default(x)


#' @rdname sort
xtfrm.character <- function(
    x,
    locale=NULL,
    strength=3L,
    alternate_shifted=FALSE,
    french=FALSE,
    uppercase_first=NA,
    case_level=FALSE,
    normalisation=FALSE,
    numeric=FALSE,
    ...
) {
    if (!is.character(x)) x <- as.character(x)  # S3 generics, you do you
    ret <- stringi::stri_rank(
        x,
        locale=locale,
        strength=strength,
        alternate_shifted=alternate_shifted,
        french=french,
        uppercase_first=uppercase_first,
        case_level=case_level,
        normalisation=normalisation,
        numeric=numeric
    )
    .attribs_propagate_unary(ret, x)
}


#' @rdname sort
sort.character <- function(
    x,
    decreasing=FALSE,
    na.last=NA,
    locale=NULL,
    strength=3L,
    alternate_shifted=FALSE,
    french=FALSE,
    uppercase_first=NA,
    case_level=FALSE,
    normalisation=FALSE,
    numeric=FALSE,
    ...
) {
    if (!is.character(x)) x <- as.character(x)  # S3 generics, you do you

    idx <- stringi::stri_order(
        x,
        decreasing=decreasing,
        na_last=na.last,
        locale=locale,
        strength=strength,
        alternate_shifted=alternate_shifted,
        french=french,
        uppercase_first=uppercase_first,
        case_level=case_level,
        normalisation=normalisation,
        numeric=numeric
    )

    # only the names attribute will be preserved for compatibility
    # with sort methods for other classes
    x[idx]
}
