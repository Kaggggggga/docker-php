ARG BASE_IMAGE_VERSION_TAG=7.1-fpm-stretch
FROM php:${BASE_IMAGE_VERSION_TAG}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libfcgi-bin \
        unzip \
        git \
        gettext \

    && echo "install composer" \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \

    && echo "install frequently used plugins" \
    && docker-php-ext-install \
            bcmath \
            mbstring \
            pdo \
            pdo_mysql \
            tokenizer \
            ctype \
            json \
            sockets \

    && echo "install xml plugins" \
    && apt-get install -y --no-install-recommends \
        libxml2-dev \
    && docker-php-ext-install \
            xml \

    && echo "install memcached plugins" \
    && apt-get install -y --no-install-recommends \
        zlib1g-dev \
        libmemcached-dev \
        libmemcached11 \
        libmemcachedutil2 \
    && git clone --single-branch --branch php7 --depth 1 \
        https://github.com/php-memcached-dev/php-memcached \
        /usr/src/php/ext/memcached \
    && rm -rf /usr/src/php/ext/memcached/.git \
    && docker-php-ext-configure memcached \
          --disable-memcached-sasl \
    && docker-php-ext-install memcached \

    && echo "cleanup" \
    && apt-get purge -y --auto-remove \
        libxml2-dev \
        zlib1g-dev \
        libmemcached-dev \
        libc6-dev \
        make \
        g++ \
        gcc \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PHP_CONFIG_CUSTOM_LOGLEVEL=notice \
    PHP_CONFIG_CUSTOM_PORT=9000 \
    PHP_CONFIG_CUSTOM_MEMORY_LIMIT=128M \
    LARAVEL_ROOT=/srv \
    LARAVEL_CONFIG_CACHE="true" \
    LARAVEL_ROUTE_CACHE="true" \
    LARAVEL_LOG_PATH=""

WORKDIR /srv
COPY etc/. /usr/local/etc/
COPY etc/php/php.ini-production /usr/local/etc/php/php.ini

COPY base/. /base

## ondemand swoole
ONBUILD ARG INSTALL_SWOOLE=false
ONBUILD ARG INSTALL_SWOOLE_VERSION=4.3.4
ONBUILD RUN [ "${INSTALL_SWOOLE}" = "true" ] \
    && echo "install swoole plugins" \
    && export INSTALL_SWOOLE_VERSION=$INSTALL_SWOOLE_VERSION \
    && bash /base/installs/swoole.sh \
    || echo "install swoole: ${INSTALL_SWOOLE} => done"


ENTRYPOINT ["/base/scripts/start-fpm.sh"]
