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
#' Get Length or Width of Strings
#'
#' @description
#' \code{nchar} computes the number of code points, bytes used, or
#' estimated total width of strings in a character vector.
#' \code{nzchar} indicates which strings are empty.
#'
#' @details
#' Replacement for base \code{\link[base]{nchar}} and \code{\link[base]{nzchar}}
#' implemented with \code{\link[stringi]{stri_length}},
#' \code{\link[stringi]{stri_width}},
#' \code{\link[stringi]{stri_numbytes}},
#' and \code{\link[stringi]{stri_isempty}}
#'
#' Inconsistencies in base R
#' and the way we have addressed them here:
#'
#' \itemize{
#' \item \code{keepNA} does not default to \code{TRUE}, and hence
#'     missing values are treated as \code{"NA"} strings
#'     \bold{[fixed here]};
#' \item TODO: width... emoji of width 2, combining characters and modifiers (e.g., skin tones)
#'    recognised properly \bold{[fixed here]};
#' \item TODO: attributes?
#' }
#'
#'
#' @param x character vector or an object coercible to
#'
#' @param type \code{"chars"} gives the number of code points,
#'     \code{"width"} estimates the string width,
#'     \code{"bytes"} computes the number of bytes
#'
#' @param allowNA not used
#'
#' @param keepNA if \code{FALSE}, missing values will
#'     be treated as \code{"NA"} strings; otherwise, the corresponding outputs
#'     will be missing as well
#'
#'
#'
#' @return
#' \code{nchar} returns an integer vector.
#'
#' \code{nzchar} returns a logical vector, where \code{TRUE} indicates
#' that the corresponding string is of non-zero length (i.e., non-empty).
#'
#'
#' @examples
#' # dark skin tone flexed biceps:
#' base::nchar("\U0001F4AA\U0001F3FF", "width")
#' stringx::nchar("\U0001F4AA\U0001F3FF", "width")
#'
#'
#' @export
#' @rdname nchar
nchar <- function(x, type="chars", allowNA=FALSE, keepNA=TRUE)
{
    if (!isFALSE(allowNA)) warning("argument `allowNA` has no effect in stringx")
    if (!is.character(x)) x <- as.character(x)  # S3 generics, you do you

    ret <- if (identical(type, "chars"))
        stringi::stri_length(x)
    else if (identical(type, "width"))
        stringi::stri_width(x)
    else if (identical(type, "bytes"))
        stringi::stri_numbytes(x)
    else
        stop("invalid `type`")

    # note that we do not support keepNA == NA here
    if (isFALSE(keepNA) && length(ret) > 0)
        ret[is.na(ret)] <- 2L

    .attribs_propagate_unary(ret, x)
}


#' @export
#' @rdname nchar
nzchar <- function(x, keepNA=TRUE)
{
    if (!is.character(x)) x <- as.character(x)  # S3 generics, you do you
    ret <- !stringi::stri_isempty(x)

    if (isFALSE(keepNA) && length(ret) > 0)
        ret[is.na(ret)] <- TRUE

    .attribs_propagate_unary(ret, x)
}
