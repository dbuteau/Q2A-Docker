#!/bin/bash
set -e

/bin/envtpl -o /var/www/html/qa-config.php /tmp/qa-config.php.tpl

exec "$@"
