FROM node:lts as builder

RUN addgroup --system app && adduser --system --ingroup app app

RUN mkdir -p /home/app
WORKDIR /home/app

COPY service/package.json service/package-lock.json ./

# COPY service files and folders
COPY service/ ./

RUN npm install

ENV NODE_ENV=production

# RUN npm run lint \
#     && npm run test --coverage \
#     && npm run build

RUN chown app:app -R /home/app \
    && chmod 777 /tmp

USER app

CMD ["npm", "run", "start"]