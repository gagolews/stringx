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
#' Concatenate Strings
#'
#' @description
#' Concatenate (join) the corresponding/consecutive elements of
#' given vectors, after converting them to strings.
#'
#' \code{paste0(...)} is a synonym for \code{paste(..., sep="")}.
#'
#' @details
#' Replacement for base \code{\link[base]{paste}}
#' implemented with \code{\link[stringi]{stri_join}}.
#' These are the \pkg{stringi}'s equivalents of the built-in
#' \code{\link{paste}} function.
#' \code{stri_c} and \code{stri_paste} are aliases for \code{stri_join}.
#'
#' \code{paste} can be thought of as a string counterpart
#' of both the \code{`+`} operator (actually, some languages do have a binary
#' operator for string concatenation, e.g., \code{`.`} in PHP, \code{`+`}
#' in Python; R should have it too, but does not)
#' and the \code{\link[base]{sum}} function.
#' Therefore, we would expect it to behave similarly with regards
#' to the propagation of missing values and the preservation of object
#' attributes, but it does not.
#'
#' Inconsistencies in base R and the way we have addressed them here:
#' \itemize{
#' \item missing values treated as \code{"NA"} strings (it is a well-documented
#' feature though) [fixed here]
#' \item partial recycling with no warning "longer object length is not
#' a multiple of shorter object length" [fixed here]
#' \item empty vectors are treated as vectors of empty strings [fixed here]
#' \item input objects' attributes are not preserved [not fixed]
#' \item \code{paste0} multiplies entities without necessity;
#' \code{sep=""} should be the default in \code{paste} [not fixed]
#' \item \code{paste0} treats named argument \code{sep="..."} as one
#' more vector to concatenate [fixed by introducing \code{sep} argument]
#' \item There should be a binary operator for string concatenation
#' }
#'
#' It should also be noted that \code{paste} with {collapse=NULL} is a
#' special case of \code{sprintf} (which is featured in many programming
#' languages; R's version is of course vectorised).
#' For instance, \code{paste(x, y, sep=",")}
#' is equivalent to \code{sprintf("%s,%s", x, y)}.
#'
#' Taking into account the above, \code{paste} and \code{paste0} make little
#' sense. Here are our recommendations:
#' \itemize{
#' \item the most frequent use case - concatenating corresponding
#' strings from two character vectors with no separator - is covered
#' by a new operator \code{`%+%`} which propagates NAs correctly
#' and handles object attributes the same way as the built-in arithmetic
#' operators;
#' \item for fancy elementwise concatenation, use \code{sprintf};
#' \item for the 'flattening' of consecutive strings in a character vector
#' (like 'Reduce'), use the new function \code{strcat}.
#' }
#'
#'
#' @param e1,e2,... character vectors (or objects coercible to character vectors)
#' whose corresponding elements are to be concatenated
#  @param x character vector (or an object coercible to)
#' whose consecutive elements are to be concatenated
#' @param sep a single string; separates terms
#' @param collapse a single string or \code{NULL}; an optional
#' separator if tokens are to be merged into a single string
#' @param recycle0 a single logical value; if \code{FALSE}, then empty
#' vectors provided via \code{...} are silently ignored
#' @param na.rm a single logical value; if \code{TRUE}, missing values
#' are silently ignored
#'
#' @return Return a character vector (in UTF-8).
#'
#' @examples
#'
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
#' x %+% y1
#' x %+% y2
#' x %+% y3
#' y2 %+% x
#' x %+% character(0)
#' strcat(x, collapse=",")
#' strcat(x, collapse=",", na.rm=TRUE)
#'
#' @export
#' @rdname paste
#' @importFrom stringi stri_join
paste <- function(..., sep=" ", collapse=NULL, recycle0=FALSE)
{
    stri_join(..., sep=sep, collapse=collapse, ignore_null=!isTRUE(recycle0))
}


#' @export
#' @rdname paste
paste0 <- function(..., sep="", collapse=NULL, recycle0=FALSE)
{
    # note that base::paste0 has no `sep` argument
    paste(..., sep=sep, collapse=collapse, recycle0=recycle0)
}


#' @export
#' @rdname paste
`%+%` <- function(e1, e2) {
    if (is.factor(e1)) e1 <- as.character(e1)
    if (is.factor(e2)) e2 <- as.character(e2)
    # ts and s4 are currently not supported

    ret <- stringi::`%s+%`(e1, e2)

    if (length(ret) == 0) {
        ;  # do nothing
    } else if (length(e1) < length(e2)) {
        attributes(ret) <- attributes(e2)  # take attribs from longer (e2)
    }
    else if (length(e1) > length(e2)) {
        attributes(ret) <- attributes(e1)  # take attribs from longer (e1)
    }
    else { # if (length(e1) == length(e2))
        # either dimnames or names
        a2 <- attributes(e2)
        a1 <- attributes(e1)
        for (n in names(a1))
            a2[[n]] <- a1[[n]]
        mostattributes(ret) <- a2  # e.g., ignores names when there's dimnames
    }

    ret
}


#' @export
#' @rdname paste
strcat <- function(x, collapse="", na.rm=FALSE) {
    stringi::stri_flatten(
        x,
        collapse=collapse,
        na_empty=if (!isTRUE(na.rm)) FALSE else NA
    )
}
