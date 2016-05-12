FROM node:6.1.0-slim
MAINTAINER Paolo Pustorino <paolo.pustorino@sparkfabrik.com>

WORKDIR /tmp
ENTRYPOINT ["run.sh"]

# Install Raneto in project directory
ENV RANETO_VERSION 0.9.0
ENV RANETO_INSTALL_DIR /srv/raneto

RUN curl -SLO "https://github.com/gilbitron/Raneto/archive/$RANETO_VERSION.tar.gz" \
    && mkdir -p $RANETO_INSTALL_DIR \
    && tar -xzf "$RANETO_VERSION.tar.gz" -C $RANETO_INSTALL_DIR --strip-components=1 \
    && rm "$RANETO_VERSION.tar.gz"

WORKDIR $RANETO_INSTALL_DIR

RUN npm install

RUN rm -f $RANETO_INSTALL_DIR/example/config.default.js
COPY ./conf/config.default.js /srv/raneto/example/config.default.js

ADD ./conf/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]

