FROM jre-python:v1

# Presto version will be passed in at build time
ARG PRESTO_VERSION


# Copy configuration files on the host into the image
COPY ./etc /opt/presto/etc
COPY ./presto-server-${PRESTO_VERSION} /opt/presto
RUN \
mkdir -p /data/presto &&\
groupadd presto --gid 1000 && \
useradd presto --uid 1000 --gid 1000 && \
chown -R "presto:presto" /data/presto

USER presto:presto
# Specify the entrypoint to start
ENTRYPOINT /opt/presto/bin/launcher run