# This file is part of the 'stringx' project.
# Copyright (c) 2021, Marek Gagolewski <https://www.gagolewski.com>
# All rights reserved.


library("tinytest")
library("stringx")

to_ascii <- function(x)
{
    stringi::stri_trans_general(x, "Any-NFKD; Any-ASCII")
}

sorted_attributes <- function(x)
{
    a <- attributes(suppressWarnings(x))
    if (is.null(a)) NULL
    else a[order(names(a))]
}
