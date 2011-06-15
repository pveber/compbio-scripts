URL=http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.bz2}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfj ${ARCHIVE}
    cp bin/* ${PREFIX}/bin
}
