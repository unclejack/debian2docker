# debian2docker

### What is debian2docker

Debian2docker is a hybrid bootable ISO which starts an amd64 Linux system based on Debian. Its main purpose is to run Docker and to allow the execution of containers using Docker. 

The ISO is currently about 55 MB and is based on Debian jessie.

### How to build

Building debian2docker is quite simple:

```
docker rm run-debian2docker
docker build -t debian2docker .
docker run -i -t --privileged --name run-debian2docker debian2docker
docker cp run-debian2docker:/debian2docker.iso .
```
note: the ``docker cp`` will complain ``operation not permitted`` - presumably as it tries to change the file's ownership to ``root``

### How to run

1. Create a VM.
2. Add the ISO you've built as a virtual CD/DVD image.
3. Start the VM
4. Wait for the system to boot and start using debian2docker.

Linux & qemu/kvm example:
```
$ kvm -cdrom debian2docker.iso -m 768
# wait for the system to boot and start using debian2docker
```

The password for the user docker is `live`.

### Goals

debian2docker has the following goals:

1. Remain minimal - no package installation
2. Offer only the minimal tooling required to run Docker and its containers.
3. Make use of Debian binary packages - avoid lengthy compilation times.
4. If a package is broken or has problems, it should be fixed upstream and used.

### Why Debian?

Debian was chosen because it's a large project and it can be trusted for a few reasons:

1. Debian packages can be verified and Debian can be trusted.
2. Debian has been around for a long time and it'll be around.
3. The toolchain and the process can be simplified by using tooling provided by Debian.
4. All minimal dependencies to support Docker are already in Debian.
5. The system can still remain small.
6. We can still disallow the installation of software in the live environment - NO package installation!
7. Packages may be customized easily by rebuilding them from sources when needed.
8. We can build debian2docker in a Debian container running debian2docker.

### Features

debian2docker supports the following Docker graph drivers:
- aufs
- btrfs
- devicemapper
- vfs

AUFS is used by default for partitions formatted with ext4. BTRFS will
be used if the storage partition is formatted as btrfs.

Devicemapper and vfs aren't used by default, but the kernel and Docker
support these two graph drivers as well.
