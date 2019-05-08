FROM m9rco/alpine:3.8

LABEL maintainer="m9rco <pushaowei0727@gmail.com>"
WORKDIR /home/app

ARG ETCD_VSERSION=v2.0.10
RUN apk add -U --no-cache ca-certificates \
        openssl \
        tar \
    &&  wget https://github.com/coreos/etcd/releases/download/${ETCD_VSERSION}/etcd-${ETCD_VSERSION}-linux-amd64.tar.gz \
    && tar xzvf etcd-${ETCD_VSERSION}-linux-amd64.tar.gz\
    && mv etcd-${ETCD_VSERSION}-linux-amd64/etcd* /bin/  \
    && apk del --purge tar openssl  \
    && rm -Rf etcd-${ETCD_VSERSION}-linux-amd64* \
    && rm -rf /var/cache/apk/* 

ADD rootfs /
ADD entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

EXPOSE      2379 2380 4001 7001
ENTRYPOINT  ["/bin/entrypoint.sh"]
