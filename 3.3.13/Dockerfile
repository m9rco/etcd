FROM m9rco/alpine:3.8
LABEL maintainer="m9rco <pushaowei0727@gmail.com>"

ARG ETCD_VSERSION=v3.3.13
RUN apk add -U --no-cache ca-certificates \
        openssl \
        tar \
    &&  wget https://github.com/coreos/etcd/releases/download/${ETCD_VSERSION}/etcd-${ETCD_VSERSION}-linux-amd64.tar.gz \
    && tar xzvf etcd-${ETCD_VSERSION}-linux-amd64.tar.gz \
    && mv etcd-${ETCD_VSERSION}-linux-amd64/etcd* /bin/ \
    && apk del --purge tar openssl  \
    && rm -Rf etcd-${ETCD_VSERSION}-linux-amd64* \
    && rm -rf /var/cache/apk/* 

ADD rootfs /

ENV BITNAMI_APP_NAME="etcd" \
    BITNAMI_IMAGE_VERSION="${ETCD_VSERSION}-linux-amd64" \
    ETCD_ADVERTISE_CLIENT_URLS="http://127.0.0.1:2379" \
    ETCD_DATA_DIR="/home/app/etcd/data/" \
    ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379" \
    PATH="/home/app/etcd/bin:$PATH"

EXPOSE 2379 2380

WORKDIR /app
ENTRYPOINT  ["/usr/share/entrypoint.sh"]
CMD [ "etcd" ]
