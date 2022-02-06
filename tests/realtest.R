# This file is part of the 'stringx' project.
# Copyleft (c) 2021-2022, Marek Gagolewski <https://www.gagolewski.com>

# Runs all unit tests for the package

this_package <- "stringx"

set.seed(123)
library(this_package, character.only=TRUE)
if (require("realtest", quietly=TRUE)) {
    f <- file.path(path.package(this_package), "realtest")
    r <- test_dir(f, ".*\\.R$")
    x <- summary(r)

    names(r) <- row.names(x)
    fails <- x[x[["match"]] == "fail", , drop=FALSE]
    if (nrow(fails) > 0) {
        fails2 <- as.data.frame(fails[,
            !(names(fails) %in% ".expr") & !sapply(fails, function(x) all(is.na(x))),
            drop=FALSE])
        for (i in row.names(fails2)) {
            cat(sprintf("%s:%d:\n", fails2[i, ".file"], fails2[i, ".line"]))
            cat("    value: "); str(r[[i]][["object"]][["value"]], indent.str="    ")
            cat("    sides: "); str(r[[i]][["object"]][["sides"]], indent.str="    ")
        }

        if (require("stringi", quietly=TRUE))
            cat(sprintf("%s; %s\n", stri_info(TRUE), Sys.getlocale()))

        stop("some tests failed")
    }
}
