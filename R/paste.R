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
#' In some sense, \code{paste} can be thought of as a string counterpart
#' of both the \code{`+`} operator and the \code{\link[base]{sum}} function.
#' Therefore, we would expect it to behave similarly with regards
#' to the propagation of missing values and the preservation of object
#' attributes. Ideally, it would be nice to have two separate functions
#' (one acting elementwisely on a number of vectors, propagating NAs correctly,
#' and having \code{sep=""} by default)
#' and the other for merging all strings in a single vector
#' (with \code{collapse=""} by default and an additional \code{na.rm=FALSE}
#' argument).
#'
#' Inconsistencies in base R:
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
#' more vector to concatenate [fixed by introducing sep argument]
#' }
#'
#' @param ... character vectors (or objects coercible to character vectors)
#' whose corresponding elements are to be concatenated
#' @param sep a single string; separates terms
#' @param collapse a single string or \code{NULL}; an optional
#' separator if tokens are to be merged into a single string
#' @param recycle0 a single logical value; if \code{FALSE}, then empty
#' vectors provided via \code{...} are silently ignored
#'
#' @return Return a character vector (in UTF-8).
#'
#' @examples
#'
#' # behaviour of `+` vs. base::paste vs. stringx::paste
#' x <- structure(c(x=1, y=NA, z=100), F="*")
#' y1 <- structure(c(a=1, b=2), G="#", F="@")
#' y2 <- structure(c(a=1, b=2, c=3), G="#", F="@")
#' x + y1
#' x + y2
#' base::paste(x, y1)
#' base::paste(x, y2)
#' stringx::paste(x, y1)
#' stringx::paste(x, y2)
#' base::paste(x, character(0), y2, sep=",")
#' stringx::paste(x, character(0), y2, sep=",")
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
