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



# R-ints: Scalar functions (those which operate element-by-element
# on a vector and whose output is similar to the input) should preserve
# attributes (except perhaps class, and if they do preserve class they need
# to preserve the OBJECT and S4 bits).



.attribs_propagate_unary <- function(ret, e)
{
    # TODO: rewrite in C

    # treat factors as character vectors:
    if (is.factor(e)) e <- as.character(e)

    # ts has not yet been tested
    # s4 has not yet been tested

    mostattributes(ret) <- attributes(e)

    ret
}


# R-ints: Binary operations normally call copyMostAttrib to copy most
# attributes from the longer argument (and if they are of the same length
# from both, preferring the values on the first). Here 'most' means all
# except the names, dim and dimnames which are set appropriately by the
# code for the operator.



.attribs_propagate_binary <- function(ret, e1, e2)
{
    # TODO: rewrite in C

    # treat factors as character vectors:
    if (is.factor(e1)) e1 <- as.character(e1)
    if (is.factor(e2)) e2 <- as.character(e2)

    # ts has not yet been tested
    # s4 has not yet been tested

    # This is of course imperfect, as is the world we live in.
    # e.g., Sys.Date() %x+% "aaa" will try to coerce back to Date, with an error
    # use explicit coercion: as.character(Sys.Date()) %x+% "aaa"

    if (length(ret) == 0) {
        ;  # do nothing
    } else if (length(e1) < length(e2)) {
        mostattributes(ret) <- attributes(e2)  # take attribs from longer (e2)
    }
    else if (length(e1) > length(e2)) {
        mostattributes(ret) <- attributes(e1)  # take attribs from longer (e1)
    }
    else { # if (length(e1) == length(e2))
        a2 <- attributes(e2)
        a1 <- attributes(e1)
        for (n in names(a1))
            a2[[n]] <- a1[[n]]  # resolves duplicates
        mostattributes(ret) <- a2  # e.g., ignores names when there's dimnames
    }

    ret
}

