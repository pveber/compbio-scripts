#!/bin/bash

## bowtie-install -- installation script for bowtie
## 
## Usage:
##   bowtie-install PREFIX
##
## if it exists, PREFIX should be a directory
## Installation is performed in PREFIX/bin and PREFIX/src

set -e

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
PREFIX=`readlink -f $PREFIX`

mkdir -p $PREFIX
cd $PREFIX
wget -O bowtie.zip "http://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.0.1/bowtie-1.0.1-linux-x86_64.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie%2F1.0.1%2F&ts=1396093686&use_mirror=freefr" || die "failed to download archive"
unzip bowtie.zip
rm bowtie.zip
mv bowtie-1.0.1 bin
