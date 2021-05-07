# Copyright (c) 2021, Marek Gagolewski <https://www.gagolewski.com>


.PHONY:  r check build clean purge sphinx test

PKGNAME="stringi"

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

# weave:
# 	cd devel/sphinx/weave && make && cd ../../../
#
# rd2rst:
# 	# https://github.com/gagolews/Rd2rst
# 	# TODO: if need be, you can also use MyST in the future
# 	cd devel/sphinx && Rscript -e "Rd2rst::Rd2rst('${PKGNAME}')" && cd ../../
#
# news:
# 	cd devel/sphinx && pandoc ../../NEWS -f markdown -t rst -o news.rst
# 	cd devel/sphinx && pandoc ../../INSTALL -f markdown -t rst -o install.rst
#
# sphinx: r weave rd2rst news
# 	rm -rf devel/sphinx/_build/
# 	cd devel/sphinx && make html && cd ../../
# 	rm -rf docs/
# 	mkdir docs/
# 	cp -rf devel/sphinx/_build/html/* docs/
# 	cp devel/CNAME.tpl docs/CNAME
# 	touch docs/.nojekyll
# 	touch .nojekyll
#  TODO: cross-reference stringi.gagolewski.com

clean:
	echo "Nothing to do."

purge: clean
	rm -f man/*.Rd
