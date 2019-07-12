FROM alpine:3.10
MAINTAINER Fluke667 <Fluke667@gmail.com>  
ARG TZ='Europe/Berlin' 

ENV CRT_COUNTY=DE
ENV CRT_STATE=Bavaria
ENV CRT_LOCATION=Nuremberg
ENV CRT_ORGANISATION=TB
ENV CRT_ROOT_CN=Root
ENV CRT_ISSUER_CN=Example
ENV CRT_PUBLIC_CN=*.example.com
ENV CRT_ROOT_NAME=root
ENV CRT_ISSUER_NAME=example
ENV CRT_PUBLIC_NAME=public
ENV CRT_RSA_KEY_NUMBITS=2048
ENV CRT_DAYS=365
ENV CRT_KEYSTORE_NAME=Keystore
ENV CRT_KEYSTORE_PASS=changeit
ENV CRT_CERT_DIR=/etc/certs/ssl

RUN apk add --update openssl make augeas shadow && \ 
    mkdir -p ~root/.ssh /etc/authorized_keys && chmod 700 ~root/.ssh/ && \
    rm -rf /var/cache/apk/*

VOLUME ["/etc/certs/ssl"]


EXPOSE 22

ADD ./config /config
RUN chmod 0700 /config/*.sh
RUN /config/certs.sh \
    /config/sshd.sh
    
