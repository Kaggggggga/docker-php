#!/usr/bin/env bash
set -e

echo "install swoole"
apt-get update
apt-get install -y --no-install-recommends \
    make \
    g++ \
    gcc \
    libssl-dev

pushd /tmp
curl -o swoole.tar.gz https://github.com/swoole/swoole-src/archive/v${INSTALL_SWOOLE_VERSION}.tar.gz -L
tar xf swoole.tar.gz
cd swoole-src-${INSTALL_SWOOLE_VERSION}
phpize
./configure \
    --enable-openssl \
    --enable-http2 \
    --enable-sockets \
    --enable-mysqlnd
make
make install
make clean
docker-php-ext-enable swoole
echo "swoole.fast_serialize=On" >> /usr/local/etc/php/conf.d/docker-php-ext-swoole-serialize.ini
popd
rm -rf /tmp/*

apt-get purge -y --auto-remove \
        libc6-dev \
        make \
        g++ \
        gcc \
        libssl-dev
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
