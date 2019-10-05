ARG NODE_FROM=node:lts
FROM ${NODE_FROM}

ENV NODE_ENV=production

RUN addgroup --system app && adduser --system --ingroup app app

RUN mkdir -p /home/app
WORKDIR /home/app

COPY service/package.json service/package-lock.json ./
RUN npm install

# COPY service files and folders
COPY service/ ./

RUN chown app:app -R /home/app \
    && chmod 777 /tmp

USER app

CMD ["npm", "run", "start"]