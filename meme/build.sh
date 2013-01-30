URL=ftp://ftp.ebi.edu.au/pub/software/MEME/r4.9.0/rc5/meme_4.9.0.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE}
    cd ${PACKAGE}
    ./configure --prefix=${PREFIX} --with-url="http://meme.nbcr.net/meme" || die "${PACKAGE} configure failed"
    make || die "failed to build ${PACKAGE}"
    make install || die "failed to install ${PACKAGE}"
}
