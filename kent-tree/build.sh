URL=git://genome-source.cse.ucsc.edu/kent.git

install() {
    git clone ${URL} || die 'Failed to git kent repository'
    BINDIR=${PREFIX}/bin 
    MACHTYPE=`echo ${MACHTYPE} | cut -d '-' -f 1`
    MYSQLLIBS=`mysql_config --libs` || die 'improper mysql install'
    MYSQLINC=`mysql_config --include | sed -e 's/-I//g'` || die 'improper mysql install'
    sed -i -e 's/-Werror//g' kent/src/inc/common.mk
    sed -i -e 's/\\$A: \\$O \\${MYLIBS}/\\$A: \\$O/g' kent/src/hg/pslCDnaFilter/makefile
    make -C kent/src userApps \
	BINDIR="${BINDIR}" \
	SCRIPTS="${BINDIR}" \
	MACHTYPE="${MACHTYPE}" \
	MYSQLLIBS="${MYSQLLIBS}" \
	MYSQLINC="${MYSQLINC}"
    make -C kent/src/hg/genePredToGtf \
	BINDIR="${BINDIR}" \
	SCRIPTS="${BINDIR}" \
	MACHTYPE="${MACHTYPE}" \
	MYSQLLIBS="${MYSQLLIBS}" \
	MYSQLINC="${MYSQLINC}"
    make -C kent/src/hg/gpToGtf \
	BINDIR="${BINDIR}" \
	SCRIPTS="${BINDIR}" \
	MACHTYPE="${MACHTYPE}" \
	MYSQLLIBS="${MYSQLLIBS}" \
	MYSQLINC="${MYSQLINC}"
}