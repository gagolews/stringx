# This file is part of the 'stringx' project.
# Copyright (c) 2021, Marek Gagolewski <https://www.gagolewski.com>
# All rights reserved.


library("tinytest")
library("stringx")

toascii <- function(x, substitute="\u001a")
{
    stringi::stri_replace_all_charclass(
        stringi::stri_trans_general(x, "Any-NFKD; Any-Latin; Latin-ASCII"),
        "[^\\u0001-\\u007f]", substitute
    )
}

sorted_attributes <- function(x)
{
    a <- attributes(suppressWarnings(x))
    if (is.null(a)) NULL
    else a[order(names(a))]
}
