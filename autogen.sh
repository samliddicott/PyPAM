#!/bin/sh
# Run this to generate all the initial makefiles, etc.

DIE=0

(autoconf --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have autoconf installed to compile PyPAM."
	echo "Download the appropriate package for your distribution,"
	echo "or get the source tarball at ftp://ftp.gnu.org/pub/gnu/"
	DIE=1
}

(automake --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have automake installed to compile PyPAM."
	echo "Get ftp://ftp.cygnus.com/pub/home/tromey/automake-1.2d.tar.gz"
	echo "(or a newer version if it is available)"
	DIE=1
}

grep -q 'PYTHON' `which automake` > /dev/null 2>&1 || {
	echo
	echo "You must patch your copy of automake, since it doesn't"
	echo "contain the changes found in the am-changes directory"
	DIE=1
}


if test "$DIE" -eq 1; then
	exit 1
fi

if test -z "$*"; then
	echo "I am going to run ./configure with no arguments - if you wish "
        echo "to pass any to it, please specify them on the $0 command line."
fi

echo "Processing ."
echo "aclocal"
aclocal $ACLOCAL_FLAGS
echo "automake --add-missing"
automake --add-missing
echo "autoconf"
autoconf
echo ./configure "$@"
./configure "$@"

echo 
echo "Now type 'make' to compile PyPAM."

