URL=http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.10.1.zip
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.zip}

install() {
    msg Installing ${PACKAGE}
    msg Fetch ${URL}
    wget -O ${ARCHIVE} ${URL} || die "failed to fetch ${PACKAGE}"
    unzip ${ARCHIVE} || die "could not unzip ${ARCHIVE}"
    cd FastQC
    rm -rf ${PREFIX}/local/fastqc
    mkdir -p ${PREFIX}/local/fastqc
    cp -r * ${PREFIX}/local/fastqc
    chmod 755 ${PREFIX}/local/fastqc/fastqc
    ln -s ${PREFIX}/local/fastqc/fastqc ${PREFIX}/bin/fastqc
}
