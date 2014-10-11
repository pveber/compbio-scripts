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

MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
    URL=http://ftp-private.ncbi.nlm.nih.gov/sra/sdk/2.1.16/sratoolkit.2.1.16-centos_linux64.tar.gz
    ARCHIVE=`basename ${URL}`
else
    URL=http://ftp-private.ncbi.nlm.nih.gov/sra/sdk/2.1.16/sratoolkit.2.1.16-ubuntu32.tar.gz
    ARCHIVE=`basename ${URL}`
fi ;
PACKAGE=${ARCHIVE%\.tar.gz}

TMP=`mktemp -d`
cd $TMP
wget -O ${ARCHIVE} ${URL} || die "Couldn't fetch ${ARCHIVE}"
tar xvfz ${ARCHIVE} || die "Failed unpacking"
cd ${PACKAGE}
rm -rf USAGE README help

mkdir -p ${PREFIX}/bin
cp bin/* ${PREFIX}/bin

rm -rf $TMP
