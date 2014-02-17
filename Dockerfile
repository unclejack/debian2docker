FROM debian:jessie
MAINTAINER unclejack
ENV LB /root/lb
RUN apt-get update;\
  apt-get install -y apt-utils live-build bzip2 lzma xz-utils squashfs-tools wget ca-certificates
RUN mkdir $LB ;\
 cd $LB ; \
 lb config --initramfs-compression lzma --compression xz -d jessie \
 --debian-installer false --apt-indices false --apt-recommends false \
 --debootstrap-options "--variant=minbase"  --firmware-chroot false \
 --memtest none live
RUN cp /usr/share/doc/live-build/examples/hooks/stripped.chroot $LB/config/hooks/
ADD hooks/ $LB/config/hooks/
ADD reqs.list.chroot $LB/config/package-lists/
ADD isolinux/ $LB/config/includes.binary/isolinux/
WORKDIR /root/lb
CMD ["lb", "build"]
