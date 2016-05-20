#!/bin/bash

## kent-tree-install -- installation script for kent-tree
## 
## Usage:
##   kent-tree-install.sh PREFIX
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
URL=https://github.com/ucscGenomeBrowser/kent/archive/v330_base.tar.gz


die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}


mkdir -p $PREFIX/src
cd $PREFIX/src
wget $URL
tar xvfz v330_base.tar.gz
cd kent-330_base 
BINDIR=${PREFIX}/bin 
MACHTYPE=`echo ${MACHTYPE} | cut -d '-' -f 1`
MYSQLLIBS=`mysql_config --libs` || die 'improper mysql install'
MYSQLINC=`mysql_config --include | sed -e 's/-I//g'` || die 'improper mysql install'

make -C src userApps \
    BINDIR="${BINDIR}" \
    SCRIPTS="${BINDIR}" \
    MACHTYPE="${MACHTYPE}" \
    MYSQLLIBS="${MYSQLLIBS} -lz" \
    MYSQLINC="${MYSQLINC}"
make -C src/hg/genePredToGtf \
    BINDIR="${BINDIR}" \
    SCRIPTS="${BINDIR}" \
    MACHTYPE="${MACHTYPE}" \
    MYSQLLIBS="${MYSQLLIBS} -lz" \
    MYSQLINC="${MYSQLINC}"
make -C src/hg/gpToGtf \
    BINDIR="${BINDIR}" \
    SCRIPTS="${BINDIR}" \
    MACHTYPE="${MACHTYPE}" \
    MYSQLLIBS="${MYSQLLIBS} -lz" \
    MYSQLINC="${MYSQLINC}"

cd ..
rm -rf kent-330_base*
