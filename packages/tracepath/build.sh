TERMUX_PKG_HOMEPAGE=https://github.com/iputils/iputils
TERMUX_PKG_DESCRIPTION="Tool to trace the network path to a remote host"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=20190515
TERMUX_PKG_SRCURL=https://github.com/iputils/iputils/archive/s${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9b5125eb5ef9f4e947ad8fdddcf77f538f53b8f47b53eb5bc5347cb16d01c8fd
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="libidn"

termux_step_configure() {
	return
}

termux_step_make() {
	return
}

termux_step_make_install() {
	$CC $CFLAGS $LDFLAGS -lidn -o $TERMUX_PREFIX/bin/tracepath tracepath.c
	local MANDIR=$TERMUX_PREFIX/share/man/man8
	mkdir -p $MANDIR
	cp $TERMUX_PKG_BUILDER_DIR/tracepath.8 $MANDIR/
	# Setup traceroute as an alias for tracepath, since traceroute
	# requires root which most Termux user does not have, and tracepath
	# is probably good enough for most:
	(cd $TERMUX_PREFIX/bin && ln -f -s tracepath traceroute)
	(cd $MANDIR && ln -f -s tracepath.8 traceroute.8)
}
