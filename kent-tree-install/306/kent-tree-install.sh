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
URL=git://genome-source.cse.ucsc.edu/kent.git


die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}


mkdir -p $PREFIX/src
cd $PREFIX/src
git clone ${URL} || die 'Failed to git kent repository'
git checkout v306_branch
BINDIR=${PREFIX}/bin 
MACHTYPE=`echo ${MACHTYPE} | cut -d '-' -f 1`
MYSQLLIBS=`mysql_config --libs` || die 'improper mysql install'
MYSQLINC=`mysql_config --include | sed -e 's/-I//g'` || die 'improper mysql install'
sed -i -e 's/-Werror//g' kent/src/inc/common.mk
sed -i -e 's/\\$A: \\$O \\${MYLIBS}/\\$A: \\$O/g' kent/src/hg/pslCDnaFilter/makefile
make -C kent/src userApps \
    BINDIR="${BINDIR}" \
    SCRIPTS="${BINDIR}" \
    MACHTYPE="${MACHTYPE}" \
    MYSQLLIBS="${MYSQLLIBS} -lz" \
    MYSQLINC="${MYSQLINC}"
make -C kent/src/hg/genePredToGtf \
    BINDIR="${BINDIR}" \
    SCRIPTS="${BINDIR}" \
    MACHTYPE="${MACHTYPE}" \
    MYSQLLIBS="${MYSQLLIBS} -lz" \
    MYSQLINC="${MYSQLINC}"
make -C kent/src/hg/gpToGtf \
    BINDIR="${BINDIR}" \
    SCRIPTS="${BINDIR}" \
    MACHTYPE="${MACHTYPE}" \
    MYSQLLIBS="${MYSQLLIBS} -lz" \
    MYSQLINC="${MYSQLINC}"
