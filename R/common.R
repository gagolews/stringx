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


# We are often outputting character vectors,
# hence, some assumptions are made below.

# If a function is vectorised wrt 2 arguments, it should
# preserve the attributes of both inputs (if of the same length).


# String functions: character vectors in, character vector out
# if !is.character on input, then converted with
# as.character() (note that the default method drops all attributes);
# the class designers themselves should define the semantics
# which attributes they would like to preserve.

# x <- list(
#     c(a="a", b="b"),
#     matrix(LETTERS[1:4], nrow=2, dimnames=list(c("a", "b"), c("x", "y"))),
#     ts(c(a="a", b="b")),
#     factor(c(a="a", b="b")),
#     c(a=1, b=2),
#     `names<-`(c(Sys.time(), Sys.time()+1), c("a", "b")),
#     as.POSIXlt(`names<-`(c(Sys.time(), Sys.time()+1), c("a", "b"))),
#     list(a="a", b=1:4),
#     data.frame(a=LETTERS, b=letters)
# )
# x <- lapply(x, function(e) `attr<-`(e, "attrib1", "value1"))
#
# sapply(x, is.character)
# lapply(x, function(e) as.character(e))
# lapply(x, function(e) attributes(as.character(e)))
# lapply(x, function(e) if (!is.character(e)) as.character(e) else e)
#
# if (!is.character(x))
#     x <- as.character(x)




# .as.character_without_some_attributes <- function(e, omit_attributes)
# {
#     `attributes<-`(
#         as.character(e),  # *should* drop all attributes, but there are exceptions..
#         `[<-`(attributes(e), omit_attributes, NULL)
#     )
# }


# .as.character.dangerous_objects <- function(e)
# {
#     # ts has not yet been tested
#     # s4 has not yet been tested
#
#     # matrices/arrays are fine - dim, dimnames - let them stay
#
#     if (is.factor(e)) {
#         # treat factors as character vectors,
#         # recover all attributes except class and levels
#         .as.character_without_some_attributes(e, c("class", "levels"))
#     }
#     else if (inherits(e, "POSIXlt")) {
#         # POSIXlt is a named list, but elem names are in the year field
#         structure(
#             .as.character_without_some_attributes(
#                 e,
#                 c("class", "tzone", "names")
#             ),
#             names=names(unclass(e)[["year"]])  # see names.POSIXlt, [[.POSIXlt
#         )
#     }
#     else if (inherits(e, "POSIXt") || inherits(e, "Date")) {
#         # e.g., Sys.Date() %x+% "aaa" will try to coerce back to Date, with an error
#         .as.character_without_some_attributes(e, c("class", "tzone"))
#     }
#     else if (is.data.frame(e))  {
#         # why are we even allowing this? LOL
#         .as.character_without_some_attributes(e, c("class", "row.names"))  # let names stay
#     }
#     else {
#         # otherwise, do nothing
#         e
#     }
# }




# R-ints: Scalar functions (those which operate element-by-element
# on a vector and whose output is similar to the input) should preserve
# attributes (except perhaps class, and if they do preserve class they need
# to preserve the OBJECT and S4 bits).


.attribs_propagate_unary <- function(ret, e)
{
    # TODO: rewrite in C

#    # it's all about lengths and attributes, fret not
#     e <- .as.character.dangerous_objects(e)

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

#     # it's all about lengths and attributes, fret not
#     e1 <- .as.character.dangerous_objects(e1)
#     e2 <- .as.character.dangerous_objects(e2)

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


.attribs_propagate_nary <- function(ret, ...)
{
    # TODO: rewrite in C

    if (length(ret) == 0) return(ret)

    aret <- list()
    for (e in rev(list(...))) {  # from right to left
        if (length(e) == length(ret)) {
            ae <- attributes(e)
            for (n in names(ae))
                aret[[n]] <- ae[[n]]  # left-most overwrite right-most ones
        }
    }
    mostattributes(ret) <- aret

    ret
}
