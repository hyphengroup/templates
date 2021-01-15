ARG NODE_FROM=node:lts
ARG NGINX_FROM=nginx:stable

FROM ${NODE_FROM} as builder

COPY service/package.json service/yarn.lock rollup.config.js ./
RUN yarn

# COPY service files and folders
COPY service/ ./
ARG BUILD_PATH=/build

RUN yarn build:docs

RUN mkdir -p /static-html \
    && cp -R ${BUILD_PATH}/* /static-html/

FROM ${NGINX_FROM}

# https://github.com/moby/moby/issues/34482
COPY --from=builder /static-html/ /usr/share/nginx/html/

EXPOSE 80
