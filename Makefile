# Copyright (c) 2021, Marek Gagolewski <https://www.gagolewski.com>


.PHONY:  r check build clean purge sphinx test

PKGNAME="stringx"

all: r

autoconf:
	Rscript -e "\
	    source('devel/roxygen2-patch.R');\
	    roxygenise(\
	        roclets=c('rd', 'collate', 'namespace', 'vignette')\
	    )"

r: autoconf
	R CMD INSTALL . --html

tinytest:
	Rscript -e 'source("devel/tinytest.R")'

test: r tinytest

stop-on-utf8:
	# Stop if some files are not in ASCII:
	[ -z "`file -i DESCRIPTION configure configure.win \
	        NAMESPACE cleanup R/* src/* man/* inst/* tools/* | \
	    grep 'text/' | grep -v 'us-ascii' | tee /dev/stderr`" ]

build:
	cd .. && R CMD build ${PKGNAME}

check: stop-on-utf8 build
	cd .. && R CMD check `ls -t ${PKGNAME}*.tar.gz | head -1` --no-manual

check-cran: stop-on-utf8 build
	cd .. && R_DEFAULT_INTERNET_TIMEOUT=240 \
	    _R_CHECK_CRAN_INCOMING_REMOTE_=FALSE \
	    R CMD check `ls -t ${PKGNAME}*.tar.gz | head -1` --as-cran


############## Rd2rst: https://github.com/gagolews/Rd2rst ######################

rd2myst:
	cd devel/sphinx && Rscript -e "Rd2rst::Rd2myst('${PKGNAME}')"

news:
	cd devel/sphinx && cp ../../NEWS news.md

weave-examples:
	cd devel/sphinx/rapi && Rscript -e "Rd2rst::weave_examples('${PKGNAME}', '.')"
	devel/sphinx/fix-code-blocks.sh devel/sphinx/rapi

sphinx: stop-on-utf8 r rd2myst news weave-examples
	rm -rf devel/sphinx/_build/
	cd devel/sphinx && make html
	echo "*** Browse the generated documentation at"\
	    "file://`pwd`/devel/sphinx/_build/html/index.html"

docs: sphinx
	# this is recommended only when publishing an official release
	# -> updates the package homepage
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
	rm -rf devel/sphinx/rapi/
	rm -rf revdep/

purge: clean
# 	rm -f man/*.Rd
# 	rm -rf docs/
