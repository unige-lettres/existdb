ARG EXISTDB_VERSION=release

FROM docker.io/library/alpine as build
RUN apk add apache-ant bash curl
COPY build /tmp
RUN ["/tmp/build.sh"]

FROM docker.io/existdb/existdb:$EXISTDB_VERSION
COPY install /tmp
COPY --from=build /tmp/*.xar /tmp
RUN --mount=type=bind,from=docker.io/library/busybox:uclibc,source=/bin,target=/bin \
    /tmp/install.sh && rm -r /tmp/*
