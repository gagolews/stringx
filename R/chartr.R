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
#' Transliteration and Other Text Transforms
#'
#' @description
#' Translate characters, including case mapping and folding,
#' script to script conversion, and Unicode normalisation.
#'
#' @details
#' Unlike their base R counterparts, the new \code{tolower} and
#' \code{toupper} are locale-sensitive;
#' see \code{stri_trans_tolower}.
#'
#' The base \code{casefold} simply dispatches to
#' \code{tolower} or \code{toupper}
#' 'for compatibility with S-PLUS' (that was only crucial long time ago).
#' The version implemented here, by default, performs the true case folding,
#' whose purpose is to make two pieces of text that differ only in case
#' identical, see \code{stri_trans_casefold}.
#'
#' The new \code{chartr} is a wrapper for
#' \code{\link[stringi]{stri_trans_char}}.
#' Contrary to the base \code{\link[base]{chartr}}, it always generates
#' a warning when \code{old} and \code{new} are of different lengths.
#'
#'
#' A new function \code{strtrans} applies ICU general transforms,
#' see \code{\link[stringi]{stri_trans_general}}.
#'
#' @param x character vector (or an object coercible to)
#'
#' @param old a single string
#'
#' @param new a single string, preferably of the same length as \code{old}
#'
#' @param upper single logical value; switches between case folding
#'    (the default, \code{NA}), lower-, and upper-case.
#'
#' @param transform a single string with ICU general transform
#'     specifier, see \code{\link[stringi]{stri_trans_list}}.
#'
#'
#' @return
#' A character vector (in UTF-8).
#'
#' These functions preserve most attributes of \code{x}.
#' Their base R counterparts drop all the attributes if not fed with character
#' vectors.
#'
#'
#' @examples
#' strtrans(strcat(letters_bf), "Any-NFKD; Any-Upper")
#' strtrans(strcat(letters_bb[1:6]), "Any-Hex/C")
#' strtrans(strcat(letters_greek), "Greek-Latin")
#'
#' toupper(letters_greek)
#' tolower(LETTERS_GREEK)
#'
#' base::toupper("gro\u00DF")
#' stringx::toupper("gro\u00DF")
#'
#' casefold("gro\u00DF")
#'
#' x <- as.matrix(c(a="\u00DFpam ba\U0001D554on spam", b=NA))
#' base::chartr("\u00DF\U0001D554aba", "SCXBA", x)
#' stringx::chartr("\u00DF\U0001D554aba", "SCXBA", x)
#'
#' @export
#' @rdname chartr
strtrans <- function(x, transform)
{
    ret <- stringi::stri_trans_general(x, transform)
    .attribs_propagate_unary(ret, x)
}


#' @export
#' @rdname chartr
chartr <- function(old, new, x)
{
    ret <- stringi::stri_trans_char(x, pattern=old, replacement=new)
    .attribs_propagate_unary(ret, x)
}


#' @export
#' @rdname chartr
tolower <- function(x)
{
    ret <- stringi::stri_trans_tolower(x, locale=NULL)
    .attribs_propagate_unary(ret, x)
}


#' @export
#' @rdname chartr
toupper <- function(x)
{
    ret <- stringi::stri_trans_toupper(x, locale=NULL)
    .attribs_propagate_unary(ret, x)
}


#' @export
#' @rdname chartr
casefold <- function(x, upper=NA)
{
    ret <- {
        if (isTRUE(upper)) stringx::toupper(x)
        else if (isFALSE(upper)) stringx::tolower(x)
        else stringi::stri_trans_casefold(x)
    }
    .attribs_propagate_unary(ret, x)
}
