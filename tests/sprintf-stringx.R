if (Sys.getenv("STRINGX_DO_NOT_LOAD") != "1") library("stringx")
library("realtest")

E(sprintf("%s", NA, na_string="NA"), "NA")
E(sprintf(NA_character_, na_string="NA"), NA_character_)
