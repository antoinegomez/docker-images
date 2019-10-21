# Docker images

## nginx

### php-single-vhost

This image is meant to be used with one php application.

Two ENV variables allows you to setup the root directory and host.

```
PHP_PUBLIC_DIR: /app
PHP_HOST: app
```

## nodejs

### node-alpine-build

Used to build nodejs project.

Contains build base, git, bash, openssh, python, mysql-client, redis ...

Using latest nodejs LTS image when updating this repo that is compatible with AWS Lambda.

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
