URL=http://genome.jouy.inra.fr/~pveber/rep/wascan-c.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE}
    cd ${PACKAGE}
    make BINDIR=${BINDIR} || die "failed to build ${PACKAGE}"
}
