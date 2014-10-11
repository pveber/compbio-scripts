URL=http://soap.genomics.org.cn/down/x86_64.linux/SOAPdenovo31mer.tgz
ARCHIVE=`basename ${URL}`
PACKAGE=${ARCHIVE%\.tar.gz}

install() {
    mkdir SOAPdenovo && cd SOAPdenovo
    wget http://soap.genomics.org.cn/down/x86_64.linux/SOAPdenovo31mer.tgz
    tar xvfz SOAPdenovo31mer.tgz
    wget http://soap.genomics.org.cn/down/x86_64.linux/SOAPdenovo63mer.tgz
    tar xvfz SOAPdenovo63mer.tgz
    wget http://soap.genomics.org.cn/down/x86_64.linux/SOAPdenovo127mer.tgz
    tar xvfz SOAPdenovo127mer.tgz
    mv SOAPdenovo*mer ${PREFIX}/bin
}
