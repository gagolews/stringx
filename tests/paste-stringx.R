if (Sys.getenv("STRINGX_DO_NOT_LOAD") != "1") library("stringx")
library("realtest")

E(strcat(structure(c(x=1, y=NA, z=100), attrib1="value1"), collapse=","), NA_character_)
E(strcat(structure(c(x=1, y=NA, z=100), attrib1="value1"), collapse=",", na.rm=TRUE), "1,100")

E(1:10 %x+% numeric(0), character(0))
E(NULL %x+% 1:10, character(0))

x <- structure(c(x=1, y=NA, z=100, w=1000), attrib1="value1", class="foo")
y1 <- structure(c(a=1, b=2), attrib2="value2", attrib1="value7")
y2 <- structure(c(a=1, b=2, c=3, d=4), attrib2="value2", attrib1="value7")
y3 <- matrix(1:4, nrow=2, dimnames=list(c("ROW1", "ROW2"), c("COL1", "COL2")))

E(attributes(x %x+% character(0)), NULL)

E(x %x+% y1, `attributes<-`(paste0(x, y1), attributes(x + y1)))
E(x %x+% y2, `attributes<-`(paste0(x, y2), attributes(x + y2)))
E(x %x+% y3, `attributes<-`(paste0(x, y3), attributes(x + y3)))

E(y1 %x+% x, `attributes<-`(paste0(y1, x), attributes(y1 + x)))
E(y2 %x+% x, `attributes<-`(paste0(y2, x), attributes(y2 + x)))
E(y3 %x+% x, `attributes<-`(paste0(y3, x), attributes(y3 + x)))

E(x %x+% as.vector(y1), `attributes<-`(paste0(x, as.vector(y1)), attributes(x + as.vector(y1))))
E(x %x+% as.vector(y2), `attributes<-`(paste0(x, as.vector(y2)), attributes(x + as.vector(y2))))
E(x %x+% as.vector(y3), `attributes<-`(paste0(x, as.vector(y3)), attributes(x + as.vector(y3))))

E(as.vector(y1) %x+% x, `attributes<-`(paste0(as.vector(y1), x), attributes(as.vector(y1) + x)))
E(as.vector(y2) %x+% x, `attributes<-`(paste0(as.vector(y2), x), attributes(as.vector(y2) + x)))
E(as.vector(y3) %x+% x, `attributes<-`(paste0(as.vector(y3), x), attributes(as.vector(y3) + x)))

E(as.Date(ISOdate(2021, 6, 4)) %x+% 99, "2021-06-0499")

