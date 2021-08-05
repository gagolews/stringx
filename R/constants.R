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



# letters_ascii <- c(
#     "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
#     "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
# )


# LETTERS_ASCII <- c(
#     "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
#     "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
# )


#' @title Character Constants
#'
#' @description
#' Letters and digits sets complementing the built-in
#' \code{LETTERS} and \code{letters}, see \link[base]{Constants}.
#'
#' @examples
#' letters_bb
#' letters_bf
#' letters_cal
#' letters_frak
#' letters_greek
#' LETTERS_BB
#' LETTERS_BF
#' LETTERS_CAL
#' LETTERS_FRAK
#' LETTERS_GREEK
#' digits_dec
#' digits_hex
#'
#' @description
#' Note: calling, e.g., \code{\link{tolower}} on \code{LETTERS_FRAK}
#' in the current version of \pkg{ICU} does not currently yield
#' \code{letters_frak}.
#'
#' @format Decimal digits
#' @rdname constants
digits_dec <- c(
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
)


#' @format Hexadecimal digits
#' @rdname constants
digits_hex <- c(
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "A", "B", "C", "D", "E", "F"
)


#' @format Greek letters (lower case)
#' @rdname constants
letters_greek <- c(
    "\u03B1", "\u03B2", "\u03B3", "\u03B4", "\u03B5", "\u03B6",
    "\u03B7", "\u03B8", "\u03B9", "\u03BA", "\u03BB", "\u03BC",
    "\u03BD", "\u03BE", "\u03BF", "\u03C0", "\u03C1", "\u03C3",
    "\u03C4", "\u03C5", "\u03C6", "\u03C7", "\u03C8", "\u03C9"
)


#' @format Greek letters (upper case)
#' @rdname constants
LETTERS_GREEK <- c(
    "\u0391", "\u0392", "\u0393", "\u0394", "\u0395", "\u0396",
    "\u0397", "\u0398", "\u0399", "\u039A", "\u039B", "\u039C",
    "\u039D", "\u039E", "\u039F", "\u03A0", "\u03A1", "\u03A3",
    "\u03A4", "\u03A5", "\u03A6", "\u03A7", "\u03A8", "\u03A9"
)


#' @format Blackboard bold English letters (lower case)
#' @rdname constants
letters_bb <- c(
    "\U0001D552", "\U0001D553", "\U0001D554", "\U0001D555",
    "\U0001D556", "\U0001D557", "\U0001D558", "\U0001D559",
    "\U0001D55A", "\U0001D55B", "\U0001D55C", "\U0001D55D",
    "\U0001D55E", "\U0001D55F", "\U0001D560", "\U0001D561",
    "\U0001D562", "\U0001D563", "\U0001D564", "\U0001D565",
    "\U0001D566", "\U0001D567", "\U0001D568", "\U0001D569",
    "\U0001D56A", "\U0001D56B"
)


#' @format Blackboard bold English letters (upper case)
#' @rdname constants
LETTERS_BB <- c(
    "\U0001D538", "\U0001D539", "\U00002102", "\U0001D53B",
    "\U0001D53C", "\U0001D53D", "\U0001D53E", "\U0000210D",
    "\U0001D540", "\U0001D541", "\U0001D542", "\U0001D543",
    "\U0001D544", "\U00002115", "\U0001D546", "\U00002119",
    "\U0000211A", "\U0000211D", "\U0001D54A", "\U0001D54B",
    "\U0001D54C", "\U0001D54D", "\U0001D54E", "\U0001D54F",
    "\U0001D550", "\U00002124"
)


