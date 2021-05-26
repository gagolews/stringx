source("common.R")

# UTF-8 number of bytes vs. Unicode code point width:
# help("sprintf") says: "Field widths and precisions of '%s' conversions
#    are interpreted as bytes, not characters, as described in the C standard."
x <- c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2", "\U0001f602\U0001f603")
expect_equivalent(nchar(base::sprintf("%8s", x), "width"), c(8, 7, 7, 6, 4))
expect_equivalent(nchar(stringx::sprintf("%8s", x), "width"), c(8, 8, 8, 8, 8))

# OK: zero-length arguments result in empty vectors:
expect_identical(base::sprintf("%s", character(0)), character(0))
expect_identical(stringx::sprintf("%s", character(0)), character(0))
expect_identical(base::sprintf(character(0)), character(0))
expect_identical(stringx::sprintf(character(0)), character(0))

# missing value as string "NA"
expect_identical(base::sprintf("%s", NA), "NA")
expect_identical(stringx::sprintf("%s", NA), NA_character_)
expect_identical(stringx::sprintf("%s", NA, na_string="NA"), "NA")
expect_identical(base::sprintf(NA_character_), "NA")
expect_identical(stringx::sprintf(NA_character_), NA_character_)
expect_identical(stringx::sprintf(NA_character_, na_string="NA"), NA_character_)

# limit of 8192 bytes in base, no limit in stringx:
expect_equivalent(base::sprintf(strrep(" ", 8192)), strrep(" ", 8192))
expect_error(base::sprintf(strrep(" ", 8193)))
expect_equivalent(stringx::sprintf(strrep(" ", 2**24)), strrep(" ", 2**24))

# limit of 99 args passed via ..., no limit in stringx:
expect_equivalent(do.call(base::sprintf, as.list(c(strrep("%s", 99), rep("*", 99)))), strrep("*", 99))
expect_error(do.call(base::sprintf, as.list(c(strrep("%s", 100)))))
expect_equivalent(do.call(stringx::sprintf, as.list(c(strrep("%s", 9999), rep("*", 9999)))), strrep("*", 9999))

# partial recycling - error, not a warning:
expect_error(base::sprintf("%d%d", 1:2, 1:3))
expect_warning(stringx::sprintf("%d%d", 1:2, 1:3))

# all arguments are evaluated even if unused:
# (with a warning if unused)
# Considered OK only because I'm not a big fun of lazy evaluation ;)
# but this is somewhat inconsistent with other functions;
# however even unused args are taken into account when determining the output length
expect_stdout(suppressWarnings(base::sprintf("don't use", {cat("used!"); "unused value"})))
expect_stdout(suppressWarnings(stringx::sprintf("don't use", {cat("used!"); "unused value"})))
expect_warning(base::sprintf("don't use", "unused value"))
expect_warning(stringx::sprintf("don't use", "unused value"))
expect_equivalent(length(suppressWarnings(base::sprintf(rep("%s", 10), 1:5, 1:20))), 20)
expect_equivalent(length(suppressWarnings(stringx::sprintf(rep("%s", 10), 1:5, 1:20))), 20)

# "%d" acts selectively: it accepts numerics with fractional part of 0 only
# "use format %f, %e, %g or %a for numeric objects" -- but it is numeric...
expect_error(base::sprintf("%d", c(-1.5, 1, 1.5)))
expect_equivalent(stringx::sprintf("%d", c(-1.5, 1, 1.5)), c("-1", "1", "1"))

# OK: coercion:
expect_identical(base::sprintf("%s", factor(11:12)), c("11", "12"))
expect_identical(base::sprintf("%d", factor(11:12)), c("1", "2"))
expect_identical(stringx::sprintf("%s", factor(11:12)), c("11", "12"))
expect_identical(stringx::sprintf("%d", factor(11:12)), c("1", "2"))

