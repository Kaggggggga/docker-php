FROM php:7.1-fpm

RUN apt-get update \
    && apt-get install -y \
        unzip \
    && docker-php-ext-install \
            bcmath \
            mbstring \
    && docker-php-ext-configure bcmath --enable-bcmath \
    && docker-php-ext-configure mbstring --enable-mbstring \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && curl -OL https://github.com/google/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip \
    && unzip protoc-3.6.1-linux-x86_64.zip -d protoc3 \
    && mv protoc3/bin/* /usr/local/bin/ \
    && mv protoc3/include/* /usr/local/include/ \
    && rm -rf ./protoc3 \
    && rm protoc-3.6.1-linux-x86_64.zip \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'ok'

RUN echo 'alias ll="ls -lrt"' >> ~/.bashrc

WORKDIR /code
