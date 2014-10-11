#!/bin/bash

## bedtools-install -- installation script for bedtools
## 
## Usage:
##   bedtools-install.sh PREFIX
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
URL=http://bedtools.googlecode.com/files/BEDTools.v2.11.2.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

mkdir -p $PREFIX/src
cd $PREFIX/src
wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfz ${ARCHIVE} || die "could not untargz ${ARCHIVE}"
rm $ARCHIVE
cd BEDTools-Version-2.11.2
make

mkdir -p ${PREFIX}/bin
cp bin/* ${PREFIX}/bin
make clean
