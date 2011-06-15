URL=http://bedtools.googlecode.com/files/BEDTools.v2.11.2.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE} || die "could not untargz ${ARCHIVE}"
    cd BEDTools-Version-2.11.2
    make
    cp bin/* ${PREFIX}/bin
}
