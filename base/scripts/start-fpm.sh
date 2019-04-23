#!/usr/bin/env bash
set -e

init_scripts="/base/scripts/init.d/*"
for script in $init_scripts; do
    if [ -f $script -a -x $script ]; then
        echo "start init script: ${script}"
        . $script
    fi
done

docker-php-entrypoint php-fpm