% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/strsplit.R
\name{strsplit}
\alias{strsplit}
\title{Split Strings into Tokens}
\usage{
strsplit(
  x,
  pattern = split,
  ...,
  ignore_case = ignore.case,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  ignore.case = FALSE,
  split
)
}
\arguments{
\item{x}{character vector whose elements are to be examined}

\item{pattern}{character vector of nonempty search patterns}

\item{...}{further arguments to \code{\link[stringi]{stri_split}},
e.g., \code{omit_empty}, \code{locale}, \code{dotall}}

\item{ignore_case}{single logical value; indicates whether matching
should be case-insensitive}

\item{fixed}{single logical value;
\code{FALSE} for matching with regular expressions
    (see \link[stringi]{about_search_regex});
\code{TRUE} for fixed pattern matching
    (\link[stringi]{about_search_fixed});
\code{NA} for the Unicode collation algorithm
    (\link[stringi]{about_search_coll})}

\item{perl, useBytes}{not used (with a warning if
attempting to do so) [DEPRECATED]}

\item{ignore.case}{alias to the \code{ignore_case} argument [DEPRECATED]}

\item{split}{alias to the \code{pattern} argument [DEPRECATED]}
}
\value{
Returns a list of character vectors representing the identified tokens.
}
\description{
Splits each string into chunks delimited by occurrences of a given pattern.
}
\details{
This function is fully vectorised with respect to both arguments.

For splitting text into 'characters' (grapheme clusters), words,
or sentences, use \code{\link[stringi]{stri_split_boundaries}} instead.
}
\section{Differences from Base R}{

Replacements for base \code{\link[base]{strsplit}}
implemented with \code{\link[stringi]{stri_split}}.

\itemize{
\item base R implementation is not portable as it is based on
    the system PCRE or TRE library
    (e.g., some Unicode classes may not be available or matching thereof
    can depend on the current \code{LC_CTYPE} category
    \bold{[fixed here]}
\item not suitable for natural language processing
    \bold{[fixed here -- use \code{fixed=NA}]}
\item two different regular expression libraries are used
    (and historically, ERE was used in place of TRE)
    \bold{[here, \pkg{ICU} Java-like regular expression engine
    is only available, hence the \code{perl} argument has no meaning]}
\item there are inconsistencies between the argument order and naming
    in \code{\link[base]{grepl}}, \code{\link[base]{strsplit}},
    and \code{\link[base]{startsWith}} (amongst others); e.g.,
    where the needle can precede the haystack, the use of the forward
    pipe operator, \code{\link[base]{|>}}, is less convenient
    \bold{[fixed here]}
\item \code{\link[base]{grepl}} also features the \code{ignore.case} argument
    \bold{[added here]}
\item if \code{split} is a zero-length vector, it is treated as \code{""},
    which extracts individual code points (which is not the best idea
    for natural language processing tasks)
    \bold{[empty search patterns are not supported here, zero-length vectors
    are propagated correctly]}
\item last empty token is removed from the output, but first is not
    \bold{[fixed here -- see also the \code{omit_empty} argument]}
\item missing values in \code{split} are not propagated correctly
    \bold{[fixed here]}
\item partial recycling without the usual warning, not fully vectorised
    w.r.t. the \code{split} argument
    \bold{[fixed here]}
\item only the \code{names} attribute of \code{x} is preserved
    \bold{[fixed here]}
}
}

\examples{
stringx::strsplit(c(x="a, b", y="c,d,  e"), ",\\\\s*")
x <- strcat(c(
    "abc", "123", ",!.", "\U0001F4A9",
    "\U0001F64D\U0001F3FC\U0000200D\U00002642\U0000FE0F",
    "\U000026F9\U0001F3FF\U0000200D\U00002640\U0000FE0F",
    "\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007F"
))
# be careful when splitting into individual code points:
base::strsplit(x, "")  # stringx does not support this
stringx::strsplit(x, "(?s)(?=.)", omit_empty=TRUE)  # look-ahead for any char with dot-all
stringi::stri_split_boundaries(x, type="character")  # grapheme clusters

}
\seealso{
The official online manual of \pkg{stringx} at \url{https://stringx.gagolewski.com/}

Related function(s): \code{\link{paste}}, \code{\link{nchar}},
    \code{\link{grepl}}, \code{\link{gsub}}, \code{\link{substr}}
}
\author{
\href{https://www.gagolewski.com/}{Marek Gagolewski}
}
