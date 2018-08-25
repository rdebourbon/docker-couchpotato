FROM alpine:edge
MAINTAINER rdebourbon@xpandata.net

# set environment language / terminal preferences.
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

# add our user and group first to make sure their IDs get assigned regardless of what other dependencies may get added.
RUN groupadd -r librarian && useradd -r -g librarian librarian

RUN apk -U upgrade && \
    apk -U add \
        ca-certificates \
        git \
        openssl \
        python \
        py2-pip py2-openssl py-libxml2 py2-lxml \
    && \
    apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev py-pip build-base && \
    pip install --upgrade pip && \
    pip install --upgrade pyopenssl && \
    git clone --depth 1 https://github.com/CouchPotato/CouchPotatoServer.git /CouchPotatoServer && \
    apk del build-dependencies && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /volumes/config && \
    mkdir -p /volumes/media && \
    chown -R librarian:librarian /volumes

VOLUME ["/volumes/config","/volumes/media"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 5050

USER librarian

CMD ["/start.sh"]

