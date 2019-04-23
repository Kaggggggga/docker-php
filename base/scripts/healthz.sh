#!/usr/bin/env bash
set -e
SCRIPT_NAME=/ping
SCRIPT_FILENAME=/ping
REQUEST_METHOD=GET
cgi-fcgi -bind -connect 127.0.0.1:${PHP_CONFIG_CUSTOM_PORT}