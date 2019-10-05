ARG NODE_FROM=node:lts
FROM ${NODE_FROM} as builder

RUN addgroup --system app && adduser --system --ingroup app app

RUN mkdir -p /home/app
WORKDIR /home/app

COPY service/package.json service/package-lock.json ./

# COPY service files and folders
COPY service/ ./

ARG RAZZLE_MARKET
ARG RAZZLE_APP_VERSION

ENV RAZZLE_MARKET=${RAZZLE_MARKET}
ENV RAZZLE_APP_VERSION=${RAZZLE_APP_VERSION}

RUN npm install

ENV NODE_ENV=production

# RUN npm run lint \
#     && npm run test --coverage \
#     && npm run build
RUN npm run build

RUN chown app:app -R /home/app \
    && chmod 777 /tmp

USER app

CMD ["npm", "run", "start:prod"]