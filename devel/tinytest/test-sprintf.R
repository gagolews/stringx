source("common.R")

# UTF-8 number of bytes vs. Unicode code point width:
# help("sprintf") says: "Field widths and precisions of '%s' conversions
#    are interpreted as bytes, not characters, as described in the C standard."
x <- c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2", "\U0001f602\U0001f603")
expect_equivalent(nchar(base::sprintf("%8s", x), "width"), c(8, 7, 7, 6, 4))
expect_equivalent(nchar(stringx::sprintf("%8s", x), "width"), c(8, 8, 8, 8, 8))

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

# "%d" acts selectively: it accepts numerics with fractional part of 0 only
# "use format %f, %e, %g or %a for numeric objects" -- but it is numeric...
expect_error(base::sprintf("%d", c(-1.5, 1, 1.5)))
expect_equivalent(stringx::sprintf("%d", c(-1.5, 1, 1.5)), c("-1", "1", "1"))


# OK: zero-length arguments result in empty vectors:
expect_identical(base::sprintf("%s", character(0)), character(0))
expect_identical(stringx::sprintf("%s", character(0)), character(0))


# All arguments are evaluated even if unused:
# (with a warning if unused)
# Considered OK only because I'm not a big fun of lazy evaluation ;)
# but this is somewhat inconsistent with other functions
expect_stdout(suppressWarnings(base::sprintf("don't use", {cat("used!"); "unused value"})))
expect_stdout(suppressWarnings(stringx::sprintf("don't use", {cat("used!"); "unused value"})))
expect_warning(base::sprintf("don't use", "unused value"))
expect_warning(stringx::sprintf("don't use", "unused value"))

#' stringx::sprintf("UNIX time %1$f is %1$s.", Sys.time())
#'
#' # the following do not work in sprintf()
#' stringx::sprintf("%1$#- *2$.*3$f", 1.23456, 10, 3)  # two asterisks
#' stringx::sprintf(c("%s", "%f"), pi)  # re-coercion needed
#' stringx::sprintf("%1$s is %1$f UNIX time.", Sys.time())  # re-coercion needed
#' stringx::sprintf(c("%d", "%s"), factor(11:12))  # re-coercion needed
#' stringx::sprintf(c("%s", "%d"), factor(11:12))  # re-coercion needed





# number of arguments and string length limited

base::sprintf("%s", NA)  # missing value as string "NA"


# glibc displays +NaN when sign is requested; space makes sense too.
sprintf("[%1$ -4.0f][%1$+-4.0f][%1$-4.0f]", c(-Inf, -0, 0, Inf, NaN, NA_real_))
sprintf("[%1$ -4d][%1$+-4d][%1$-4d]", c(-1, 0, 1, NA_integer_))


sprintf("%+.0f", c(-Inf, -0, 0, Inf, NaN, NA_real_))
sprintf("% d", c(-1, 0, 1, NA_integer_)) # should be: [ ]NA
sprintf("%+d", c(-1, 0, 1, NA_integer_)) # should be: [+ ]NA

x <- c("xxabcd", "xx\u0105\u0106\u0107\u0108",
    "\u200b\u200b\u200b\u200b\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007Fabcd")
sprintf("%10s", x)

stringx::printf("[%10s]", x)
stringx::printf("[%-10.3s]", x)

stringx::sprintf("%4s=%.3f", c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2"), c(exp(1), exp(2), pi, pi^2))

# error - recycling, but should be a warning
sprintf(rep("%s", 10), 1:5, 1:13)

# somewhat controversial - unused argument (with a warning), but determines length
sprintf(rep("%s", 10), 1:5, 1:20)

# once converted to string, cannot be used as float afterwards
sprintf(c("%s", "%f"), pi)

sprintf("UNIX time %1$f is %1$s.", Sys.time())
sprintf("%1$s is %1$f UNIX time.", Sys.time())

sprintf("%s", factor(11:12)) # works
sprintf("%d", factor(11:12)) # works
sprintf(c("%d", "%s"), factor(11:12))  # error, converts to int only and then fails
sprintf(c("%s", "%d"), factor(11:12))  # error, converts to character only and then fails

sprintf("%0001$s", "s")  # invalid format, but glibc recognises it

sprintf("%1$#- *2$.*3$f", 1.23456, 10, 3)  # error: at most one asterisk * is supported in each conversion specification

sprintf(NA_character_, "this should yield 'NA'")  # "NA", but should be NA_character_
# (controversial, it's a format *string* after all) sprintf(NA, "this should yield NA")  # error, but should be NA_character_
# (controversial, it's a format *string* after all) sprintf(7) # error, why not "7" ?



f <- structure(c(x="%s", y="%s"), class="format", attrib1="val1")
x <- structure(c(a=1, b=2), class="values", attrib2="val2")
base::sprintf(f, x)  # no attributes preserved

# platform-dependent - may pad with zeros or spaces (according to the manual)
sprintf("%09s", month.name)
