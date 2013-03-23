URL=http://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.5.3p9.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=htseq

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget ${URL} || die "failed to fetch ${PACKAGE}"
    tar xvfz ${ARCHIVE}
    cd ${ARCHIVE%\.tar.gz}
    python setup.py install --prefix ${PREFIX} || die "failed to install ${PACKAGE}"
}

