# Copyright (c) 2021-2023, Marek Gagolewski <https://www.gagolewski.com/>

.PHONY:  r check build clean purge html docs test

.NOTPARALLEL: r check build clean purge html docs test

PKGNAME="stringx"

all: r

################################################################################

stop-on-utf8:
	# Stop if some files are not in ASCII:
	[ -z "`file -i DESCRIPTION configure configure.win \
	        NAMESPACE cleanup R/* src/* man/* inst/* tools/* | \
	    grep 'text/' | grep -v 'us-ascii' | tee /dev/stderr`" ]

autoconf:
	Rscript -e "\
	    source('.devel/roxygen2-patch.R');\
	    roxygenise(\
	        roclets=c('rd', 'collate')\
	    )"

r: autoconf
	R CMD INSTALL . --html

test: r
	Rscript -e 'source(".devel/realtest.R")'

build:
	cd .. && R CMD build ${PKGNAME}

check: stop-on-utf8 build
	cd .. && R_DEFAULT_INTERNET_TIMEOUT=240 \
	    _R_CHECK_CRAN_INCOMING_REMOTE_=FALSE \
	    _R_CHECK_FORCE_SUGGESTS_=0 \
	    R CMD check `ls -t ${PKGNAME}*.tar.gz | head -1` --as-cran --no-manual

################################################################################

rd2myst:
	# https://github.com/gagolews/Rd2rst
	cd .devel/sphinx && Rscript -e "Rd2rst::Rd2myst('${PKGNAME}')"

weave-examples:
	cd .devel/sphinx/rapi && Rscript -e "Rd2rst::weave_examples('${PKGNAME}', '.')"

weave:
	#cd .devel/sphinx/weave && make && cd ../../../

news:
	cd .devel/sphinx && cp ../../NEWS news.md

html: stop-on-utf8 r weave rd2myst news weave-examples
	rm -rf .devel/sphinx/_build/
	cd .devel/sphinx && make html
	.devel/sphinx/fix-html.sh .devel/sphinx/_build/html/rapi/
# 	.devel/sphinx/fix-html.sh .devel/sphinx/_build/html/weave/
	rm -rf .devel/sphinx/_build/html/_sources
	@echo "*** Browse the generated documentation at"\
	    "file://`pwd`/.devel/sphinx/_build/html/index.html"

docs: html
	@echo "*** Making 'docs' is only recommended when publishing an"\
	    "official release, because it updates the package homepage."
	@echo "*** Therefore, we check if the package version is like 1.2.3"\
	    "and not 1.2.2.9007."
	#Rscript --vanilla -e "stopifnot(length(unclass(packageVersion('${PKGNAME}'))[[1]]) < 4)"
	rm -rf docs/
	mkdir docs/
	cp -rf .devel/sphinx/_build/html/* docs/
	cp .devel/CNAME.tpl docs/CNAME
	touch docs/.nojekyll
	touch .nojekyll

################################################################################

clean:
	rm -rf .devel/sphinx/_build/
	rm -rf .devel/sphinx/rapi/
	rm -rf revdep/

purge: clean
# 	rm -f man/*.Rd
# 	rm -rf docs/
