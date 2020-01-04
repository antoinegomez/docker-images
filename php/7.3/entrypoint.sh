#!/usr/bin/env sh
set -eu

export FILE_UPLOADS=${FILE_UPLOADS:-On}
export MEMORY_LIMIT=${MEMORY_LIMIT:-32}
export UPLOAD_MAX_FILE_SIZE=${UPLOAD_MAX_FILE_SIZE:-1}
export POST_MAX_SIZE=${POST_MAX_SIZE:-2}
export MAX_INPUT_VARS=${MAX_INPUT_VARS:-1000}

envsubst '${CLIENT_MAX_BODY_SIZE} ${MAX_INPUT_VARS} ${FILE_UPLOADS} ${MEMORY_LIMIT} ${UPLOAD_MAX_FILE_SIZE} ${POST_MAX_SIZE}' < /usr/local/etc/php/conf.d/php-upload.template > /usr/local/etc/php/conf.d/php-upload.ini

echo "Patched /usr/local/etc/php/conf.d/php-upload.ini"

exec "$@"
