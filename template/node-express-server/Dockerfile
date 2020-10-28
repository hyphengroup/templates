FROM node:lts as base
ARG SSH_KEY
ENV SSH_KEY=$SSH_KEY

RUN mkdir -p /app
WORKDIR /app

RUN apk add --no-cache openssh-client git \
  && mkdir ~/.ssh \
  && ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts

RUN echo -n $SSH_KEY | base64 -d > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa

COPY package.json .
COPY package-lock.json .
COPY lerna.json .
RUN npm install

COPY service/package.json service/
COPY service/package*.json service/

RUN npm run bootstrap

COPY . .

RUN npm --prefix /app/service run build

ENV NODE_ENV=production
RUN npm prune

FROM node:lts-alpine

RUN mkdir -p /app
WORKDIR /app

COPY --from=base /app/service /app/service 

EXPOSE 8080/TCP
EXPOSE 8081/TCP
EXPOSE 8082/TCP

CMD ["npm", "run", "start"]