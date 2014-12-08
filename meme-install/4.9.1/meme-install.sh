#!/bin/bash

## meme-install -- installation script for meme
## 
## Usage:
##   meme-install.sh PREFIX
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

URL=ftp://ftp.ebi.edu.au/pub/software/MEME/4.9.1/meme_4.9.1.tar.gz
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
cd ${PACKAGE}
./configure --prefix=${PREFIX} --with-url="http://meme.nbcr.net/meme" --enable-build-libxml2 --enable-build-libxslt || die "${PACKAGE} configure failed"
make || die "failed to build ${PACKAGE}"
make install || die "failed to install ${PACKAGE}"
make clean
