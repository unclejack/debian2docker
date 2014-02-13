# debian2docker

This repository is meant to be a staging area for boot2docker.

### How to build

Building debian2docker is quite simple:

```
docker rmi run-debian2docker
docker build -t debian2docker -rm .
docker run -i -t -privileged -name run-debian2docker debian2docker
docker cp run-debian2docker:/root/lb/binary.hybrid.iso .
mv binary.hybrid.iso debian2docker.iso
```
note: the ``docker cp`` will complain ``operation not permitted`` - presumably as it tries to change the file's ownership to ``root``
