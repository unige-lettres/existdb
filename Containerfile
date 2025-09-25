FROM docker.io/library/alpine
RUN apk add apache-ant bash curl
COPY opt /opt/
ENTRYPOINT ["/opt/entrypoint.sh"]
