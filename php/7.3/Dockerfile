FROM php:7.3-fpm
LABEL maintainer="antoine@gomez.lu"

# Install PHP extensions and PECL modules.
RUN buildDeps=" \
        default-libmysqlclient-dev \
        libbz2-dev \
        software-properties-common \
    " \
    runtimeDeps=" \
        curl \
        git \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libpq-dev \
        libzip-dev \
        pkg-config \
        libbson-1.0 \
        libmongoc-1.0-0 \
        python3-pip \
        vim \
        cron python wget sudo unzip gettext-base \
    " \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y $buildDeps $runtimeDeps \
    && pecl install mcrypt-1.0.2 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install bcmath bz2 calendar pcntl iconv intl mbstring mysqli opcache pdo_mysql zip exif \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install redis \
    && docker-php-ext-enable redis.so \
    && docker-php-ext-enable exif \
    && pip3 install awscli --upgrade \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -r /var/lib/apt/lists/*

# Prepare aws agent
# Still need to launch python script in final image to setup config
ADD https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py /awslogs-agent-setup.py
RUN mkdir -p /var/awslogs/conf.d
RUN touch /var/awslogs/awslogs.conf
RUN python /awslogs-agent-setup.py -n -r eu-west-1 -c /var/awslogs/awslogs.conf
RUN mkdir -p /var/www/html
RUN chown www-data:www-data /var/www/html -R
RUN passwd -d www-data
RUN echo 'www-data ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


# ENV IMAGE_PHP_VERSION=7.3

# tweak php-fpm config
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /usr/local/etc/php/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /usr/local/etc/php-fpm.conf && \
    sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i -e "s/pm.max_children = 5/pm.max_children = 9/g" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" /usr/local/etc/php-fpm.d/www.conf

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /composer
USER www-data
ENV PATH=$PATH:/composer/vendor/bin

# Test to make sure extensions are loaded correctly
COPY php/7.3/test.php test.php
RUN php test.php

ENV FILE_UPLOADS On
ENV MEMORY_LIMIT 32
ENV UPLOAD_MAX_FILE_SIZE 1
ENV POST_MAX_SIZE 1

# Copy upload ini config file
# Variables should be replaced by entrypoint script
COPY php/7.3/php-upload.template /usr/local/etc/php/conf.d/php-upload.template
USER root
ENV PATH=$PATH:/composer/vendor/bin
COPY php/7.3/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
