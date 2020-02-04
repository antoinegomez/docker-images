FROM node:10.17.0-alpine
MAINTAINER Antoine Gomez <antoine@gomez.lu>

RUN apk update && apk upgrade && \
    apk add --no-cache \
                   bash \
                   python \
                   py-pip
RUN pip install awscli
RUN rm /var/cache/apk/*
WORKDIR /app
COPY nodejs/ecs/src /app/src
RUN mkdir -p app/src && ln -s /app/src/run.sh app/src/run.sh
