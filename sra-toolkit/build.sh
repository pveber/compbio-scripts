URL=http://trace.ncbi.nlm.nih.gov/Traces/sra/static/sra_sdk-2.1.7a.tar.gz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    MACHINE_TYPE=`uname -m`
    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
	URL=http://trace.ncbi.nlm.nih.gov/Traces/sra/static/sratoolkit.2.1.7-centos_linux64.tar.gz
	ARCHIVE=`basename ${URL}`
    else
	URL=http://trace.ncbi.nlm.nih.gov/Traces/sra/static/sratoolkit.2.1.7-ubuntu32.tar.gz
	ARCHIVE=`basename ${URL}`
	PACKAGE=${ARCHIVE%\.tar.gz}
    fi ;
    PACKAGE=${ARCHIVE%\.tar.gz}
    wget -O ${ARCHIVE} ${URL} || die "Couldn't fetch ${ARCHIVE}"
    tar xvfz ${ARCHIVE} || die "Failed unpacking"
    cd ${PACKAGE}
    rm -rf USAGE README help
    mkdir -p ${PREFIX}/bin
    cp * ${PREFIX}/bin
}
