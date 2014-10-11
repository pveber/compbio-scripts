#!/bin/bash

## fastqc-install -- installation script for fastqc
## 
## Usage:
##   fastqc-install.sh PREFIX
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
URL=http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.10.1.zip
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.zip}
TMP=`mktemp -d`

cd $TMP
wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
unzip ${ARCHIVE} || die "could not unzip ${ARCHIVE}"

cd FastQC
mkdir -p ${PREFIX}/local/fastqc
cp -r * ${PREFIX}/local/fastqc
chmod 755 ${PREFIX}/local/fastqc/fastqc
ln -s ${PREFIX}/local/fastqc/fastqc ${PREFIX}/bin/fastqc

rm -rf $TMP
