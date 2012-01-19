URL=http://www.cs.helsinki.fi/group/pssmfind/MOODS_1.0.1.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE} || die "could not unzip ${ARCHIVE}"
    cd MOODS/src
    make
    cp find_pssm_dna $BINDIR
    cp libpssm.a $LIBDIR
}
