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
#' Shorten Strings to Specified Width
#'
#' @description
#' Right-trims strings so that they do not exceed a given width
#' (as determined by \code{\link[stringi]{stri_width}}).
#'
#' @details
#' Both arguments are recycled if necessary.
#'
#' Not to be confused with \code{\link{trimws}}.
#'
#' Might be useful when displaying strings using a monospaced font.
#'
#'
#' @section Differences from Base R:
#' Replacement for base \code{\link[base]{strtrim}}
#' implemented with (special case of) \code{\link[stringi]{stri_sprintf}}.
#'
#' \itemize{
#' \item both arguments are not recycled in an usual manner
#'     \bold{[fixed here]}
#' \item missing values are not allowed in \code{width}
#'     \bold{[fixed here]}
#' \item some emojis, combining characters and modifiers (e.g., skin tones)
#'    are not recognised properly \bold{[fixed here]}
#' \item attributes are only propagated from the 1st argument
#'     \bold{[fixed]}
#' }
#'
#'
#' @param x character vector
#'     whose elements are to be trimmed
#'
#' @param width numeric vector giving the widths to which the corresponding
#'    strings are to be trimmed
#'
#'
#' @return
#' Returns a character vector (in UTF-8).
#' Preserves object attributes
#' in a similar way as \link[base]{Arithmetic} operators.
#'
#'
#' @examples
#' base::strtrim("aaaaa", 1:3)
#' stringx::strtrim("aaaaa", 1:3)
#' x <- c(
#'     "\U0001F4A9",
#'     "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
#'     "\U0001F64D\U0001F3FB\U0000200D\U00002642",
#'     "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
#'     "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
#' )
#' print(x)
#' base::strtrim(x, 2)
#' stringx::strtrim(x, 2)
#'
#' @seealso
#' Related function(s): \code{\link{sprintf}}, \code{\link{substr}},
#'     \code{\link{nchar}}
#'
#' @rdname strtrim
strtrim <- function(x, width)
{
    if (!is.character(x)) x <- as.character(x)
    if (!is.numeric(width)) width <- as.numeric(width)
    ret <- stringi::stri_sprintf("%.*s", width, x, use_length=FALSE)
    .attribs_propagate_binary(ret, x, width)
}
