URL=http://sourceforge.net/projects/samtools/files/samtools/0.1.17/samtools-0.1.17.tar.bz2/download
ARCHIVE=`basename ${URL%\/download}`
PACKAGE=${ARCHIVE%\.tar.bz2}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfj ${ARCHIVE}
    cd ${PACKAGE}
    make || die "failed to build ${PACKAGE}"
    cp samtools ${PREFIX}/bin || die "failed to install ${PACKAGE}"
    mkdir -p ${PREFIX}/include/bam
    cp *.h ${PREFIX}/include/bam
    mkdir -p ${PREFIX}/lib
    cp libbam.a ${PREFIX}/lib
}
