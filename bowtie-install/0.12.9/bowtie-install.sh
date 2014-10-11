# bowtie-install -- installation script for bowtie
# 
# Usage:
#   bowtie-install PREFIX
#
# PREFIX should exist and be a directory
# Installation is performed in PREFIX/bin and PREFIX/src

PREFIX=$1
if [ ! -d $PREFIX ]
then
    echo "Destination $PREFIX does not exist or isn't a directory."
    exit 1
fi

# make PREFIX path absolute
PREFIX=`readlink -f $PREFIX`
URL=http://sourceforge.net/projects/bowtie-bio/files/bowtie/0.12.9/bowtie-0.12.9-src.zip/download
ARCHIVE=`basename ${URL%\/download}`
PACKAGE=${ARCHIVE%\.tar.gz}

die() {
    ECODE=$?
    echo -e "$1 (\#${ECODE})"
    exit ${ECODE}
}

mkdir -p $PREFIX/src
cd $PREFIX/src
wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
unzip ${ARCHIVE} || die "could not unzip ${ARCHIVE}"
rm ${ARCHIVE}
cd ${ARCHIVE%\-src.zip}
make || die "failed to build ${PACKAGE}"
mkdir -p ${PREFIX}/bin
cp bowtie bowtie-build bowtie-inspect ${PREFIX}/bin
make clean

