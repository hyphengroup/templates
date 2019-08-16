FROM node:10.13.0-alpine as builder

RUN apk --no-cache add curl ca-certificates \
    && addgroup -S app && adduser -S -g app app

RUN mkdir -p /home/app
WORKDIR /home/app

COPY function/package.json function/package-lock.json ./
RUN npm install

# COPY function files and folders
COPY function/ ./

ENV NODE_ENV=production

RUN npm run lint \
    && npm run test --coverage \
    && npm run build

RUN chown app:app -R /home/app \
    && chmod 777 /tmp

USER app

CMD ["npm", "run", "start:prod"]