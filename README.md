# Docker images

## nginx

### php-single-vhost

This image is meant to be used with one php application.

Below are a list of env variables that are used in the config file with their default value.

```
PHP_PUBLIC_DIR: /var/www/html
PHP_HOST: localhost
PHP_PORT: 9000
GZIP: on
GZIP_VARY: on
GZIP_PROXIED: any
GZIP_TYPES: text/plain text/css text/xml text/javascript application/javascript application/x-javascript application/xml application/json
CLIENT_MAX_BODY_SIZE: 1
```

### Available tags:

`antoinegomez/nginx:latest`

## nodejs

### alpine-build

Used to build nodejs project.

Contains build base, git, bash, openssh, python, mysql-client, redis plus many other stuff required to build nodejs projects.
Also have AWS Cli and serverless installed.

Using nodejs LTS 10x images for now, mostly because I use this for AWS Lambda.

### Available tags:

`node:lts-alpine-build`

`node:10.16.3-alpine-build`

`node:10.17.0-alpine-build`

## php

### 7.3-fpm

Created for Greenjinn PHP apps.

Using `php:7.3-fpm` image as base.

Adding these mods:

* mcrypt
* bcmath
* bz2
* calendar
* pcntl
* iconv
* intl
* mbstring
* mysqli
* opcache
* pdo_mysql
* zip
* gd
* redis


## LICENCE

Use at your own risk. I may edit or delete images without notice.
