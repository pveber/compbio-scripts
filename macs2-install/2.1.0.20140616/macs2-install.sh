#!/bin/bash

## macs2-install -- installation script for macs2
## 
## Usage:
##   macs2-install.sh PREFIX
##
## if it exists, PREFIX should be a directory
## Installation is performed in PREFIX/bin, PREFIX/lib and PREFIX/src

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
URL=https://pypi.python.org/packages/source/M/MACS2/MACS2-2.1.0.20140616.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=MACS2

mkdir -p $PREFIX/src
cd $PREFIX/src
wget ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfz ${ARCHIVE}
rm $ARCHIVE
cd ${ARCHIVE%\.tar.gz}
python setup.py install --prefix ${PREFIX} || die "failed to install ${PACKAGE}"


