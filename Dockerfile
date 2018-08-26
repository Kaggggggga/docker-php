FROM php:7.1-fpm

RUN apt-get update \
    && apt-get install -y \
        unzip \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'ok'

RUN echo 'alias ll="ls -lrt"' >> ~/.bashrc

WORKDIR /code
