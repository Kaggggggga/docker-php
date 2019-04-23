FROM php:7.1-fpm-stretch

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libfcgi-bin \
        unzip \
        git \
        gettext \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
            bcmath \
            mbstring \
    && docker-php-ext-configure bcmath --enable-bcmath \
    && docker-php-ext-configure mbstring --enable-mbstring

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer


ENV PHP_CONFIG_CUSTOM_LOGLEVEL=notice \
    PHP_CONFIG_CUSTOM_PORT=9000 \
    PHP_CONFIG_CUSTOM_MEMORY_LIMIT=128M \
    LARAVEL_ROOT=/srv \
    LARAVEL_CONFIG_CACHE=1 \
    LARAVEL_ROUTE_CACHE=1

WORKDIR /srv
COPY etc/. /usr/local/etc/
COPY etc/php/php.ini-production /usr/local/etc/php/php.ini

COPY base/. /base
ENTRYPOINT []
