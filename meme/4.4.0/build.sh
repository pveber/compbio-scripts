URL=http://meme.nbcr.net/downloads/meme_4.4.0.tar.gz
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
