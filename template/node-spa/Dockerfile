FROM node:lts as builder

COPY service/package.json service/package-lock.json ./
RUN npm install

# COPY service files and folders
COPY service/ ./

ENV NODE_ENV=production
RUN npm run build

FROM nginx:alpine

RUN apk --no-cache add curl ca-certificates

# COPY service files and folders
COPY --from=builder build/ /usr/share/nginx/html