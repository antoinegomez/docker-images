FROM node:10.16.0-alpine
MAINTAINER Antoine Gomez <antoine@gomez.lu>

RUN apk update && apk upgrade && \
apk add --no-cache build-base bash git openssh python