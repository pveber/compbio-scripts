#!/bin/bash

## macs-install -- installation script for macs
## 
## Usage:
##   macs-install.sh PREFIX
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
URL=https://github.com/downloads/taoliu/MACS/MACS-1.4.2-1.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=macs

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
cd ${ARCHIVE%-1\.tar.gz}
python setup.py install --prefix ${PREFIX} || die "failed to install ${PACKAGE}"


