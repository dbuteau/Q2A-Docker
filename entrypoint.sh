#!/bin/bash

set -e
set -u
set -x

ls -al /tmp
/bin/envtpl -o /var/www/html/qa-config.php /tmp/qa-config.php.tpl
ls -al /var/www/html/ | grep qa-config
exec "$@"
