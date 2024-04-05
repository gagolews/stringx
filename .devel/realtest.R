# This file is part of the 'stringx' project.
# Copyleft (c) 2021-2024, Marek Gagolewski <https://www.gagolewski.com>

# Runs all unit tests for the package

set.seed(123)
library("realtest")
cat(stringi::stri_info(short=TRUE), "\n")


# --- custom failed test reporter ----------------------------------------------
print_colourised_matrix <- function(x, column_colours=character(0))
{
    x <- as.matrix(x)
    stopifnot(!is.null(dimnames(x)))
    row_names <- dimnames(x)[[1]]
    col_names <- dimnames(x)[[2]]
    stopifnot(!is.null(row_names))
    stopifnot(!is.null(col_names))


    y <- `[<-`(x, value="")
    colwidth <- max(stringx::nchar(col_names, "width"))+1
    for (j in seq_len(ncol(x))) {
        col <- column_colours[col_names[j]]
        if (is.na(col)) col <- ""
        y[, j][x[, j] != 0] <- stringx::sprintf("\033[%sm%*d\033[m", col, colwidth, x[, j][x[, j] != 0])
    }

    col0width <- max(stringx::nchar(row_names, "width"))+1
    cat(stringx::sprintf("%*s", col0width, ""), sep="")
    cat(stringx::sprintf("%*s", colwidth, col_names), sep="")
    cat("\n")
    for (i in seq_len(nrow(x))) {
        cat(stringx::sprintf("%*s", col0width, row_names[i]), sep="")
        cat(stringx::sprintf("%*s", colwidth, y[i, ]), sep="")
        cat("\n")
    }
}

realtest_report <- function(r, context="", ...)
{
    x <- summary(r, label_fail="fail")
    stopifnot(nrow(x) == length(r))
    names(r) <- row.names(x)

    stopifnot(is.data.frame(x))
    stopifnot(c("match") %in% names(x))

    x[["match"]] <- factor(
        x[["match"]],
        levels=c("best", "better", "good", "pass", "bad", "worse", "worst", "fail")
    )

    cat(sprintf("*** realtest [%s]: test summary:\n", context))
    print_colourised_matrix(
        table(basename(x[[".file"]]), x[["match"]]),
        column_colours=c("best"=32, "better"=32, "good"=32, "pass"="", "bad"=31, "worse"=31, "worst"=31, "fail"=41)
    )
    cat("\n")


    if (context != "base") {
        ugly <- c("bad", "worse", "worst")
        fails <- x[x[["match"]] %in% ugly, , drop=FALSE]
        if (nrow(fails) != 0) {
            cat(sprintf("*** realtest [%s]: the following expectations are ugly:\n", context))

            fails2 <- as.data.frame(fails[,
                !(names(fails) %in% ".expr") & !sapply(fails, function(x) all(is.na(x))),
                drop=FALSE])
            for (i in row.names(fails2)) {
                print(fails2[i, , drop=FALSE])
                cat("    value: "); str(r[[i]][["object"]][["value"]], indent.str="    ")
                cat("    sides: "); str(r[[i]][["object"]][["sides"]], indent.str="    ")
                cat("\n")
            }
            cat("\n")
        }
    }


    fails <- x[x[["match"]] == "fail", , drop=FALSE]
    if (nrow(fails) == 0) return(invisible(x))

    cat(sprintf("*** realtest [%s]: the following expectations are not met:\n", context))

    fails2 <- as.data.frame(fails[,
        !(names(fails) %in% ".expr") & !sapply(fails, function(x) all(is.na(x))),
        drop=FALSE])
    for (i in row.names(fails2)) {
        print(fails2[i, , drop=FALSE])
        cat("    value: "); str(r[[i]][["object"]][["value"]], indent.str="    ")
        cat("    sides: "); str(r[[i]][["object"]][["sides"]], indent.str="    ")
        cat("\n")
    }
    cat("\n")

    stop(sprintf("*** realtest [%s]: some tests failed; stopping", context), call.=FALSE)
}
# --- custom failed test reporter ----------------------------------------------



# tests of base R functions
cat("\n*** base R\n")
results_base <- test_dir("inst/realtest", "-all\\.R$")
realtest_report(results_base, context="base")
stopifnot(!("package:stringx" %in% search()))  # assure stringx has not been loaded

# tests of stringx
cat("\n*** stringx\n")
suppressPackageStartupMessages(library("stringx"))
results_stringx <- test_dir("inst/realtest", "-all\\.R$")
realtest_report(results_stringx, context="stringx")
stopifnot(length(results_base) == length(results_stringx))
stopifnot("package:stringx" %in% search())

# additional tests (features unavailable in base R)
cat("\n*** stringx — extras\n")
results_stringx_extra <- test_dir("inst/realtest", "-stringx\\.R$")
realtest_report(results_stringx_extra, context="stringx — extras")


# TODO - merge, compare side-by-side, even pass1 vs. different pass report different

# TODO: can it be better? is there anything to improve?

# TODO: those that have only default "pass" are not interesting - sanity checks/assertions

# TODO: severity/.priority: high/low/normal


