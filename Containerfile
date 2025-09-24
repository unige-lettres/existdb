FROM quay.io/buildah/stable:latest
RUN dnf --assumeyes install ant unzip
COPY opt /opt/
ENTRYPOINT ["/opt/entrypoint.sh"]
