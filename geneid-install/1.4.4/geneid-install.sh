#!/bin/bash

## geneid-install -- installation script for geneid
## 
## Usage:
##   geneid-install.sh PREFIX
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

URL=ftp://genome.crg.es/pub/software/geneid/geneid_v1.4.4.Jan_13_2011.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}

mkdir -p $PREFIX/src
cd $PREFIX/src
wget ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfz ${ARCHIVE}
rm $ARCHIVE
cd geneid
make || die "failed to build ${PACKAGE}"
mkdir $PREFIX/bin
cp bin/* $PREFIX/bin
