FROM php:7.2.30-apache
ARG USER=suitecrm
ENV APACHE_RUN_USER=${USER}
ENV APACHE_RUN_GROUP=${USER}

RUN apt-get update \ 
  && apt-get install -y --no-install-recommends \
    git \
    bsdtar \
    zip \
    unzip \
    zlib1g-dev \
    libc-client-dev \
    libkrb5-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install pdo pdo_mysql mysqli zip imap gd iconv

RUN touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo "upload_max_filesize = 50M;" >> /usr/local/etc/php/conf.d/uploads.ini

RUN groupadd -g 1000 $USER
RUN useradd -r -u 1000 -g $USER $USER


# COPY service files and folders
COPY service/ ./

RUN mkdir -p /tmp/cache /tmp/sessions /tmp/logs
RUN chown -R $USER:$USER /tmp/cache /tmp/sessions /tmp/logs
RUN chown -R $USER:$USER . \
  && chmod -R 755 . \
  && chmod -R 775 cache custom modules themes data upload 