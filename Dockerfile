FROM debian:jessie

EXPOSE 9000

ENV RELEASE=jessie \
    LANGUAGE=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    WEBHOOK_VERSION=2.6.3 \
    BUILDHTMLDIR="/sphinx-doc"

RUN apt-get update \
  && apt-get install -y make python2.7 virtualenv git \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/git/sphinx-doc && git -C /var/lib/git/sphinx-doc init

# virtualenv insists on using python2
RUN ln -sf /usr/bin/python2.7 /usr/bin/python2

COPY generate-sphinx-doc.json /etc/webhook/generate-sphinx-doc.json
COPY generate-sphinx-doc.sh /generate-sphinx-doc.sh
COPY config /root/.ssh/config

# Install webhook
RUN apt-get update \
    && apt-get install -y wget \
    && wget https://github.com/adnanh/webhook/releases/download/${WEBHOOK_VERSION}/webhook-linux-amd64.tar.gz \
    && tar xzf webhook-linux-amd64.tar.gz \
    && mv webhook-linux-amd64/webhook /usr/local/bin/webhook \
    && rm -f webhook-linux-amd64.tar.gz \
    && apt-get remove -y --purge wget \
    && apt-get clean

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY /docker-entrypoint.d/* /docker-entrypoint.d/

VOLUME ["/sphinx-doc", "/var/lib/git/sphinx-doc"]

ENTRYPOINT ["/docker-entrypoint.sh"]
