FROM docker.io/library/alpine
RUN apk add apache-ant bash
COPY opt /opt/
ENTRYPOINT ["/opt/entrypoint.sh"]
