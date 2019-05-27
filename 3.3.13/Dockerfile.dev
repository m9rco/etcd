FROM m9rco/etcd:3.3.13
LABEL maintainer="m9rco <pushaowei0727@gmail.com>"

ARG USER=root
ARG PASSWORD=root

RUN apk add -U --no-cache \
        godep \
        openssh \
        supervisor \
        autoconf \
        git \
        curl \
        wget \
        zip \
    # clean up       
    && rm -rf /var/cache/apk/* \
    # add ssh
    && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && echo "${USER}:${PASSWORD}" | chpasswd \
    && ssh-keygen -A 

COPY devfs /

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE  22 2379 2380 4001 7001
