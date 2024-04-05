E(strcat(structure(c(x=1, y=NA, z=100), attrib1="value1"), collapse=","), NA_character_)
E(strcat(structure(c(x=1, y=NA, z=100), attrib1="value1"), collapse=",", na.rm=TRUE), "1,100")

E(1:10 %x+% numeric(0), character(0))
E(NULL %x+% 1:10, character(0))

as.character <- function(x) UseMethod("as.character")
as.character.numeric <- function(x) `attributes<-`(as.character.default(x), attributes(x))

x  <- structure(c(x=1, y=NA, z=100, w=1000), attrib1="value1", class="foo")
y1 <- structure(c(a=1, b=2), attrib2="value2", attrib1="value7")
y2 <- structure(c(a=1, b=2, c=3, d=4), attrib2="value2", attrib1="value7")
y3 <- matrix(1:4, nrow=2, dimnames=list(c("ROW1", "ROW2"), c("COL1", "COL2")))

xc  <- `attributes<-`(as.character(x),  attributes(x))
y1c <- `attributes<-`(as.character(y1), attributes(y1))
y2c <- `attributes<-`(as.character(y2), attributes(y2))
y3c <- `attributes<-`(as.character(y3), attributes(y3))


# we use as.character.numeric, and it removes all attributes...

E(attributes(x %x+% character(0)), NULL)

E(attributes(x %x+% y1), better=attributes(x + y1), NULL)
E(attributes(x %x+% y2), better=attributes(x + y2), NULL)
E(attributes(x %x+% y3), better=attributes(x + y3), NULL)

E(attributes(y1 %x+% x), better=attributes(y1 + x), NULL)
E(attributes(y2 %x+% x), better=attributes(y2 + x), NULL)
E(attributes(y3 %x+% x), better=attributes(y3 + x), NULL)

E(attributes(x %x+% as.vector(y1)), better=attributes(x + as.vector(y1)), NULL)
E(attributes(x %x+% as.vector(y2)), better=attributes(x + as.vector(y2)), NULL)
E(attributes(x %x+% as.vector(y3)), better=attributes(x + as.vector(y3)), NULL)

E(attributes(as.vector(y1) %x+% x), better=attributes(as.vector(y1) + x), NULL)
E(attributes(as.vector(y2) %x+% x), better=attributes(as.vector(y2) + x), NULL)
E(attributes(as.vector(y3) %x+% x), better=attributes(as.vector(y3) + x), NULL)


E(attributes(xc %x+% character(0)), NULL)

E(attributes(xc %x+% y1c), attributes(x + y1))
E(attributes(xc %x+% y2c), attributes(x + y2))
E(attributes(xc %x+% y3c), attributes(x + y3))

E(attributes(y1c %x+% xc), attributes(y1 + x))
E(attributes(y2c %x+% xc), attributes(y2 + x))
E(attributes(y3c %x+% xc), attributes(y3 + x))

E(attributes(xc %x+% as.vector(y1c)), attributes(x + as.vector(y1)))
E(attributes(xc %x+% as.vector(y2c)), attributes(x + as.vector(y2)))
E(attributes(xc %x+% as.vector(y3c)), attributes(x + as.vector(y3)))

E(attributes(as.vector(y1c) %x+% xc), attributes(as.vector(y1) + x))
E(attributes(as.vector(y2c) %x+% xc), attributes(as.vector(y2) + x))
E(attributes(as.vector(y3c) %x+% xc), attributes(as.vector(y3) + x))

E(as.Date(ISOdate(2021, 6, 4)) %x+% 99, "2021-06-0499", worst=NA_character_)

