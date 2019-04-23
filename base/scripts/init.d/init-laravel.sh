#!/usr/bin/env bash
set -e

artisan=$LARAVEL_ROOT/artisan
if [ -f $artisan ]; then
    if [ "$LARAVEL_CONFIG_CACHE" -eq "1" ]; then
        echo "laravel config:cache"
        php $artisan config:cache
    fi
    if [ "$LARAVEL_ROUTE_CACHE" -eq "1" ]; then
        echo "laravel route:cache"
        php $artisan route:cache
    fi
fi