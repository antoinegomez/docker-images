#!/usr/bin/env sh

set -e

[ -z "$DOCKER_REPOSITORY" ] && echo "missing DOCKER_REPOSITORY variable" && exit 1
[ -z "$DOCKERFILE" ] && echo "missing DOCKERFILE variable" && exit 1
[ -z "$NAME" ] && echo "missing DOCKER_PATH variable" && exit 1
[ -z "$TAG" ] && echo "missing TAG variable" && exit 1

CONTEXT_DIR="$(dirname -- $DOCKERFILE)"
docker build -f $DOCKERFILE -t ${DOCKER_REPOSITORY}/${NAME}:${TAG} $CONTEXT_DIR
docker push ${DOCKER_REPOSITORY}/${NAME}:${TAG}
