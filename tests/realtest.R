# This file is part of the 'stringx' project.
# Copyleft (c) 2021, Marek Gagolewski <https://www.gagolewski.com>

# Runs all unit tests for the package

set.seed(123)
library("stringx")
if (require("realtest", quietly=TRUE)) {
    f <- file.path(path.package("stringx"), "realtest")
    r <- test_dir(f, ".*\\.R$")
    s <- summary(r)
    print(s)
    stopifnot(all(s[["match"]] != "fail"))
}
