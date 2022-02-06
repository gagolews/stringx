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
#' Get Length or Width of Strings
#'
#' @description
#' \code{nchar} computes the number of code points, bytes used, or
#' estimated total width of strings in a character vector.
#' \code{nzchar} indicates which strings are empty.
#'
#' @details
#' String width might be useful when displaying text using a monospaced font.
#'
#'
#' @section Differences from Base R:
#' Replacement for base \code{\link[base]{nchar}} and \code{\link[base]{nzchar}}
#' implemented with \code{\link[stringi]{stri_length}},
#' \code{\link[stringi]{stri_width}},
#' \code{\link[stringi]{stri_numbytes}},
#' and \code{\link[stringi]{stri_isempty}}.
#'
#' \itemize{
#' \item \code{keepNA} does not default to \code{TRUE}, and hence
#'     missing values are treated as \code{"NA"} strings
#'     \bold{[fixed here]}
#' \item some emojis, combining characters and modifiers (e.g., skin tones)
#'    are not recognised properly
#'     \bold{[fixed here]}
#' \item only the \code{names} attribute is propagated
#'     \bold{[fixed here]}
#' }
#'
#'
#' @param x character vector or an object coercible to
#'
#' @param type \code{"chars"} gives the number of code points,
#'     \code{"width"} estimates the string width,
#'     \code{"bytes"} computes the number of bytes
#'
#' @param allowNA not used (with a warning if attempting to do so) [DEPRECATED]
#'
#' @param keepNA if \code{FALSE}, missing values will
#'     be treated as \code{"NA"} strings; otherwise, the corresponding outputs
#'     will be missing as well [DEPRECATED]
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
#' x <- c(
#'     "\U0001F4A9",
#'     "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
#'     "\U0001F64D\U0001F3FB\U0000200D\U00002642",
#'     "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
#'     "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
#' )
#' print(x)
#' base::nchar(x, "width")
#' stringx::nchar(x, "width")
#'
#'
#' @seealso
#' Related function(s): \code{\link{sprintf}}, \code{\link{substr}},
#'     \code{\link{strtrim}}
#'
#' @rdname nchar
nchar <- function(x, type="chars", allowNA=FALSE, keepNA=TRUE)
{
    if (!isFALSE(allowNA)) warning("argument `allowNA` has no effect in stringx")
    if (!is.character(x)) x <- as.character(x)

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


#' @rdname nchar
nzchar <- function(x, keepNA=TRUE)
{
    if (!is.character(x)) x <- as.character(x)
    ret <- !stringi::stri_isempty(x)

    if (isFALSE(keepNA) && length(ret) > 0)
        ret[is.na(ret)] <- TRUE

    .attribs_propagate_unary(ret, x)
}
