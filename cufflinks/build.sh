#!/bin/bash
URL=http://cufflinks.cbcb.umd.edu/downloads/cufflinks-0.9.3.Linux_x86_64.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
  wget ${URL} || die "failed to fetch ${PACKAGE}"
  tar xvfz ${ARCHIVE}
  cd ${PACKAGE}
  mv cuffdiff cufflinks cuffcompare ${PREFIX}/bin
}
