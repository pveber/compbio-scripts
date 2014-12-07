#!/bin/bash

## htseq-install -- installation script for htseq
## 
## Usage:
##   htseq-install.sh PREFIX
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
URL=https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1p1.tar.gz#md5=c44d7b256281a8a53b6fe5beaeddd31c
ARCHIVE=HTSeq-0.6.1p1.tar.gz
PACKAGE=htseq

die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}

mkdir -p $PREFIX/src
cd $PREFIX/src
wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfz ${ARCHIVE}
rm $ARCHIVE
cd ${ARCHIVE%\.tar.gz}
python setup.py install --prefix ${PREFIX} || die "failed to install ${PACKAGE}"


