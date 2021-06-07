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
#' Duplicate Strings
#'
#' @description
#' Concatenate a number of copies of each string.
#'
#' @details
#' Replacement for base \code{\link[base]{strrep}}
#' implemented with \code{\link[stringi]{stri_dup}}.
#'
#' Arguments are recycled if necessary.
#'
#' The \code{`\%x*\%`} mimics a vectorised version of Python's
#' \code{`*`} for strings (\code{str.__mul__}).
#'
#' Inconsistencies in base R (currently; we hope they will be fixed some day)
#' and the way we have addressed them here:
#'
#' \itemize{
#' \item missing values are (luckily) not treated as \code{"NA"} strings
#'     (as in base \code{\link[base]{paste}})
#'     \bold{[nothing to do]};
#' \item partial recycling with no warning "longer object length is not
#'     a multiple of shorter object length" \bold{[fixed here]};
#' \item base \code{strrep} seems to preserve only the \code{names} attribute,
#'     and only if the input is of type character
#'     (whilst \code{paste} preserves nothing)
#'     \bold{[fixed]};
#' \item overloading \code{`*.character`} has no effect in R, because S3
#'     method dispatch is done internally with hard-coded support for
#'     character arguments. We could have replaced the generic \code{`*`}
#'     with the one that calls \code{\link[base]{UseMethod}}, but
#'     it feels like a too intrusive solution
#'     \bold{[fixed by introducing \code{`\%x+\%`} operator]};
#' }
#'
#'
#' @param e1,x character vector (or an object coercible to)
#'     whose elements are to be duplicated
#'
#' @param e2,times numeric vector giving the number of times to repeat
#'     the corresponding strings
#'
#'
#' @return
#' A character vector (in UTF-8).
#'
#' \code{`\%x*\%`} and \code{strrep} preserve object attributes
#' in a similar way as other \link[base]{Arithmetic} operators.
#'
#'
#' @examples
#' x <- structure(c(A="a", B=NA, C="c"), attrib1="value1")
#' x %x*% 3
#' x %x*% 1:3
#' "a" %x*% 1:3
#' stringx::strrep(x, 3)
#' base::strrep(x, 3)
#' y <- matrix(1:6, nrow=2, dimnames=list(c("A", "B"), NULL))
#' y %x*% 1:2
#' stringx::strrep(y, 1:2)
#' base::strrep(y, 1:2)
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{sprintf}}
#'
#' @export
#' @rdname strrep
strrep <- function(x, times)
{
    ret <- stringi::stri_dup(x, times)
    .attribs_propagate_binary(ret, x, times)
}


#' @export
#' @rdname strrep
`%x*%` <- function(e1, e2)
{
    ret <- stringi::stri_dup(e1, e2)
    .attribs_propagate_binary(ret, e1, e2)
}
