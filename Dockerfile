FROM node:6.11.1-alpine

RUN \
    apk update \
    && apk add ca-certificates wget \
    && update-ca-certificates    

# Install Ghost
RUN \
  cd /tmp && \
  wget https://ghost.org/zip/ghost-latest.zip && \
  mkdir /ghost && \
  unzip ghost-latest.zip -d /ghost && \
  rm -f ghost-latest.zip && \
  cd /ghost && \
  npm install --production && \
  npm install -g knex-migrator && \
  knex-migrator init


COPY config.development.json /ghost

EXPOSE 9000

WORKDIR /ghost

CMD ["npm", "run", "start"]