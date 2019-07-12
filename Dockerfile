FROM alpine:3.10
MAINTAINER Fluke667 <Fluke667@gmail.com>  
ARG TZ='Europe/Berlin' 

RUN apk add --update openssl make && \ 
    mkdir -p ~root/.ssh /etc/authorized_keys && chmod 700 ~root/.ssh/ && \
    rm -rf /var/cache/apk/*

VOLUME ["/etc/certs/ssl"]


EXPOSE 22

ADD ./config /config
RUN chmod 0700 /config/*.sh
RUN /config/certs.sh \
    /config/sshd.sh
    
