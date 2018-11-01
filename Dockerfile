FROM alpine:3.8

ARG VERSION=openjdk-8u181
ARG BUILD_DATE
ARG VCS_REF

LABEL \
    maintainer="lonly197@qq.com" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="lonly/docker-alpine-java" \
    org.label-schema.url="https://github.com/lonly197" \
    org.label-schema.description="Basic Docker image to run Java applications." \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/lonly197/docker-alpine-java" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vendor="lonly197@qq.com" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

# Define environment 
ENV	JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    PATH=$PATH:${JAVA_HOME}:${JAVA_HOME}/bin:${JAVA_HOME}/jre:${JAVA_HOME}/jre/bin \
    ## Default to UTF-8 file.encoding
    LANG=C.UTF-8

# Install packages
RUN	set -x \
    # Add alpine repo
    && echo http://mirrors.aliyun.com/alpine/v3.8/main/ >> /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/v3.8/community/ >> /etc/apk/repositories \
    ## Update apk package
    && apk update \
    ## Add base package
    && apk add --no-cache --upgrade bash \
    ## Install Java
    && apk add --no-cache --upgrade openjdk8 \
    ## Cleanup
    && rm -rf *.tgz *.tar *.zip \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*