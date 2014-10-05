FROM debian:jessie
RUN apt-get update && apt-get -y install busybox-static adduser bzip2 xz-utils nano insserv kmod sudo debootstrap cpio isolinux syslinux xorriso
ADD hooks /root/hooks
ADD buildboot /root/buildboot/
ADD includes.binary /root/includes.binary/
ADD includes.chroot /root/includes.chroot/
ADD VERSION /root/includes.binary/version
RUN cp /root/includes.binary/version /root/includes.chroot/etc/version
ADD package-lists /root/package-lists/
RUN /root/buildboot/build_ramdisk.sh /root /root/init.gz /root/buildboot/init
CMD ["/root/buildboot/d2d_wrapper.sh"]
