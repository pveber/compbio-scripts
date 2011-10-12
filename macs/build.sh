URL=http://macs:chipseq@liulab.dfci.harvard.edu/MACS/src/MACS-1.4.1.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=macs

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE}
    cd ${ARCHIVE%\.tar.gz}
    python setup.py install --prefix ${PREFIX} || die "failed to install ${PACKAGE}"
}

