FROM php:7.1-fpm-stretch

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libfcgi-bin \
        unzip \
        git \
        gettext \
        vim

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN docker-php-ext-install \
            bcmath \
            mbstring \
            pdo \
            pdo_mysql \
            tokenizer \
            ctype \
            json

# php-ext xml
RUN apt-get install -y --no-install-recommends \
        libxml2-dev \
    && docker-php-ext-install \
            xml

# php-ext memcached
RUN apt-get install -y --no-install-recommends \
        zlib1g-dev \
        libmemcached-dev \
        libmemcached11 \
        libmemcachedutil2 \
    && git clone --single-branch --branch php7 --depth 1 \
        https://github.com/php-memcached-dev/php-memcached \
        /usr/src/php/ext/memcached \
    && docker-php-ext-configure memcached \
          --disable-memcached-sasl \
    && docker-php-ext-install memcached

# cleanup
RUN echo "alias ll='ls -lrt'" >> $HOME/.bashrc \
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
    LARAVEL_CONFIG_CACHE=1 \
    LARAVEL_ROUTE_CACHE=1 \
    LARAVEL_LOG_PATH=""

WORKDIR /srv
COPY etc/. /usr/local/etc/
COPY etc/php/php.ini-production /usr/local/etc/php/php.ini

COPY base/. /base
ENTRYPOINT []
