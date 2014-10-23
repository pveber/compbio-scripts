#!/bin/bash

## samtools-install -- installation script for cufflinks
## 
## Usage:
##   samtools-install.sh PREFIX
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

URL=http://sourceforge.net/projects/samtools/files/samtools/0.1.17/samtools-0.1.17.tar.bz2/download
ARCHIVE=`basename ${URL%\/download}`
PACKAGE=${ARCHIVE%\.tar.bz2}

mkdir -p $PREFIX/src
cd $PREFIX/src
wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfj ${ARCHIVE}
rm $ARCHIVE
cd ${PACKAGE}
make || die "failed to build ${PACKAGE}"

mkdir -p $PREFIX/bin
cp samtools ${PREFIX}/bin || die "failed to install ${PACKAGE}"

mkdir -p ${PREFIX}/include/bam
cp *.h ${PREFIX}/include/bam

mkdir -p ${PREFIX}/lib
cp libbam.a ${PREFIX}/lib

make clean
