FROM node:12-alpine
MAINTAINER Antoine Gomez <antoine@gomez.lu>

RUN apk update && apk upgrade && \
apk add --no-cache build-base \
                   automake \
                   autoconf \
                   bash \
                   git \
                   openssh \
                   python \
                   openjdk8-jre \
                   mysql-client \
                   redis \
                   libpng-dev \
                   libjpeg-turbo-dev \
                   rsync \
                   unzip \
                   tar \
                   p7zip \
                   libwebp \
                   libwebp-tools \
                   pngquant \
                   optipng \
                   gifsicle \
                   py-pip \
                   groff
RUN pip install awscli
RUN rm /var/cache/apk/*
RUN npm i -g serverless
