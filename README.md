# docker-pyrescene

Forked
------
Forked with an updated version of Alpine/Chromaprint from [harrox](https://github.com/srrDB/pyrescene/blob/master/dev-docs/code/alpine_docker_pyrescene-harrox.txt)

Installation
-----

```
docker build -t docker-pyrescene .
```

Usage
-----
To run this container the first time, you'll need to run command similar to:

```
docker run -i -e UID=1000 -e GID=1000 -v /path/to/scan:/scan -v /path/to/store/srr:/srr
```
Be careful about UID/GID you must use a machine user with read/write rights on dirs used.
