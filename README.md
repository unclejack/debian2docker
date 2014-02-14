# debian2docker

This repository is meant to be a staging area for boot2docker.

### How to build

Building debian2docker is quite simple:

```
docker rm run-debian2docker
docker build -t debian2docker -rm .
docker run -i -t -privileged -name run-debian2docker debian2docker
docker cp run-debian2docker:/root/lb/binary.hybrid.iso .
mv binary.hybrid.iso debian2docker.iso
```
note: the ``docker cp`` will complain ``operation not permitted`` - presumably as it tries to change the file's ownership to ``root``

### Goals

debian2docker has the following goals:

1. Remain minimal - no package installation
2. Become the new base for boot2docker.
3. Offer only the minimal tooling required to run Docker and its containers.
4. Make use of Debian binary packages - avoid lengthy compilation times.
5. If a package is broken or has problems, it should be fixed upstream and used.

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
