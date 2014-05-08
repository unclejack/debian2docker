# debian2docker

### What is debian2docker

Debian2docker is a hybrid bootable ISO which starts an amd64 Linux system based on Debian. Its main purpose is to run Docker and to allow the execution of containers using Docker. 

The ISO is currently about 55 MB and is based on Debian jessie.

This project is meant to merge back into boot2docker if that's possible.

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

The password for the user docker is `docker.io`.

### Goals

debian2docker has the following goals:

1. Remain minimal - no package installation
2. Become a new base for boot2docker.
3. Offer only the minimal tooling required to run Docker and its containers.
4. Make use of Debian binary packages - avoid lengthy compilation times.
5. If a package is broken or has problems, it should be fixed upstream and used.
6. Become an official and supported Docker distribution.

### Why Debian?

We've decided to choose Debian because it's a large project and it can be trusted for a few reasons:

1. Debian packages can be verified and Debian can be trusted.
2. Debian has been around for a long time and it'll be around.
3. The toolchain and the process can be simplified by using tooling provided by Debian.
4. All minimal dependencies to support Docker are already in Debian.
5. The system can still remain small.
6. We can still disallow the installation of software in the live environment - NO package installation!
7. Packages may be customized easily by rebuilding them from sources when needed.
8. We can build debian2docker in a Debian container running debian2docker.

The goal remains the same: running Docker to run Docker containers.
