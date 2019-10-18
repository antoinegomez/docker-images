# Docker images

## nodejs

### node-alpine-build

Used to build nodejs project.

Contains build base, git, bash, openssh, python, mysql-client, redis

Using latest nodejs LTS image when updating this repo.

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
