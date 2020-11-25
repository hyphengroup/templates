#!/bin/bash
set -euo pipefail

WEB_DIR="/var/www/html"
echo "!!! Web Root Directory !!!"
echo ${WEB_DIR}

cd ${WEB_DIR}

./vendor/bin/robo repair:rebuild-extensions

apache2-foreground