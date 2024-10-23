FROM docker.io/alpine/curl as distribution
ARG EXIST_VERSION=6.2.0
ARG EXIST_PREFIX=exist-distribution-"$EXIST_VERSION"
RUN curl --fail --location --remote-name https://github.com/eXist-db/exist/releases/download/eXist-"$EXIST_VERSION"/"$EXIST_PREFIX"-unix.tar.bz2
RUN tar --extract --file "$EXIST_PREFIX"-unix.tar.bz2 --no-same-owner \
&& mv "$EXIST_PREFIX" /exist

FROM docker.io/library/eclipse-temurin:21-jre as build
COPY --from=distribution /exist /exist
COPY log4j2.xml /exist/etc/

FROM docker.io/library/eclipse-temurin:21-jre
COPY --from=build /exist /exist
ENV PATH=/exist/bin:"$PATH"
CMD startup.sh
