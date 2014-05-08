#!/bin/bash
set -e

BUILDDIR=$1
OUTFILE=$2
INIT=$3

cd $BUILDDIR
mkdir -p RD/bin
mkdir -p RD/dev
cd RD/bin
cp /bin/busybox .
"$PWD/busybox" --install .
cd ..
cp -a /dev/{null,tty,zero} dev
mknod -m 600 dev/console c 5 1
pwd
cp $INIT init
chmod +x init
find . | cpio -H newc -o | gzip -9 > $OUTFILE
rm -rf RD
