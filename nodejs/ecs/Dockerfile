FROM node:12.16.2-alpine
MAINTAINER Antoine Gomez <antoine@gomez.lu>

RUN apk update && apk upgrade && \
    apk add --no-cache \
                   bash \
                   python \
                   py-pip
RUN pip install awscli
RUN rm /var/cache/apk/*
WORKDIR /app
COPY ./src /app/src
RUN mkdir -p app/src && ln -s /app/src/run.sh app/src/run.sh