#' @format Calligraphy (script) English letters (lower case)
#' @rdname constants
letters_cal <- c(
    "\U0001D4EA", "\U0001D4EB", "\U0001D4EC", "\U0001D4ED",
    "\U0001D4EE", "\U0001D4EF", "\U0001D4F0", "\U0001D4F1",
    "\U0001D4F2", "\U0001D4F3", "\U0001D4F4", "\U0001D4F5",
    "\U0001D4F6", "\U0001D4F7", "\U0001D4F8", "\U0001D4F9",
    "\U0001D4FA", "\U0001D4FB", "\U0001D4FC", "\U0001D4FD",
    "\U0001D4FE", "\U0001D4FF", "\U0001D500", "\U0001D501",
    "\U0001D502", "\U0001D503"
)


#' @format Calligraphy (script) English letters (upper case)
#' @rdname constants
LETTERS_CAL <- c(
    "\U0001D4D0", "\U0001D4D1", "\U0001D4D2", "\U0001D4D3",
    "\U0001D4D4", "\U0001D4D5", "\U0001D4D6", "\U0001D4D7",
    "\U0001D4D8", "\U0001D4D9", "\U0001D4DA", "\U0001D4DB",
    "\U0001D4DC", "\U0001D4DD", "\U0001D4DE", "\U0001D4DF",
    "\U0001D4E0", "\U0001D4E1", "\U0001D4E2", "\U0001D4E3",
    "\U0001D4E4", "\U0001D4E5", "\U0001D4E6", "\U0001D4E7",
    "\U0001D4E8", "\U0001D4E9"
)


#' @format Fraktur English letters (lower case)
#' @rdname constants
letters_frak <- c(
    "\U0001D586", "\U0001D587", "\U0001D588", "\U0001D589",
    "\U0001D58A", "\U0001D58B", "\U0001D58C", "\U0001D58D",
    "\U0001D58E", "\U0001D58F", "\U0001D590", "\U0001D591",
    "\U0001D592", "\U0001D593", "\U0001D594", "\U0001D595",
    "\U0001D596", "\U0001D597", "\U0001D598", "\U0001D599",
    "\U0001D59A", "\U0001D59B", "\U0001D59C", "\U0001D59D",
    "\U0001D59E", "\U0001D59F"
)


#' @format Fraktur English letters (upper case)
#' @rdname constants
LETTERS_FRAK <- c(
    "\U0001D56C", "\U0001D56D", "\U0001D56E", "\U0001D56F",
    "\U0001D570", "\U0001D571", "\U0001D572", "\U0001D573",
    "\U0001D574", "\U0001D575", "\U0001D576", "\U0001D577",
    "\U0001D578", "\U0001D579", "\U0001D57A", "\U0001D57B",
    "\U0001D57C", "\U0001D57D", "\U0001D57E", "\U0001D57F",
    "\U0001D580", "\U0001D581", "\U0001D582", "\U0001D583",
    "\U0001D584", "\U0001D585"
)


#' @format Bold English letters (lower case)
#' @rdname constants
letters_bf <- c(
    "\U0001D41A", "\U0001D41B", "\U0001D41C", "\U0001D41D",
    "\U0001D41E", "\U0001D41F", "\U0001D420", "\U0001D421",
    "\U0001D422", "\U0001D423", "\U0001D424", "\U0001D425",
    "\U0001D426", "\U0001D427", "\U0001D428", "\U0001D429",
    "\U0001D42A", "\U0001D42B", "\U0001D42C", "\U0001D42D",
    "\U0001D42E", "\U0001D42F", "\U0001D430", "\U0001D431",
    "\U0001D432", "\U0001D433"
)


#' @format Bold English letters (upper case)
#' @rdname constants
LETTERS_BF <- c(
    "\U0001D400", "\U0001D401", "\U0001D402", "\U0001D403",
    "\U0001D404", "\U0001D405", "\U0001D406", "\U0001D407",
    "\U0001D408", "\U0001D409", "\U0001D40A", "\U0001D40B",
    "\U0001D40C", "\U0001D40D", "\U0001D40E", "\U0001D40F",
    "\U0001D410", "\U0001D411", "\U0001D412", "\U0001D413",
    "\U0001D414", "\U0001D415", "\U0001D416", "\U0001D417",
    "\U0001D418", "\U0001D419"
)
