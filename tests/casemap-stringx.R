if (Sys.getenv("STRINGX_DO_NOT_LOAD") != "1") library("stringx")
library("realtest")

E(toupper('i', locale='en_US'), "I")
E(toupper('i', locale='tr_TR'), "\u0130")
