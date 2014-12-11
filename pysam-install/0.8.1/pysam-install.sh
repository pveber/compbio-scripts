#!/bin/bash

## pysam-install -- installation script for pysam
## 
## Usage:
##   pysam-install.sh PREFIX
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
URL=https://pypi.python.org/packages/source/p/pysam/pysam-0.8.1.tar.gz#md5=9b2c7b4c1ea63841815725557da188fb
ARCHIVE=pysam-0.8.1.tar.gz
PACKAGE=pysam

die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}

mkdir -p $PREFIX/src
cd $PREFIX/src
wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
tar xvfz ${ARCHIVE}
rm $ARCHIVE
cd ${ARCHIVE%\.tar.gz}
PYTHONVERSION=`python --version 2>&1 |grep -o '[0-9]\.[0-9]'`
PYTHONLIBDIR=$PREFIX/lib/python${PYTHONVERSION}/site-packages
PYTHONPATH=$PYTHONLIBDIR:$PYTHONPATH
mkdir -p $PYTHONLIBDIR
python setup.py install --prefix ${PREFIX} || die "failed to install ${PACKAGE}"


