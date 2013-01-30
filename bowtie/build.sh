URL=http://sourceforge.net/projects/bowtie-bio/files/bowtie/0.12.9/bowtie-0.12.9-src.zip/download
ARCHIVE=`basename ${URL%\/download}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
    unzip ${ARCHIVE} || die "could not unzip ${ARCHIVE}"
    cd ${ARCHIVE%\-src.zip}
    make || die "failed to build ${PACKAGE}"
    mkdir -p ${PREFIX}/bin
    cp bowtie bowtie-build bowtie-inspect ${PREFIX}/bin
}
