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
#' Format Strings
#'
#' @description
#' \code{sprintf} creates strings from a given template and the arguments
#' provided. A new function (present in C and many other languages),
#' \code{printf}, displays formatted strings.
#'
#'
#' @details
#' Replacement for base \code{\link[base]{sprintf}}
#' implemented with \code{\link[stringi]{stri_sprintf}}.
#'
#' Note that the purpose of \code{printf} is to display a string, not
#' to create new ones for use elsewhere, therefore this function,
#' as an exception, treats missing values as \code{"NA"} strings.
#'
#'
#' Inconsistencies/limitations in base R and the way we have addressed them:
#'
#' \itemize{
#' \item missing values treated as \code{"NA"} strings
#'     \bold{[fixed in \code{sprintf}, left in \code{printf}, see the
#'     \code{na_string} argument]};
#' \item partial recycling results in an error
#'     \bold{[fixed here - warning given]};
#' \item input objects' attributes are not preserved
#'     \bold{[not fixed]};
#' \item field widths and precisions of string conversions are interpreted as
#'     bytes which is of course problematic for text in UTF-8
#'    \bold{[fixed by interpreting these as Unicode code point width]};
#' \item \code{fmt} is limited to 8192 bytes and the number of arguments
#'     passed via \code{...} to 99 (note that we can easily
#'     exceed this limit by using \code{\link[base]{do.call}})
#'     \bold{[rewritten from scratch, there is no limit anymore]};
#' \item Unused values in {...} are evaluated anyway (technically, what about
#'     lazy evaluation?), but at least a warning is given if this is the case
#'     \bold{[not fixed here because this is somewhat questionable;
#'     moreover, the length of the longest argument always
#'     determines the length of the output]};
#' ...
#' \item The format string is passed down the OS's 'sprintf' function, and
#'     incorrect formats can cause the latter to crash the R process .  R
#'     does perform sanity checks on the format, but not all possible
#'     user errors on all platforms have been tested, and some might be
#'     terminal.
#'     The coercion is done only once, so if 'length(fmt) > 1' then all
#'     elements must expect the same types of arguments.
#'  \item either width or precision from \code{...} - 2 asterisks
#'  \item coercion done only once
#'  \item NA/NaNs are not prefixed by signs even if requested to do so
#' }
#'
#'
#' @param fmt character vector of format strings
#'
#' @param ... vectors (coercible to integer, real, or character)
#'
#' @param na_string single string to represent missing values;
#'     if \code{NA}, missing values in \code{...}
#'     result in the corresponding outputs be missing too
#'
#' @param file see \code{\link[base]{cat}}
#'
#' @param sep see \code{\link[base]{cat}}
#'
#' @param append see \code{\link[base]{cat}}
#'
#'
#' @return
#' A character vector (in UTF-8).
#'
#' No attributes are preserved.
#'
#'
#' @examples
#' # UTF-8 number of bytes vs. Unicode code point width:
#' l <- c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2", "\U0001f602\U0001f603")
#' r <- c(exp(1), exp(2), pi, pi^2, NaN)
#' cat(base::sprintf("%8s=%+.3f", l, r), sep="\n")
#' cat(stringx::sprintf("%8s=%+.3f", l, r), sep="\n")
#'
#' # TODO: ...
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{strrep}}
#'
#' @export
#' @rdname sprintf
sprintf <- function(fmt, ..., na_string=NA_character_)
{
    stringi::stri_sprintf(
        fmt, ...,
        na_string=na_string, nan_string="NaN", inf_string="Inf",
        use_length=FALSE
    )
}


#' @export
#' @rdname sprintf
printf <- function(fmt, ..., file="", sep="\n", append=FALSE, na_string="NA")
{
    stringi::stri_printf(
        fmt, ..., file=file, sep=sep, append=append,
        na_string=na_string, nan_string="NaN", inf_string="Inf",
        use_length=FALSE
    )
}
