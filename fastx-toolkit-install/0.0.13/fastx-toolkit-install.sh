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
URL=http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.bz2}

TMP=`mktemp -d`

cd $TMP
wget ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfj ${ARCHIVE}
mkdir -p $PREFIX/bin
cp bin/* ${PREFIX}/bin
rm -rf $TMP
