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


############## Rd2rst: https://github.com/gagolews/Rd2rst ######################

rd2myst:
	cd devel/sphinx && Rscript -e "Rd2rst::Rd2myst('${PKGNAME}')"

news:
	cd devel/sphinx && cp ../../NEWS news.md

weave-examples:
	cd devel/sphinx/rapi && Rscript -e "Rd2rst::weave_examples('${PKGNAME}', '.')"
	devel/sphinx/fix-code-blocks.sh devel/sphinx/rapi

sphinx: r rd2myst news weave-examples
	rm -rf devel/sphinx/_build/
	cd devel/sphinx && make html
	rm -rf docs/
	mkdir docs/
	cp -rf devel/sphinx/_build/html/* docs/
	cp devel/CNAME.tpl docs/CNAME
	touch docs/.nojekyll
	touch .nojekyll

################################################################################

clean:
	rm -rf devel/sphinx/_build/

purge: clean
	rm -f man/*.Rd
	rm -rf devel/sphinx/rapi/
	rm -rf docs/
