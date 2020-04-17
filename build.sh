#!/usr/bin/env sh

set -e

[ -f .env ] && export $(cat .env | sed 's/#.*//g' | xargs)
[ -z "$DOCKERFILE" ] && echo "missing DOCKERFILE variable" && exit 1
[ -z "$NAME" ] && echo "missing DOCKER_PATH variable" && exit 1
[ -z "$TAG" ] && echo "missing TAG variable" && exit 1

CONTEXT_DIR="$(dirname -- $DOCKERFILE)"
docker build -f $DOCKERFILE -t ${DOCKER_REPOSITORY}/${NAME}:${TAG} $CONTEXT_DIR
docker push ${DOCKER_REPOSITORY}/${NAME}:${TAG}
