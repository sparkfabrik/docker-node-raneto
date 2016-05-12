FROM node:6.1.0-slim
MAINTAINER Paolo Pustorino <paolo.pustorino@sparkfabrik.com>

# Set variables
ENV RANETO_VERSION 0.9.0
ENV RANETO_INSTALL_DIR /srv/raneto

# Get Raneto from sources
RUN cd /tmp \
    && curl -SLO "https://github.com/gilbitron/Raneto/archive/$RANETO_VERSION.tar.gz" \
    && mkdir -p $RANETO_INSTALL_DIR \
    && tar -xzf "$RANETO_VERSION.tar.gz" -C $RANETO_INSTALL_DIR --strip-components=1 \
    && rm "$RANETO_VERSION.tar.gz"

# Install gulp to manage Raneto dependencies
RUN npm install --global gulp-cli

# Install and configure Raneto
WORKDIR $RANETO_INSTALL_DIR
RUN npm install \
    && rm -f $RANETO_INSTALL_DIR/example/config.default.js \
    && gulp
COPY ./conf/config.default.js /srv/raneto/example/config.default.js

# Add the starter script and make it executable
ADD ./conf/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Let's go
ENV PORT=80
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/run.sh"]
