#!/bin/bash

## bowtie2-install -- installation script for bowtie2
## 
## Usage:
##   bowtie2-install PREFIX
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
wget -O bowtie2.zip "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.4/bowtie2-2.2.4-linux-x86_64.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie2%2F2.2.4%2F&ts=1417768070&use_mirror=freefr" || die "failed to download archive"
unzip bowtie2.zip
rm bowtie2.zip
mv bowtie2-2.2.4 bin
