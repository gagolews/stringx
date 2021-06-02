# This file is part of the 'stringx' project.
# Copyright (c) 2021, Marek Gagolewski <https://www.gagolewski.com>
# All rights reserved.

# Runs all unit tests for the package

set.seed(123)
library("realtest")
cat(stringi::stri_info(short=TRUE), "\n")


# tests of base R functions
cat("# base R\n")
results_base <- test_dir("devel/realtest", "-all\\.R$")
stopifnot(!isNamespaceLoaded("stringx"))  # assure string has not been loaded
s <- summary(results_base)
print(s)
stopifnot(sum(s[["match"]]=="fail") == 0)  # halt if there are failed tests

# tests of stringx
cat("# stringx\n")
suppressPackageStartupMessages(library("stringx"))
results_stringx <- test_dir("devel/realtest", "-all\\.R$")
stopifnot(isNamespaceLoaded("stringx"))
s <- summary(results_stringx)
print(s)
stopifnot(sum(s[["match"]]=="fail") == 0)  # halt if there are failed tests

# TODO - merge, compare side-by-side


# additional tests (features unavailable in base R)
cat("# stringx — extras\n")
results_stringx_extra <- test_dir("devel/realtest", "-stringx\\.R$")
s <- summary(results_stringx_extra)
print(s)
stopifnot(sum(s[["match"]]=="fail") == 0)  # halt if there are failed tests

