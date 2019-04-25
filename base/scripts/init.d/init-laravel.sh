#!/usr/bin/env bash
set -e
if [[ ! -z "$LARAVEL_LOG_PATH" ]]; then
    echo "init laravel log pipe '$LARAVEL_LOG_PATH'"
    mkdir $(dirname $LARAVEL_LOG_PATH)
    mkfifo $LARAVEL_LOG_PATH
    chmod 777 $LARAVEL_LOG_PATH
fi

artisan=$LARAVEL_ROOT/artisan
if [ -f $artisan ]; then
    if [[ ! -z "$LARAVEL_CONFIG_CACHE" ]]; then
        echo "laravel config:cache"
        php $artisan config:cache
    fi
    if [[ ! -z "$LARAVEL_ROUTE_CACHE" ]]; then
        echo "laravel route:cache"
        php $artisan route:cache
    fi

fi