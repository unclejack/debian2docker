#!/bin/bash
set -e

echo "---> clean up the root directory"
(
	cd $BUILDDIR && mv boot/vmlinuz* ../vmlinuz
	chroot $BUILDDIR apt-get clean
	rm -rf boot
) 
echo "---> copying includes.chroot"
cp -Rfp $INCLUDESCHROOTDIR/* $BUILDDIR
 
cp -Rfp /root/hooks $BUILDDIR

echo "---> running hooks"
(
	cd $BUILDDIR/hooks
	for i in *.chroot; do
		echo ' ---> running hook: ' $i
		chroot $BUILDDIR /hooks/$i
	done
	rm -rf $BUILDDIR/hooks
)
echo "---> setting the root password"
chroot $BUILDDIR bash -c 'echo root:live | chpasswd'

echo "---> preparing the rootfs"
(	cd $BUILDDIR
	find . | cpio --quiet -H newc -o | xz -8 > ../initramfs-data.xz
	cd /root/
	mkdir RAMFS
	cd RAMFS
	mv ../initramfs-data.xz rootfs.xz
	find . | cpio --quiet -H newc -o | gzip -1 > ../ramdisk-data.gz
	cat /root/init.gz /root/ramdisk-data.gz > /root/ramdisk-final.gz
	rm -rf $BUILDDIR
)

echo "---> building the iso"
mkdir -p /tmp/iso/boot/isolinux
mkdir -p /tmp/iso/live/
cp /usr/lib/syslinux/isolinux.bin /tmp/iso/boot/isolinux/
cp /root/vmlinuz /tmp/iso/live/
cp /root/ramdisk-final.gz /tmp/iso/live/initrd.img
cp -Rfp $INCLUDESBINARYDIR/* /tmp/iso/
xorriso -as mkisofs \
	-l -J -R -V debian2docker -no-emul-boot -boot-load-size 4 -boot-info-table \
	-b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat \
	-isohybrid-mbr /usr/lib/syslinux/isohdpfx.bin \
	-o /debian2docker.iso /tmp/iso \
