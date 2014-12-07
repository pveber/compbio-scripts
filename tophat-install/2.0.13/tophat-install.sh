#!/bin/bash

## tophat-install -- installation script for tophat
## 
## Usage:
##   tophat-install.sh PREFIX
##
## if it exists, PREFIX should be a directory
## Installation is performed in PREFIX/bin and PREFIX/src

die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}

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

URL=http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.13.Linux_x86_64.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}
TMP=`mktemp -d`

cd $TMP
wget ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfz ${ARCHIVE}
cd ${PACKAGE}
rm README AUTHORS COPYING

mkdir -p $PREFIX/bin
cp * ${PREFIX}/bin

rm -rf $TMP
