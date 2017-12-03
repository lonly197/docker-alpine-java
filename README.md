# docker-alpine-java

 > Basic Docker image to run Java applications.

- [![](https://images.microbadger.com/badges/version/lonly/docker-alpine-java:oraclejdk-8u152.svg)](https://microbadger.com/images/lonly/docker-alpine-java:oraclejdk-8u152) [![](https://images.microbadger.com/badges/image/lonly/docker-alpine-java:oraclejdk-8u152.svg)](https://microbadger.com/images/lonly/docker-alpine-java:oraclejdk-8u152) __oraclejdk-8u152__

## Introduction

This image is based on the popular Alpine Linux project, available in the alpine official image. Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. The main caveat to note is that it does use musl libc instead of glibc and friends, so certain software might run into issues depending on the depth of their libc requirements. However, most software doesn't have an issue with this, so this variant is usually a very safe choice. See this Hacker News comment thread for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

To minimize image size, it's uncommon for additional related tools (such as git or bash) to be included in Alpine-based images. Using this image as a base, add the things you need in your own Dockerfile (see the alpine image description for examples of how to install packages if you are unfamiliar).

Also, JDK bundle contains lots of unnecessary for Docker image stuff, so it was cleaned up.

## Build

```bash
docker build \
--rm \
-t lonly/docker-alpine-java:oraclejdk-8u152 \
--build-arg VCS_REF=`git rev-parse --short HEAD` \
--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` .
```

## Usage

This image could be a base image for your projects, so you may use it like this:

```Dockerfile
FROM lonly/docker-alpine-java:oraclejdk-8u152

COPY ./my_app /usr/local/bin/my_app
```

```sh
docker build -t my_app .
```

There are already several images using this image, so you can refer to them as usage examples:

* [`lonly/docker-zeppelin`](https://hub.docker.com/r/lonly/docker-zeppelin/) ([github](https://github.com/lonly197/docker-zeppelin))

* [`lonly/docker-presto`](https://hub.docker.com/r/lonly/docker-presto/) ([github](https://github.com/lonly197/docker-presto))

## Test

```bash
echo 'public class Main { public static void main(String[] args) { System.out.println("Hello World"); } }' > Main.java
docker run --rm -v "$(pwd)":/mnt --workdir /mnt ldocker-alpine-java:oraclejdk-8u152 sh -c "javac Main.java && java Main"
```