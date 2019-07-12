FROM alpine:3.10
MAINTAINER Fluke667 <Fluke667@gmail.com>  
ARG TZ='Europe/Berlin'
 

RUN apk add --update openssl && \ 
    rm -rf /var/cache/apk/*

VOLUME ["/etc/certs/ssl"]


ADD ./config /config
RUN chmod 0700 /config/*.sh
RUN /config/certs.sh
