#!/bin/bash

## kallisto -- installation script for kallisto
## 
## Usage:
##   kallisto PREFIX
##
## if it exists, PREFIX should be a directory
## Installation is performed in PREFIX/bin and PREFIX/src

PKG=kallisto
VERSION=0.42.5

set -ue

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
PREFIX=`readlink -f $PREFIX`/$PKG/$VERSION

mkdir -p $PREFIX
cd $PREFIX
wget https://github.com/pachterlab/kallisto/archive/v${VERSION}.tar.gz
tar xvfz v${VERSION}.tar.gz
rm v${VERSION}.tar.gz
cd kallisto-${VERSION}
mkdir build
cd build
cmake ..
make


mkdir -p $PREFIX/bin
cp src/kallisto $PREFIX/bin

cd ../..
rm -rf kallisto-${VERSION}
