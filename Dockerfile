# Prepare q2a code config and plugins
# ====================================
FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add git

RUN git clone https://github.com/q2a/question2answer.git \
 && git clone https://github.com/amiyasahu/Donut.git \
 && git clone https://github.com/ganbox/qa-filter.git /question2answer/qa-plugin/qa-filter \
 && git clone https://github.com/NoahY/q2a-poll.git /question2answer/qa-plugin/qa-poll \
 && git clone https://github.com/svivian/q2a-user-activity-plus.git /question2answer/qa-plugin/qa-user-activity \
 && git clone https://github.com/NoahY/q2a-history.git /question2answer/qa-plugin/qa-user-history \
 && git clone https://github.com/NoahY/q2a-log-tags.git /question2answer/qa-plugin/qa-log-tags \
 && git clone https://github.com/dunse/qa-category-email-notifications.git /question2answer/qa-plugin/qa-email-notification \
 && git clone https://github.com/nakov/q2a-plugin-open-questions.git /question2answer/qa-plugin/qa-questions-open \
 && git clone https://github.com/zakkak/qa-ldap-login.git /question2answer/qa-plugin/qa-ldap-login \
 && git clone https://github.com/Schoaf/qa-mattermost-notifications.git /question2answer/qa-mattermost 
 
RUN mv /Donut/qa-plugin/Donut-admin /question2answer/qa-plugin/
RUN mv /Donut/qa-theme/Donut-theme /question2answer/qa-theme/

# create the final minimal image
# =================================
FROM php:7-fpm-alpine

RUN apk update
RUN apk add openldap-dev
RUN docker-php-ext-install ldap &&\
    docker-php-ext-install mysqli &&\
    docker-php-ext-install mbstring

COPY --from=0 /question2answer/ /var/www/html/
COPY qa-config.php /var/www/html/qa-config.php
COPY .htaccess /var/www/.htaccess
