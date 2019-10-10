FROM nginx:1.16-alpine

RUN apk --no-cache add curl ca-certificates

# COPY service files and folders
COPY service/html/ /usr/share/nginx/html

# COPY default.conf only if it exists
COPY service/conf/default.conf /etc/nginx/conf.d/default.conf
