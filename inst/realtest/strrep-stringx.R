E(1:2 %x*% 1:3, P(c("1", "22", "111"), warning=TRUE))
E(NULL %x*% 1:3, character(0))
E(1:2 %x*% NULL, character(0))

x <- structure(c(A="a", B=NA, C="b"), attrib1="value1")
E(
    x %x*% 1,
    x,
    .comment="attribute preservation"
)

x <- matrix(letters[1:6], nrow=2, dimnames=list(c("A", "B"), NULL))
E(
    x %x*% 1,
    x,
    .comment="attribute preservation"
)

x <- matrix(1:6, nrow=2, dimnames=list(c("A", "B"), NULL))
E(
    x %x*% 1,
    better=`attributes<-`(as.character(x), attributes(x)),
    `attributes<-`(as.character(x), NULL),  # as.character.numeric drops all attribs
    .comment="attribute preservation"
)

x0 <- c("a", NA, "c")  # attribs from x and y (x preferred)
x <- structure(x0, names=c("A", "B", "C"), attrib1="value1")
y <- structure(c(x=1, y=1, z=1), attrib2="value2")
E(
    x %x*% y,
    `attributes<-`(x0, c(attributes(y), attributes(x))),
    bad=`attributes<-`(x0, attributes(x)),
    bad=structure(x0, names=names(x)),
    bad=x0,
    .comment="attribute preservation"
)

x0 <- "a"  # attribs from y
x <- structure(x0, names="A", attrib1="value1")
E(
    x %x*% y,
    `attributes<-`(rep(x0, length(y)), attributes(y)),
    bad=structure(rep(x0, length(y)), names=names(y)),
    bad=structure(rep(x0, length(y)), names=rep(names(x), length(y))),
    bad=rep(x0, length(y)),
    .comment="attribute preservation"
)

x0 <- c(1, NA, 3)  # coercion needed
x <- structure(x0, names=c("A", "B", "C"), attrib1="value1")
E(
    x %x*% y,
    better=`attributes<-`(as.character(x0), c(attributes(y), attributes(x))),
    `attributes<-`(as.character(x0), c(attributes(y))),  # as.character.numeric drops all attribs
    bad=`attributes<-`(as.character(x0), attributes(x)),
    bad=structure(as.character(x0), names=names(x)),
    bad=as.character(x0),
    .comment="attribute preservation"
)
