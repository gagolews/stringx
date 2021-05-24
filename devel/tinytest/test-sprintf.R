source("common.R")


# number of arguments and string length limited

sprintf("% .0f", c(-Inf, -0, 0, Inf, NaN, NA_real_))  # space NaN/NA - OK
sprintf("%+.0f", c(-Inf, -0, 0, Inf, NaN, NA_real_))  # should be: +NaN/NA (like in glibc) or <space>
sprintf("% d", c(-1, 0, 1, NA_integer_)) # should be: [ ]NA
sprintf("%+d", c(-1, 0, 1, NA_integer_)) # should be: [+ ]NA

x <- c("xxabcd", "xx\u0105\u0106\u0107\u0108",
    "\u200b\u200b\u200b\u200b\U0001F3F4\U000E0067\U000E0062\U000E0073\U000E0063\U000E0074\U000E007Fabcd")
sprintf("%10s", x)

stri_printf("[%10s]", x)
stri_printf("[%-10.3s]", x)

stri_sprintf("%4s=%.3f", c("e", "e\u00b2", "\u03c0", "\u03c0\u00b2"), c(exp(1), exp(2), pi, pi^2))

# error - recycling, but should be a warning
sprintf(rep("%s", 10), 1:5, 1:13)

# somewhat controversial - unused argument (with a warning), but determines length
sprintf(rep("%s", 10), 1:5, 1:20)

# only 100 arguments allowed
x <- as.list(as.character(1:100))
do.call(sprintf, c(strrep("%s,", length(x)), x))
# stringi has not have the 99 arg limit

# does not convert double to int
sprintf("%d", c(0, 0.5, 1, 1.5, 2))

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



sprintf(c(x="%s", y="%s"), c(a=1, b=2))  # no attributes preserved

# platform-dependent - may pad with zeros or spaces (according to the manual)
sprintf("%09s", month.name)
