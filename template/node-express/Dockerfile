FROM node:12.8.0-alpine as builder

RUN apk --no-cache add curl ca-certificates \
    && addgroup -S app && adduser -S -g app app

RUN mkdir -p /home/app
WORKDIR /home/app

COPY function/package.json ./
COPY function/yarn.lock ./
RUN yarn install

# COPY function files and folders
COPY function/ ./

RUN yarn build || :

RUN chown app:app -R /home/app \
    && chmod 777 /tmp

USER app

CMD ["yarn", "start"]