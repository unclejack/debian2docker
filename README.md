# debian2docker

This repository is meant to be a staging area for boot2docker.

### How to build

Building debian2docker is quite simple:

```
$ docker build -t debian2docker -rm .
$ docker run -i -t -privileged debian2docker
$ docker cp `docker ps -q -l`:/root/lb/binary.hybrid.iso .
$ mv binary.hybrid.iso debian2docker.iso
```
