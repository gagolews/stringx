if (Sys.getenv("STRINGX_DO_NOT_LOAD") != "1") library("stringx")
library("realtest")

t <- ISOdate(2021, 05, 27)

# different calendar/locale - easy with stringx:

E(
    strftime(t, "%Y", locale="@calendar=hebrew"),
    "5781"
)

E(
    strftime(t, "%A", locale="pl-PL"),
    "czwartek"
)

E(
    strftime(t, "%A", locale="de-DE"),
    "Donnerstag"
)
