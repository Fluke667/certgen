FROM fluke667/alpine
MAINTAINER Fluke667 <Fluke667@gmail.com>  


RUN apk add --update openssl make augeas shadow openssh bash && \ 
    mkdir -p ~root/.ssh /etc/authorized_keys && chmod 700 ~root/.ssh/ && \
    rm -rf /var/cache/apk/*

VOLUME ["/etc/certs/ssl"]
#

EXPOSE 22

COPY ./etc/ssh/issuer.ext /etc/ssh/issuer.ext
COPY ./etc/ssh/public.ext /etc/ssh/public.ext
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config
ADD ./config /config
RUN chmod 0700 /config/*.sh
RUN /config/certs.sh
   # /config/sshd.sh
    
