FROM jmcarbo/webhook

MAINTAINER mickael.canevet@camptocamp.com

EXPOSE 9000

ENV BUILDHTMLDIR /sphinx-doc

RUN apt-get update \
  && apt-get install -y make python2.7 virtualenv git \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/git/sphinx-doc && git -C /var/lib/git/sphinx-doc init

# virtualenv insists on using python2
RUN ln -sf /usr/bin/python2.7 /usr/bin/python2

COPY generate-sphinx-doc.json /etc/webhook/generate-sphinx-doc.json
COPY generate-sphinx-doc.sh /generate-sphinx-doc.sh

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY /docker-entrypoint.d/* /docker-entrypoint.d/

VOLUME ["/sphinx-doc", "/var/lib/git/sphinx-doc"]

ENTRYPOINT ["/docker-entrypoint.sh"]
