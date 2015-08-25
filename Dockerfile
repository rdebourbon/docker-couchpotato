FROM rdebourbon/docker-base:latest
MAINTAINER rdebourbon@xpandata.net

# add our user and group first to make sure their IDs get assigned regardless of what other dependencies may get added.
RUN groupadd -r librarian && useradd -r -g librarian librarian

RUN apt-get -q update && \
    apt-get install -qy --force-yes python-pip build-essential python-dev libffi-dev libssl-dev && \
    pip install --upgrade cryptography pyopenssl ndg-httpsclient pyasn1 && \
    git clone https://github.com/RuudBurger/CouchPotatoServer.git /CouchPotatoServer && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

RUN mkdir -p /volumes/config && \
    mkdir -p /volumes/media && \
    chown -R librarian:librarian /volumes

VOLUME ["/volumes/config","/volumes/media"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 5050

USER librarian

CMD ["/start.sh"]

