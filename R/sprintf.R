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


# TODO: %x$% operator?


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
#' Note that the purpose of \code{printf} is to display a string, not
#' to create a new one for use elsewhere, therefore this function,
#' as an exception, treats missing values as \code{"NA"} strings.
#'
#'
#' @section Differences from Base R:
#' Replacement for base \code{\link[base]{sprintf}}
#' implemented with \code{\link[stringi]{stri_sprintf}}.
#'
#' \itemize{
#' \item missing values in \code{...} are treated as \code{"NA"} strings
#'     \bold{[fixed in \code{sprintf}, left in \code{printf}, but see the
#'     \code{na_string} argument]}
#' \item partial recycling results in an error
#'     \bold{[fixed here -- warning given]}
#' \item input objects' attributes are not preserved
#'     \bold{[not fixed, somewhat tricky]}
#' \item in to-string conversions, field widths and precisions are
#'     interpreted as bytes which is of course problematic for text in UTF-8
#'    \bold{[fixed by interpreting these as Unicode code point widths]}
#' \item \code{fmt} is limited to 8192 bytes and the number of arguments
#'     passed via \code{...} to 99 (note that we can easily
#'     exceed this limit by using \code{\link[base]{do.call}})
#'     \bold{[rewritten from scratch, there is no limit anymore]}
#' \item unused values in {...} are evaluated anyway (should not evaluation be
#'     lazy?)
#'     \bold{[not fixed here because this is somewhat questionable;
#'     in both base R and our case, a warning is given if this is the case;
#'     moreover, the length of the longest argument always
#'     determines the length of the output]}
#' \item coercion of each argument can only be done once
#'     \bold{[fixed here - can coerce to integer, real, and character]}
#' \item either width or precision can be fetched from \code{...},
#'     but not both
#'     \bold{[fixed here - two asterisks are allowed in format specifiers]}
#' \item \code{NA}/\code{NaNs} are not prefixed by a sign/space even if
#'     we explicitly request this
#'     \bold{[fixed here - prefixed by a space]}
#' \item the outputs are implementation-dependent; the format strings
#'     are passed down to the system (\code{libc}) \code{sprintf} function
#'     \bold{[not fixed here (yet), but the format specifiers
#'     are normalised more eagerly]}
#' }
#'
#'
#' @param fmt character vector of format strings
#'
#' @param ... vectors with data to format
#'     (coercible to integer, real, or character)
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
#' \code{sprintf} returns a character vector (in UTF-8).
#' No attributes are preserved.
#' \code{printf} returns 'nothing'.
#'
#' @examples
#' # UTF-8 number of bytes vs. Unicode code point width:
#' l <- c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2", "\U0001f602\U0001f603")
#' r <- c(exp(1), exp(2), pi, pi^2, NaN)
#' cat(base::sprintf("%8s=%+.3f", l, r), sep="\n")
#' cat(stringx::sprintf("%8s=%+.3f", l, r), sep="\n")
#'
#' # coercion of the same argument to different types:
#' stringx::printf(c("UNIX time %1$f is %1$s.", "%1$s is %1$f UNIX time."),
#'     Sys.time())
#'
#' @seealso
#' Related function(s): \code{\link{paste}}, \code{\link{strrep}},
#' \code{\link{strtrim}}, \code{\link{substr}}, \code{\link{nchar}},
#' \code{\link{strwrap}}
#'
#' @rdname sprintf
sprintf <- function(fmt, ..., na_string=NA_character_)
{
    if (!is.character(fmt)) fmt <- as.character(fmt)  # S3 generics, you do you

    # args in `...` will be converted to integer, real, character depending on fmt
    # we don't do the 'if (is.xxx(x)) as.xxx(x)' thing here;
    # currently, stringi looks rather at typeof(x)=="xxx" though, so be careful

    stringi::stri_sprintf(
        fmt,
        ...,
        na_string=na_string,
        nan_string="NaN",
        inf_string="Inf",
        use_length=FALSE
    )
    # TODO: attributes?
}


#' @rdname sprintf
printf <- function(fmt, ..., file="", sep="\n", append=FALSE, na_string="NA")
{
    if (!is.character(fmt)) fmt <- as.character(fmt)  # S3 generics, you do you

    stringi::stri_printf(
        fmt,
        ...,
        na_string=na_string,
        nan_string="NaN",
        inf_string="Inf",
        use_length=FALSE
    )

    invisible(NULL)
}
