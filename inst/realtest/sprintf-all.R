# OK: zero-length arguments result in empty vectors:
E(sprintf("%s", character(0)), character(0))
E(sprintf(character(0)), character(0))

# missing value as string "NA"
E(
    sprintf("%s", NA),
    NA_character_,
    bad="NA",
    comment="NA handling"
)

E(
    sprintf(NA_character_),
    NA_character_,
    bad="NA",
    comment="NA handling"
)


# UTF-8 number of bytes vs. Unicode code point width:
# help("sprintf") says: "Field widths and precisions of '%s' conversions
#    are interpreted as bytes, not characters, as described in the C standard."
E(
    nchar(sprintf("%8s", c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2", "\U0001f602\U0001f603")), "width"),
    c(8L, 8L, 8L, 8L, 8L),
    bad=c(8L, 7L, 7L, 6L, 4L),
    .comment="field widths as bytes vs. Unicode code point widths"
)

# partial recycling - error, not a warning:
E(
    sprintf("%d%d", 1:2, 1:3),
    P(c("11", "22", "13"), warning=TRUE),
    bad=c("11", "22", "13"),
    worst=P(error=TRUE),
    .comment="recycling rule warning"
)


E(
    nchar(sprintf(strrep(" ", 8192))),
    8192L,
    bad=P(error=TRUE),
    .comment="limit of 8192 bytes in base, no limit in stringx"
)

E(
    nchar(sprintf(strrep(" ", 8193))),
    8193L,
    bad=P(error=TRUE),
    .comment="limit of 8192 bytes in base, no limit in stringx"
)


# limit of 99 args passed via ..., no limit in stringx:
E(
    nchar(do.call(sprintf, as.list(c(strrep("%s", 99), rep("*", 99))))),
    99L,
    bad=P(error=TRUE),
    .comment="limit of 99 args passed via ..., no limit in stringx"
)

E(
    nchar(do.call(sprintf, as.list(c(strrep("%s", 100), rep("*", 100))))),
    100L,
    bad=P(error=TRUE),
    .comment="limit of 99 args passed via ..., no limit in stringx"
)




# all arguments are evaluated even if unused:
# (with a warning if unused)
# Considered OK only because I'm not a big fan of lazy evaluation ;)
# but this is somewhat inconsistent with other functions;
# however even unused args are taken into account when determining the output length
E(
    sprintf("don't use", {cat("used!"); "unused value"}),
    P("don't use", stdout=TRUE, warning=TRUE),
    .comment="unused arguments evaluated anyway, but they determine length"
)

E(
    length(sprintf(rep("%s", 10), 1:5, 1:20)),
    P(20L, warning=TRUE),
    .comment="unused arguments evaluated anyway, but they determine length"
)


E(
    sprintf("%d", c(-1.5, 1, 1.5)),
    c("-1", "1", "1"),
    bad=P(error=TRUE),
    .comment="'%d' acts selectively: it accepts numerics with fractional part of 0 only;
        'use format %f, %e, %g or %a for numeric objects' -- but it is numeric..."
)

# OK: coercion:
E(sprintf("%s", factor(11:12)), c("11", "12"))
E(sprintf("%d", factor(11:12)), c("1", "2"))


# coercion can only be done once:
t <- structure(0, class=c("POSIXct", "POSIXt"), tzone="GMT")
E(
    sprintf("%1$.0f %1$.4s", t),
    "0 1970",
    bad=P(error=TRUE),
    .comment="coercion can only be done once"
)
E(
    sprintf("%1$.4s %1$.0f", t),
    "1970 0",
    bad=P(error=TRUE),
    .comment="coercion can only be done once"
)


E(
    sprintf(c("%d", "%s"), factor(11:12)),
    c("1", "12"),
    bad=P(error=TRUE),
    .comment="coercion can only be done once"
)

E(
    sprintf(c("%s", "%d"), factor(11:12)),
    c("11", "2"),
    bad=P(error=TRUE),
    .comment="coercion can only be done once"
)


# two asterisks:
E(
    sprintf("%1$#- *2$.*3$f", 1.23456, 10, 3),
    " 1.235    ",
    bad=P(error=TRUE),
    .comment="two asterisks"
)


# reports invalid format, but glibc recognises it
E(
    sprintf("%0001$s", "s"),
    "s",
    bad=P(error=TRUE),
    .comment="reports invalid format, but glibc recognises it"
)

# controversial/questionable/whatever
E(
    sprintf(7),
    better="7",
    P(error=TRUE)
)


E(
    sprintf("%08s", "abcd"),
    "    abcd",
    worse="0000abcd",
    .comment="platform-dependent - may pad with zeros or spaces (according to the manual)"
)

# platform-dependent - %a, %x, %f, %g, %e, ... rely on the system std::sprintf
E(
    sprintf("%1$a %1$f %1$g %1$e %1$G %1$E %1$A", pi),
    "0x1.921fb54442d18p+1 3.141593 3.14159 3.141593e+00 3.14159 3.141593E+00 0X1.921FB54442D18P+1",
    worse=P("whatever", value_comparer=ignore_differences),
    bad=P(error=TRUE),
    .comment="can be platform-dependent..."
)


# glibc displays +NaN when sign is requested; space makes sense too, but base R omits it
# base::sprintf does not have na_string arg, but will ignore it, with a warning
E(
    sprintf("[%1$ -4.0f][%1$+-4.0f][%1$-4.0f]", c(-Inf, -0, 0, Inf, NaN, NA_real_), na_string="NA"),
        c("[-Inf][-Inf][-Inf]", "[-0  ][-0  ][-0  ]", "[ 0  ][+0  ][0   ]", "[ Inf][+Inf][Inf ]", "[ NaN][ NaN][NaN ]", "[ NA ][ NA ][NA  ]"),
    bad=P(c("[-Inf][-Inf][-Inf]", "[-0  ][-0  ][-0  ]", "[ 0  ][+0  ][0   ]", "[ Inf][+Inf][Inf ]", "[ NaN][NaN ][NaN ]", "[ NA ][NA  ][NA  ]"), warning=NA),
    .comment="glibc displays +NaN when sign is requested; space makes sense too, but base R omits it"
)

E(
    sprintf("[%1$ -4d][%1$+-4d][%1$-4d]", c(-1, 0, 1, NA_integer_), na_string="NA"),
        c("[-1  ][-1  ][-1  ]", "[ 0  ][+0  ][0   ]", "[ 1  ][+1  ][1   ]", "[ NA ][ NA ][NA  ]"),
    bad=P(c("[-1  ][-1  ][-1  ]", "[ 0  ][+0  ][0   ]", "[ 1  ][+1  ][1   ]", "[NA  ][NA  ][NA  ]"), warning=NA),
    .comment="glibc displays +NaN when sign is requested; space makes sense too, but base R omits it"
)




# no attributes preserved  (TODO???)
f <- structure(c(x="%s"), class="format", attrib1="val1")
x <- structure(c(a="1", b="2"), class="values", attrib2="val2")
E(
    sprintf(f, x),
    better=x,
    as.character(x),
    .comment="attribute preservation"
)


E(
    sprintf("%*s", NA_integer_, "abcdef"),
    NA_character_,
    bad="abcdef",
    bad="NA",
    bad=P(error=TRUE),
    .comment="missing value propagation"
)


E(
    sprintf("%.*s", NA_integer_, "abcdef"),
    NA_character_,
    bad="abcdef",
    bad="NA",
    bad=P(error=TRUE),
    .comment="missing value propagation"
)
