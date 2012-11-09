install() {
    MACHINE_TYPE=`uname -m`
    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
	URL=http://ftp-private.ncbi.nlm.nih.gov/sra/sdk/2.1.16/sratoolkit.2.1.16-centos_linux64.tar.gz
	ARCHIVE=`basename ${URL}`
    else
	URL=http://ftp-private.ncbi.nlm.nih.gov/sra/sdk/2.1.16/sratoolkit.2.1.16-ubuntu32.tar.gz
	ARCHIVE=`basename ${URL}`
    fi ;
    PACKAGE=${ARCHIVE%\.tar.gz}
    wget -O ${ARCHIVE} ${URL} || die "Couldn't fetch ${ARCHIVE}"
    tar xvfz ${ARCHIVE} || die "Failed unpacking"
    cd ${PACKAGE}
    rm -rf USAGE README help
    mkdir -p ${PREFIX}/bin
    cp bin/* ${PREFIX}/bin
}
