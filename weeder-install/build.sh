URL=http://159.149.160.51/modtools/downloads/weeder1.4.2.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE}
    cd ${PACKAGE^} # ^ operator to capitalize the content of a variable. Nice!
    ./compileall || die "failed to build ${PACKAGE}"
    cp -r FreqFiles *.out ${BINDIR}
}
