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
#' Word-Wrap Text
#'
#' @description
#' Splits each string into words which are then arranged to form text lines
#' of mo more than a given width.
#'
#' @details
#' Might be useful when displaying strings using a monospaced font.
#'
#' @section Differences from Base R:
#' Replacement for base \code{\link[base]{strwrap}}
#' implemented with \code{\link[stringi]{stri_wrap}}.
#'
#' \itemize{
#' \item missing values not propagated
#'     \bold{[fixed here]}
#' \item some emojis, combining characters and modifiers (e.g., skin tones)
#'    are not recognised properly
#'     \bold{[fixed here]}
#' \item what is considered a word does not depend on locale
#'     \bold{[fixed here - using \pkg{ICU}'s word break iterators]}
#' \item multiple whitespaces between words are not preserved except after
#'     a dot, question mark, or exclamation mark,
#'     which leads to two spaces inserted
#'     \bold{[changed here -- any sequence of whitespaces considered
#'     word boundaries is converted to a single space]}
#' \item a greedy word wrap algorithm is used, which may lead to high
#'     raggedness
#'     \bold{[fixed here -- using the Knuth-Plass method]}
#' }
#'
#'
#' @param x character vector whose elements are to be word-wrapped
#'
#' @param width single integer; maximal total width of the code points
#'     per line (as determined by \code{\link[stringi]{stri_width}})
#'
#' @param indent single integer; first line indentation size
#'
#' @param exdent single integer; consequent lines indentation size
#'
#' @param prefix single string; prefix for each line except the first
#'
#' @param initial single string; prefix for the first line
#'
#' @param simplify see Value
#'
#' @param locale \code{NULL} or \code{""} for the default locale
#'    (see \code{\link[stringi]{stri_locale_get}})
#'    or a single string with a locale identifier,
#'    see \code{\link[stringi]{stri_locale_list}}
#'
#'
#' @return
#' If \code{simplify} is \code{FALSE}, a list of \code{length(x)} numeric
#' vectors is returned.
#'
#' Otherwise, the function yields a character vector (in UTF-8).
#' Note that the length of the output may be different
#' than that of the input.
#'
#' Due to this, no attributes are preserved.
#'
#'
#' @references
#' D.E. Knuth, M.F. Plass,
#' Breaking paragraphs into lines,
#' \emph{Software: Practice and Experience} 11(11),
#' 1981, pp. 1119--1184.
#'
#'
#' @examples
#' strwrap(paste0(
#'     strrep("az ", 20),
#'     strrep("\u0105\u20AC ", 20),
#'     strrep("\U0001F643 ", 20),
#'     strrep("\U0001F926\U0000200D\U00002642\U0000FE0F ", 20)
#' ), width=60)
#'
#'
#' @seealso
#' Related function(s): \code{\link{sprintf}}, \code{\link{trimws}},
#' \code{\link{nchar}}
#'
#' @rdname strwrap
strwrap <- function(
    x,
    width=0.9*getOption("width"),
    indent=0,
    exdent=0,
    prefix="",
    simplify=TRUE,
    initial=prefix,
    locale=NULL
) {
    if (!is.character(x)) x <- as.character(x)

    ret <- stringi::stri_wrap(
        x,
        width=width,
        indent=indent,
        exdent=exdent,
        prefix=prefix,
        simplify=simplify,
        initial=initial,
        locale=locale,
        cost_exponent=2.0,
        normalise=TRUE,
        whitespace_only=FALSE,
        use_length=FALSE
    )

    # we are not going to propagate any attributes, because
    # the length of the output may be different than the length of the input
    #if (isTRUE(simplify)) .attribs_propagate_unary(ret, x)

    ret
}
