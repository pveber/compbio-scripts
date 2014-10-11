#!/bin/bash

## cufflinks-install -- installation script for cufflinks
## 
## Usage:
##   cufflinks-install.sh PREFIX
##
## if it exists, PREFIX should be a directory
## Installation is performed in PREFIX/bin and PREFIX/src

if [ ! -n "$1" ]
then
    grep "^##" $0
    exit 1
fi

PREFIX=$1
if [ -a $PREFIX ] && [ ! -d $PREFIX ]
then
    echo "Destination $PREFIX exists and isn't a directory."
    exit 1
fi

# make PREFIX path absolute
PREFIX=`readlink -f $PREFIX`
URL=http://cufflinks.cbcb.umd.edu/downloads/cufflinks-0.9.3.Linux_x86_64.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}
TMP=`mktemp -d`

die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}

cd $TMP
wget ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfz ${ARCHIVE}
cd ${PACKAGE}
mkdir -p ${PREFIX}/bin
mv cuffdiff cufflinks cuffcompare ${PREFIX}/bin
rm -rf $TMP

