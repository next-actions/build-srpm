FROM fedora:latest
RUN dnf install -y rpmbuild && dnf clean all
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
