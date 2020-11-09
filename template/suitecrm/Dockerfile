FROM php:7.2.30-apache AS basebase

# add from a tgz does not support --chown so pull into temp image layer
# so can copy later and save a lot cost
# ARG SUITECRM_MODULE_TARBALL=service/base_suitecrm.tgz
ADD service/*.tgz /bob

# these should be mounted via a secret in k8 

COPY service/ /bob
RUN rm /bob/*.tgz

ARG BUILD_TYPE=RELEASE
RUN if [ "$BUILD_TYPE" = "EDIT" ]; then cd /bob/Api/V8/OAuth2 \
  && openssl genrsa -out private.key 2048 \
  && openssl rsa -in private.key -pubout -out public.key \
  && chmod 600 private.key public.key \
  && chown $USER:www-data p*.key ; else \
# to stop someone menting a token outside prod and using it with prod server the two keys can be mounted via a secret, requried to use V8 of suite api
# will need https://github.com/kubernetes/kubernetes/issues/81089 for this without work around as we are not uid 0 and secret mounts are always uid0
  ln -s /secret/OAuth2/public /bob/Api/V8/OAuth2/public.key \
  && ln -s /secret/OAuth2/private /bob/Api/V8/OAuth2/private.key \
   ; fi
RUN if [ "$BUILD_TYPE" = "EDIT" ]; then echo KEEPING modulebuilder do not release this image ; else rm -rf /bob/custom/modulebuilder/packages/* ; fi

# any changes to permissions etc should be done here before

FROM php:7.2.30-apache

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

ARG USER=www-data
ARG UID=1000
RUN groupadd -f -g 1000 $USER
RUN id -u $USER || useradd -r -u $UID -g $USER -G www-data $USER

COPY --chown=$USER:www-data --from=basebase /bob .

RUN bash -c "mkdir -p /var/suitecrm/cache /var/suitecrm/sessions /var/suitecrm/logs cache custom/history/modules"
RUN bash -c "chown -R $USER:www-data /var/suitecrm/cache /var/suitecrm/sessions /var/suitecrm/logs cache"