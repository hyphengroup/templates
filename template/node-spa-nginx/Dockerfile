ARG NODE_FROM=node:lts
ARG NGINX_FROM=nginx:stable
ARG BUILD_PATH=/build/

FROM ${NODE_FROM} as builder

COPY service/package.json service/package-lock.json ./
RUN npm install

# COPY service files and folders
COPY service/ ./

RUN npm run build

FROM ${NGINX_FROM}

COPY --from=builder ${BUILD_PATH} /usr/share/nginx/html

EXPOSE 80
