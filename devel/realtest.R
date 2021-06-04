# This file is part of the 'stringx' project.
# Copyright (c) 2021, Marek Gagolewski <https://www.gagolewski.com>
# All rights reserved.

# Runs all unit tests for the package

set.seed(123)
library("realtest")
cat(stringi::stri_info(short=TRUE), "\n")


# tests of base R functions
cat("\n# base R\n")
Sys.setenv("STRINGX_DO_NOT_LOAD"="1")
results_base <- test_dir("tests", "-all\\.R$")
stopifnot(!("package:stringx" %in% search()))  # assure stringx has not been loaded
s <- summary(results_base)
print(s)
stopifnot(sum(s[["match"]]=="fail") == 0)  # halt if there are failed tests

# tests of stringx
cat("\n# stringx\n")
suppressPackageStartupMessages(library("stringx"))
results_stringx <- test_dir("tests", "-all\\.R$")
stopifnot("package:stringx" %in% search())
s <- summary(results_stringx)
print(s)
stopifnot(sum(s[["match"]]=="fail") == 0)  # halt if there are failed tests
stopifnot(length(results_base) == length(results_stringx))


# TODO - merge, compare side-by-side, even pass1 vs. different pass report different

# TODO - best > better > good > pass > bad > worse > worst > fail
# best1=best2>better>good1=good2>..

# TODO: can it be better? is there anything to improve?

# TODO: those that have only default "pass" are not interesting - sanity checks/assertions

# TODO: severity/.priority: high/low/normal




# additional tests (features unavailable in base R)
cat("\n# stringx — extras\n")
results_stringx_extra <- test_dir("tests", "-stringx\\.R$")
s <- summary(results_stringx_extra)
print(s)
stopifnot(sum(s[["match"]]=="fail") == 0)  # halt if there are failed tests

