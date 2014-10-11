URL=http://sourceforge.net/projects/trinityrnaseq/files/trinityrnaseq_r2013-02-25.tgz/download
ARCHIVE=`basename ${URL%\/download}`
PACKAGE=${ARCHIVE%\.tgz}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE} || die "could not unzip ${ARCHIVE}"
    cd ${PACKAGE}
    make || die "failed to build ${PACKAGE}"
    mkdir -p ${PREFIX}/local/trinity
    cp -r * ${PREFIX}/local/trinity
    ln -s ${PREFIX}/local/trinity/Trinity.pl ${PREFIX}/bin/Trinity.pl
}
