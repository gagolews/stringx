# Copyright (c) 2021, Marek Gagolewski <https://www.gagolewski.com>


.PHONY:  r check build clean purge sphinx test

PKGNAME="stringx"

all: r

autoconf:
	Rscript -e 'roxygen2::roxygenise(roclets=c("rd", "collate", "namespace", "vignette"))'

r: autoconf
	R CMD INSTALL . --html

tinytest:
	Rscript -e 'source("devel/tinytest.R")'

test: r tinytest

build:
	cd .. && R CMD build ${PKGNAME}

check: build
	cd .. && R CMD check `ls -t ${PKGNAME}*.tar.gz | head -1` --no-manual

check-cran: build
	cd .. && R_DEFAULT_INTERNET_TIMEOUT=240 _R_CHECK_CRAN_INCOMING_REMOTE_=FALSE R CMD check `ls -t ${PKGNAME}*.tar.gz | head -1` --as-cran

weave:
	cd devel/sphinx/weave && make && cd ../../../

rd2myst:
	# https://github.com/gagolews/Rd2rst
	# TODO: if need be, you can also use MyST in the future
	cd devel/sphinx && Rscript -e "Rd2rst::Rd2myst('${PKGNAME}')" && cd ../../

news:
	cd devel/sphinx && cp ../../NEWS news.md

sphinx: r weave rd2myst news
	rm -rf devel/sphinx/_build/
	cd devel/sphinx && make html && cd ../../
	rm -rf docs/
	mkdir docs/
	cp -rf devel/sphinx/_build/html/* docs/
	cp devel/CNAME.tpl docs/CNAME
	touch docs/.nojekyll
	touch .nojekyll

clean:
	echo "Nothing to do."

purge: clean
	rm -f man/*.Rd
