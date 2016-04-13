FROM jmcarbo/webhook

MAINTAINER mickael.canevet@camptocamp.com

EXPOSE 9000

VOLUME ["/sphinxdoc", "/var/lib/git"]

RUN apt-get update \
  && apt-get install -y make python2.7 virtualenv git \
  && rm -rf /var/lib/apt/lists/*

RUN git init /var/lib/git/sphinxdoc

# virtualenv insists on using python2
RUN ln -sf /usr/bin/python2.7 /usr/bin/python2

COPY generate-sphinx-doc.json /etc/webhook/generate-sphinx-doc.json
COPY generate-sphinx-doc.sh /generate-sphinx-doc.sh

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ENTRYPOINT ["/docker-entrypoint.sh"]
