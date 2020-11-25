#!/bin/sh
set -e

WEB_DIR="/var/www/html"
echo "!!! Web Root Directory !!!"
echo ${WEB_DIR}

cd "${WEB_DIR}"

chmod g+s /var/www/html/cache
chmod 775 /tmp

./vendor/bin/robo repair:rebuild-extensions

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

exec "$@"