#!/usr/bin/env sh
set -eu

envsubst '${PHP_PUBLIC_DIR} ${PHP_HOST}' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf

exec "$@"