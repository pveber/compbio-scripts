#!/bin/bash

## bwa-install -- installation script for bwa
## 
## Usage:
##   bwa-install.sh PREFIX
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
URL="http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.10.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbio-bwa%2Ffiles%2F&ts=1417023135&use_mirror=heanet"
ARCHIVE=bwa-0.7.10.tar.bz2
PACKAGE=bwa

die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}

mkdir -p $PREFIX/src
cd $PREFIX/src
wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfj ${ARCHIVE}
rm $ARCHIVE
cd ${ARCHIVE%\.tar.bz2}
make
mkdir -p $PREFIX/bin
cp bwa $PREFIX/bin
make clean
