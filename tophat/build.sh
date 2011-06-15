#!/bin/bash
URL=http://tophat.cbcb.umd.edu/downloads/tophat-1.2.0.Linux_x86_64.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
  wget ${URL} || die "failed to fetch ${PACKAGE}"
  tar xvfz ${ARCHIVE}
  cd ${PACKAGE}
  rm README AUTHORS COPYING
  mv * ${PREFIX}/bin
}
