#!/usr/bin/env sh
set -eu

export GZIP=${GZIP:-on}
export GZIP_VARY=${GZIP_VARY:-on}
export GZIP_PROXIED=${GZIP_PROXIED:-any}
export GZIP_TYPES=${GZIP_TYPES:-"text/plain text/css text/xml text/javascript application/x-javascript application/xml application/json"}
export CLIENT_MAX_BODY_SIZE=${CLIENT_MAX_BODY_SIZE:-1}
export PHP_PUBLIC_DIR=${PHP_PUBLIC_DIR:-/var/www/html}
export PHP_HOST=${PHP_HOST:-localhost}
export PHP_PORT=${PHP_PORT:-9000}

envsubst '${GZIP} ${GZIP_VARY} ${GZIP_PROXIED} ${GZIP_TYPES} ${CLIENT_MAX_BODY_SIZE} ${PHP_PUBLIC_DIR} ${PHP_HOST} ${PHP_PORT}' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf

exec "$@"
