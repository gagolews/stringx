# This file is part of the 'stringx' project.
# Copyleft (c) 2021, Marek Gagolewski <https://www.gagolewski.com>

# Runs all unit tests for the package

this_package <- "stringx"

set.seed(123)
library(this_package, character.only=TRUE)
if (require("realtest", quietly=TRUE)) {
    f <- file.path(path.package(this_package), "realtest")
    r <- test_dir(f, ".*\\.R$")
    s <- summary(r)
    print(s)
    stopifnot(all(s[["match"]] != "fail"))
}
