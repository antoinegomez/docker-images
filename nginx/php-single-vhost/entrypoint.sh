#!/usr/bin/env sh
set -eu

GZIP=${GZIP:=on}
GZIP_VARY=${GZIP_VARY:=on}
GZIP_PROXIED=${GZIP_PROXIED:=any}
GZIP_TYPES=${GZIP_TYPES:=text/plain text/css text/xml text/javascript application/x-javascript application/xml application/json}
CLIENT_MAX_BODY_SIZE=${CLIENT_MAX_BODY_SIZE:=1}
PHP_PUBLIC_DIR=${PHP_PUBLIC_DIR:=/var/www/html}
PHP_HOST=${PHP_HOST:=localhost}
PHP_PORT=${PHP_PORT:=9000}

envsubst '${GZIP} ${GZIP_VARY} ${GZIP_PROXIED} ${GZIP_TYPES} ${CLIENT_MAX_BODY_SIZE} ${PHP_PUBLIC_DIR} ${PHP_HOST} ${PHP_PORT}' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf

exec "$@"
