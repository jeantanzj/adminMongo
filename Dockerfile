FROM node:alpine
ENV HOME=/app/user
ENV ROOT_UID=0
ENV ROOT_GID=0
ENV ROOT_GROUPNAME=root
ENV APP_UID=1001
ENV APP_USERNAME=container-user
# Add Default Application User
RUN adduser -S -u ${APP_UID} -h ${HOME} -s /sbin/nologin -G ${ROOT_GROUPNAME} ${APP_USERNAME}

WORKDIR ${HOME}

RUN mkdir backups
RUN chown -R ${APP_UID}:${ROOT_GID} ${HOME} && \
    chmod -R og+rwx ${HOME} && \
    chmod -R 0777 backups
COPY package.json .
RUN npm install --production


COPY . .
CMD node app.js
