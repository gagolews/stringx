source("common.R")

t <- ISOdate(2021, 05, 26)

# recycling rule, NA handling:
expect_identical(stringx::strftime(character(0)), base::strftime(character(0)))
expect_identical(stringx::strftime(NA_character_), base::strftime(NA_character_))
expect_identical(stringx::strftime(c("1970-01-01", NA), "%Y"), base::strftime(c("1970-01-01", NA), "%Y"))
expect_identical(stringx::strftime(factor(c("1970-01-01", NA)), "%Y"), base::strftime(factor(c("1970-01-01", NA)), "%Y"))
expect_identical(stringx::strftime(c("1970-01-01", NA), c("%Y-%m-%d", "%Y")), base::strftime(c("1970-01-01", NA), c("%Y-%m-%d", "%Y")))
expect_identical(stringx::strftime(c("1970-01-01"), c("%Y-%m-%d", "%Y")), base::strftime(c("1970-01-01"), c("%Y-%m-%d", "%Y")))

# no warning on partial recycling
expect_silent(base::strftime(c("1970-01-01", "2021-05-26"), c("%Y-%m-%d", "%Y", "%y")))
expect_warning(stringx::strftime(c("1970-01-01", "2021-05-26"), c("%Y-%m-%d", "%Y", "%y")))

# empty format not supported
expect_error(base::strftime(c("1970-01-01"), character(0)))  # incorrect
expect_identical(stringx::strftime(c("1970-01-01"), character(0)), character(0))

# default format not conforming to ISO 8601, in particular not displaying the current time zone
expect_identical(base::strftime(t), stringx::strftime(t, "%Y-%m-%d %H:%M:%S"))
expect_identical(stringx::strftime(t), base::strftime(t, "%Y-%m-%dT%H:%M:%S%z"))

# different calendar - easy with stringx:
# stringx::strftime(Sys.time(), locale="@calendar=hebrew")

# different locale - easy with stringx
# stringx::strftime(Sys.time(), "%A", locale="pl-PL")

# non-date-time inputs to str
expect_error(base::strftime(2021))  # uninformative error message
expect_error(stringx::strftime(2021))

# only names of x are preserved
f <- structure(c(x="%Y", y="%Y-%m-%d"), class="format", attrib1="val1")
x <- structure(c(a=t), attrib2="val2")
base::strftime(x, f)
stringx::strftime(x, f)
