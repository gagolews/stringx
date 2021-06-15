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
#' Extract or Replace Substrings
#'
#' @description
#' \code{substr} (deprecated synonym: \code{substring}) extracts
#' contiguous parts of given character strings.
#' Its replacement version allows for substituting them with new content.
#'
#' @details
#' Replacement for base \code{\link[base]{substr}}
#' and \code{\link[base]{substring}}
#' implemented with \code{\link[stringi]{stri_sub}}.
#'
#'
#' Inconsistencies in/differences from base R:
#'
#' \itemize{
#' \item \code{substring} is "for compatibility with S", but this should
#'     no longer matter
#'     \bold{[here, \code{substring} is equivalent to \code{substr}; in a
#'     future version, using the former may result in a warning]}
#' \item \code{substr} is not vectorised with respect to all the arguments
#'     (and \code{substring} is not fully vectorised wrt \code{value})
#'     \bold{[fixed here]}
#' \item not all attributes are taken form the longest of the inputs
#'     \bold{[fixed here]}
#' \item partial recycling with no warning
#'     \bold{[fixed here]}
#' \item if the replacement string of different length than the chunk
#'     being substituted, then
#'     \bold{[fixed here]}
#' \item negative indexes are silently treated as 1
#'     \bold{[changed here -- negative indexes count from the end of the string]}
#' \item replacement of different length than the extracted substring
#'     never changes the length of the string
#'     \bold{[changed here -- output length is input length minus
#'     length of extracted plus length of replacement]}
#' }
#'
#'
#' @param x,text character vector
#'     whose parts are to be extracted/replaced
#'
#' @param start,first numeric vector giving the start indexes;
#'     e.g., 1 points to the first code point, -1 to the last
#'
#' @param stop,last numeric vector giving the end indexes (inclusive);
#'     as with \code{start}, for negative indexes, counting starts at the end
#'     of each string; note that if the start position is farther than the
#'     end position, this indicates an empty substring therein (see Examples)
#'
#' @param value character vector defining the replacements strings
#'
#'
#' @return
#' \code{substr} returns a character vector (in UTF-8).
#' Its replacement version modifies \code{x} in-place (see Examples).
#'
#' The attributes are copied from the longest arguments (similarly
#' as in the case of binary operators).
#'
#' Note that these functions can break some meaningful Unicode code point
#' sequences, e.g., when inputs are not normalised. For extracting
#' initial parts of strings based on character width, see \code{\link{strtrim}}.
#'
#'
#' @examples
#' x <- "spam, spam, bacon, and spam"
#' base::substr(x, c(1, 13), c(4, 17))
#' base::substring(x, c(1, 13), c(4, 17))
#' stringx::substr(x, c(1, 13), c(4, 17))
#'
#' # replacement function used as an ordinary one - return a copy of x:
#' base::`substr<-`(x, 1, 4, value="jam")
#' stringx::`substr<-`(x, 1, 4, value="jam")
#' base::`substr<-`(x, 1, 4, value="porridge")
#' stringx::`substr<-`(x, 1, 4, value="porridge")
#'
#' # replacement function modifying x in-place:
#' stringx::substr(x, 1, 4) <- "eggs"
#' stringx::substr(x, 1, 0) <- "porridge, "        # prepend (start<stop)
#' stringx::substr(x, nchar(x)+1) <- " every day"  # append (start<stop)
#' print(x)
#'
#'
#' @seealso
#' Related function(s): \code{\link{strtrim}}, \code{\link{nchar}},
#'    \code{\link{startsWith}}, \code{\link{endsWith}}
#'
#' See also \code{\link[stringi]{stri_sub_all}} for replacing
#' multiple substrings within individual strings.
#'
#' @rdname substr
substr <- function(x, start=1L, stop=-1L)
{
    if (!is.character(x))   x <- as.character(x)  # S3 generics, you do you
    if (!is.numeric(start)) start <- as.numeric(start)
    if (!is.numeric(stop))  stop  <- as.numeric(stop)

    ret <- stringi::stri_sub(x, from=start, to=stop)
    .attribs_propagate_nary(ret, x, start, stop)
}

#' @rdname substr
substring <- function(text, first=1L, last=-1L)
{
    substr(x=text, start=first, stop=last)
}


#' @rdname substr
`substr<-` <- function(x, start=1L, stop=-1L, value)
{
    if (!is.character(x))     x     <- as.character(x)  # S3 generics, you do you
    if (!is.numeric(start))   start <- as.numeric(start)
    if (!is.numeric(stop))    stop  <- as.numeric(stop)
    if (!is.character(value)) value <- as.character(value)

    ret <- stringi::`stri_sub<-`(x, from=start, to=stop, omit_na=FALSE, value=value)
    .attribs_propagate_nary(ret, x, start, stop, value)
}


#' @rdname substr
`substring<-` <- function(text, first=1L, last=-1L, value)
{
    `substr<-`(x=text, start=first, stop=last, value=value)
}