# coercion can only be done once:
t <- structure(24*60*60, class=c("POSIXct", "POSIXt"))  # beware of local time zones
expect_identical(base::sprintf("%1$.0f %1$.4s", t), "86400 1970")
expect_error(base::sprintf("%1$s %1$.0f", t))
expect_identical(stringx::sprintf("%1$.0f %1$.4s", t), "86400 1970")
expect_identical(stringx::sprintf("%1$.4s %1$.0f", t), "1970 86400")

expect_error(base::sprintf(c("%d", "%s"), factor(11:12)))
expect_error(base::sprintf(c("%s", "%d"), factor(11:12)))
expect_identical(stringx::sprintf(c("%d", "%s"), factor(11:12)), c("1", "12"))
expect_identical(stringx::sprintf(c("%s", "%d"), factor(11:12)), c("11", "2"))

# two asterisks:
expect_error(base::sprintf("%1$#- *2$.*3$f", 1.23456, 10, 3))
expect_identical(stringx::sprintf("%1$#- *2$.*3$f", 1.23456, 10, 3), " 1.235    ")

# glibc displays +NaN when sign is requested; space makes sense too, but base R omits it
expect_identical(
    base::sprintf("[%1$ -4.0f][%1$+-4.0f][%1$-4.0f]", c(-Inf, -0, 0, Inf, NaN, NA_real_)),
    c("[-Inf][-Inf][-Inf]", "[-0  ][-0  ][-0  ]", "[ 0  ][+0  ][0   ]", "[ Inf][+Inf][Inf ]", "[ NaN][NaN ][NaN ]", "[ NA ][NA  ][NA  ]")
)
expect_identical(
    base::sprintf("[%1$ -4d][%1$+-4d][%1$-4d]", c(-1, 0, 1, NA_integer_)),
    c("[-1  ][-1  ][-1  ]", "[ 0  ][+0  ][0   ]", "[ 1  ][+1  ][1   ]", "[NA  ][NA  ][NA  ]")
)
expect_identical(
    stringx::sprintf("[%1$ -4.0f][%1$+-4.0f][%1$-4.0f]", c(-Inf, -0, 0, Inf, NaN, NA_real_), na_string="NA"),
    c("[-Inf][-Inf][-Inf]", "[-0  ][-0  ][-0  ]", "[ 0  ][+0  ][0   ]", "[ Inf][+Inf][Inf ]", "[ NaN][ NaN][NaN ]", "[ NA ][ NA ][NA  ]")
)
expect_identical(
    stringx::sprintf("[%1$ -4d][%1$+-4d][%1$-4d]", c(-1, 0, 1, NA_integer_), na_string="NA"),
    c("[-1  ][-1  ][-1  ]", "[ 0  ][+0  ][0   ]", "[ 1  ][+1  ][1   ]", "[ NA ][ NA ][NA  ]")
)

# reports invalid format, but glibc recognises it
expect_error(base::sprintf("%0001$s", "s"))
expect_equivalent(stringx::sprintf("%0001$s", "s"), "s")

# controversial/questionable/whatever
expect_error(base::sprintf(7))

# platform-dependent - may pad with zeros or spaces (according to the manual)
expect_identical(base::sprintf("%09s", month.name), base::sprintf("%9s", month.name))  # not necessarily always true
expect_identical(stringx::sprintf("%09s", month.name), stringx::sprintf("%9s", month.name))

# platform-dependent - %a, %x, %f, %g, %e, ... rely on the system std::sprintf
x <- "0x1.921fb54442d18p+1 3.141593 3.14159 3.141593e+00 3.14159 3.141593E+00 0X1.921FB54442D18P+1"
expect_identical(base::sprintf("%1$a %1$f %1$g %1$e %1$G %1$E %1$A", pi), x)  # not necessarily always true
expect_identical(stringx::sprintf("%1$a %1$f %1$g %1$e %1$G %1$E %1$A", pi), x)  # not necessarily always true   # TODO ??

# no attributes preserved
f <- structure(c(x="%s"), class="format", attrib1="val1")
x <- structure(c(a="1", b="2"), class="values", attrib2="val2")
expect_null(attributes(base::sprintf(f, x)))
expect_null(attributes(stringx::sprintf(f, x)))  # TODO ??
