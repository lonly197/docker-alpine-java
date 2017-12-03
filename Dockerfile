FROM lonly/docker-alpine-glibc

ARG VERSION=oraclejdk-8u152
ARG BUILD_DATE
ARG VCS_REF

LABEL \
    maintainer="lonly197@qq.com" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="lonly/docker-alpine-java" \
    org.label-schema.url="https://github.com/lonly197" \
    org.label-schema.description="Base and Clean Docker image with OracleJDK 8." \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/lonly197/docker-alpine-java" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vendor="lonly197@qq.com" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

# Define environment 
ENV	JAVA_HOME=/usr/lib/jvm/default-jvm \
    PATH=$PATH:${JAVA_HOME}:${JAVA_HOME}/bin:${JAVA_HOME}/jre:${JAVA_HOME}/jre/bin

# Install packages
RUN	set -x \
    ## Install jdk
    && JAVA_VERSION=8u152 \
    && JAVA_UPDATE=152 \
    && JAVA_BUILD=16 \
    && JAVA_PATH=aa0333dd3019491ca4f6ddbe78cdb6d0 \
    && cd /tmp/ \
    && wget --no-check-certificate -c -q --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}-linux-x64.tar.gz \
    && tar -zxvf jdk-${JAVA_VERSION}-linux-x64.tar.gz \
    && mkdir -p ${JAVA_HOME} \
    && mv /tmp/jdk1.8.0_${JAVA_UPDATE} ${JAVA_HOME} \
    ## Cleanup
    && rm -rf "$JAVA_HOME/lib/missioncontrol" \
           "$JAVA_HOME/lib/visualvm" \
           "$JAVA_HOME/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/plugin.jar" \
           "$JAVA_HOME/jre/lib/ext/jfxrt.jar" \
           "$JAVA_HOME/jre/bin/javaws" \
           "$JAVA_HOME/jre/lib/javaws.jar" \
           "$JAVA_HOME/jre/lib/desktop" \
           "$JAVA_HOME/jre/plugin" \
           "$JAVA_HOME/jre/lib/"deploy* \
           "$JAVA_HOME/jre/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/"*jfx* \
           "$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" \
           "$JAVA_HOME/jre/lib/amd64/"libprism_*.so \
           "$JAVA_HOME/jre/lib/amd64/libfxplugins.so" \
           "$JAVA_HOME/jre/lib/amd64/libglass.so" \
           "$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" \
           "$JAVA_HOME/jre/lib/amd64/"libjavafx*.so \
           "$JAVA_HOME/jre/lib/amd64/"libjfx*.so \
           "$JAVA_HOME/jre/bin/jjs" \
           "$JAVA_HOME/jre/bin/keytool" \
           "$JAVA_HOME/jre/bin/orbd" \
           "$JAVA_HOME/jre/bin/pack200" \
           "$JAVA_HOME/jre/bin/policytool" \
           "$JAVA_HOME/jre/bin/rmid" \
           "$JAVA_HOME/jre/bin/rmiregistry" \
           "$JAVA_HOME/jre/bin/servertool" \
           "$JAVA_HOME/jre/bin/tnameserv" \
           "$JAVA_HOME/jre/bin/unpack200" \
           "$JAVA_HOME/jre/lib/ext/nashorn.jar" \
           "$JAVA_HOME/jre/lib/jfr.jar" \
           "$JAVA_HOME/jre/lib/jfr" \
           "$JAVA_HOME/jre/lib/oblique-fonts" \
    && rm -rf *.tgz \
            *.tar \
            *.zip \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*