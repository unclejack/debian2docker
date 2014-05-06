#!/bin/bash
set -e

PACKAGELISTSDIR=/root/package-lists

for i in $(ls $PACKAGELISTSDIR);
do
PACKAGES="$PACKAGES $(cat $PACKAGELISTSDIR/$i)"
done
echo $PACKAGES
export PACKAGES=$PACKAGES
export SUITE=jessie
export BUILDDIR=/root/jessieout
export MIRROR=http://http.debian.net/debian
export INCLUDESCHROOTDIR=/root/includes.chroot
export INCLUDESBINARYDIR=/root/includes.binary

/root/buildboot/d2d_debootstrap.sh
/root/buildboot/d2d_build.sh
