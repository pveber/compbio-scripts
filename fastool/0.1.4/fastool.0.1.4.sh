#!/bin/bash

## fastool -- installation script for fastool
## 
## Usage:
##   fastool PREFIX
##
## if it exists, PREFIX should be a directory
## Installation is performed in PREFIX/bin and PREFIX/src

PKG=fastool
VERSION=0.1.4

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
wget https://github.com/fstrozzi/Fastool/archive/0.1.4.tar.gz
tar xvfz 0.1.4.tar.gz
rm 0.1.4.tar.gz
cd Fastool-0.1.4
make

mkdir -p $PREFIX/bin
cp fastool $PREFIX/bin

cd ..
rm -rf Fastool-0.1.4
