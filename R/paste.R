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
#' Concatenate Strings
#'
#' @description
#' Concatenate (join) the corresponding and/or consecutive elements of
#' given vectors, after converting them to strings.
#'
#'
#' @details
#' \code{`\%x+\%`} is an operator that concatenates corresponding
#' strings from two character vectors (and which behaves just like
#' the arithmetic \code{`+`} operator).
#'
#' \code{strcat} joins (aggregates based on string concatenation)
#' consecutive strings in a character vector, possibly with
#' a specified separator in place, into a single string.
#'
#' \code{paste} and \code{paste0}, concatenate a number
#' of vectors using the same separator and then possibly join them into
#' a single string. We recommend using
#' \code{`\%x+\%`}, \code{\link{sprintf}}, and \code{strcat} instead
#' (see below for discussion).
#'
#'
#' @section Differences from Base R:
#' Replacement for base \code{\link[base]{paste}}
#' implemented with \code{\link[stringi]{stri_join}}.
#'
#' Note that \code{paste} can be thought of as a string counterpart
#' of both the \code{`+`} operator (actually, some languages do have a binary
#' operator for string concatenation, e.g., \code{`.`} in Perl and PHP,
#' \code{`+`} (\code{str.__add__}) in Python; R should have it too,
#' but does not) which is additionally vectorised ('Map') and the
#' \code{\link[base]{sum}} function ('Reduce').
#' Therefore, we would expect it to behave similarly with regards
#' to the propagation of missing values and the preservation of object
#' attributes, but it does not.
#'
#' \itemize{
#' \item missing values treated as \code{"NA"} strings (it is a well-documented
#'     feature though) \bold{[fixed here]}
#' \item partial recycling with no warning "longer object length is not
#'     a multiple of shorter object length" \bold{[fixed here]}
#' \item empty vectors are treated as vectors of empty strings
#'     \bold{[fixed here]}
#' \item input objects' attributes are not preserved
#'     \bold{[fixed only in \code{`\%x+\%`} operator]}
#' \item \code{paste0} multiplies entities without necessity;
#'     \code{sep=""} should be the default in \code{paste} \bold{[not fixed]}
#' \item \code{paste0} treats the named argument \code{sep="..."} as one
#'     more vector to concatenate
#'     \bold{[fixed by introducing \code{sep} argument]}
#' \item overloading \code{`+.character`} has no effect in R, because S3
#'     method dispatch is done internally with hard-coded support for
#'     character arguments. We could have replaced the generic \code{`+`}
#'     with the one that calls \code{\link[base]{UseMethod}}, but the
#'     dispatch would be done on the type of the first argument anyway
#'     (not to mention it feels like a too intrusive solution).
#'     Actually having a separate operator for concatenation (similar to
#'     PHP's or Perl's \code{`.`}) which always coerces to character
#'     frees the user from manual coercion (is it such a burden on the other
#'     hand?)
#'     \bold{[fixed by introducing \code{`\%x+\%`} operator]}
#' }
#'
#' It should also be noted that \code{paste} with \code{collapse=NULL} is a
#' special case of \code{sprintf} (which is featured in many programming
#' languages; R's version is of course vectorised).
#' For instance, \code{paste(x, y, sep=",")}
#' is equivalent to \code{sprintf("\%s,\%s", x, y)}.
#'
#' Taking into account the above, \code{paste} and \code{paste0} seem
#' redundant and hence we mark them as [DEPRECATED].
#' Here are our recommendations:
#'
#' \itemize{
#' \item the most frequent use case - concatenating corresponding
#'     strings from two character vectors with no separator - is covered
#'     by a new operator \code{`\%x+\%`} which propagates NAs correctly
#'     and handles object attributes the same way as the built-in arithmetic
#'     operators;
#' \item for fancy elementwise (like 'Map') concatenation,
#'     use our version of \code{\link{sprintf}};
#' \item for the 'flattening' of consecutive strings in a character vector
#'     (like 'Reduce'), use the new function \code{strcat}.
#' }
#'
#'
#' @param x character vector (or an object coercible to)
#'     whose consecutive elements are to be concatenated
#'
#' @param e1,e2 character vectors (or objects coercible to)
#'     whose corresponding elements are to be concatenated
#'
#' @param ... character vectors (or objects coercible to)
#'     whose corresponding/consecutive elements are to be concatenated
#'
#' @param sep single string; separates terms
#'
#' @param collapse single string or \code{NULL}; an optional
#'     separator if tokens are to be merged into a single string
#'
#' @param recycle0 single logical value; if \code{FALSE}, then empty
#'     vectors provided via \code{...} are silently ignored
#'
#' @param na.rm single logical value; if \code{TRUE}, missing values
#'     are silently ignored
#'
#'
#' @return
#' A character vector (in UTF-8).
#'
#' \code{`\%x+\%`} preserves object attributes in a similar way as
#' other \link[base]{Arithmetic} operators (however, they may be lost
#' during \code{as.character(...)} conversion, which is an S3 generic).
#'
#' \code{strcat} is an aggregation function, therefore it
#' preserves no attributes whatsoever.
#'
#' Currently, \code{paste} and \code{paste0} preserve no attributes too.
#'
#'
#' @examples
#' # behaviour of `+` vs. base::paste vs. stringx::paste
#' x <- structure(c(x=1, y=NA, z=100, w=1000), F="*")
#' y1 <- structure(c(a=1, b=2, c=3), G="#", F="@")
#' y2 <- structure(c(a=1, b=2, c=3, d=4), G="#", F="@")
#' y3 <- structure(1:4, G="#", F="@", dim=c(2, 2), dimnames=list(NULL, c("a", "b")))
#' x + y1
#' x + y2
#' x + y3
#' y2 + x
#' base::paste(x, y1)
#' base::paste(x, y2)
#' base::paste(x, y3)
#' stringx::paste(x, y1)
#' stringx::paste(x, y2)
#' stringx::paste(x, y3)
#' base::paste(x, character(0), y2, sep=",")
#' stringx::paste(x, character(0), y2, sep=",")
#' x %x+% y1
#' x %x+% y2
#' x %x+% y3
#' y2 %x+% x
#' x %x+% character(0)
#' strcat(x, collapse=",")
#' strcat(x, collapse=",", na.rm=TRUE)
#'
#'
#' @seealso
#' Related function(s): \code{\link{strrep}}, \code{\link{sprintf}}
#'
#' @rdname paste
paste <- function(..., sep=" ", collapse=NULL, recycle0=FALSE)
{
    args <- lapply(list(...), function(x) {
        if (!is.character(x)) as.character(x)
        else x
    })

    do.call(
        stringi::stri_join,
        c(args, list(sep=sep, collapse=collapse, ignore_null=!isTRUE(recycle0)))
    )
    # TODO: attributes?
}


#' @rdname paste
paste0 <- function(..., sep="", collapse=NULL, recycle0=FALSE)
{
    # note that base::paste0 has no `sep` argument
    stringx::paste(..., sep=sep, collapse=collapse, recycle0=recycle0)
}


#' @rdname paste
`%x+%` <- function(e1, e2)
{
    if (!is.character(e1)) e1 <- as.character(e1)
    if (!is.character(e2)) e2 <- as.character(e2)
    ret <- stringi::`%s+%`(e1, e2)
    .attribs_propagate_binary(ret, e1, e2)
}


#' @rdname paste
strcat <- function(x, collapse="", na.rm=FALSE) {
    if (!is.character(x)) x <- as.character(x)
    stringi::stri_flatten(
        x,
        collapse=collapse,
        na_empty=if (!isTRUE(na.rm)) FALSE else NA
    )
}
