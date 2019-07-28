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
 && git clone https://github.com/dbuteau/qa-category-email-notifications.git /question2answer/qa-plugin/qa-email-notification \
 && git clone https://github.com/dbuteau/q2a-plugin-open-questions.git /question2answer/qa-plugin/q2a-open-questions \
 && git clone https://github.com/zakkak/qa-ldap-login.git /question2answer/qa-plugin/qa-ldap-login \
 && git clone https://github.com/Schoaf/qa-mattermost-notifications.git /question2answer/qa-mattermost 
 
RUN mv /Donut/qa-plugin/Donut-admin /question2answer/qa-plugin/
RUN mv /Donut/qa-theme/Donut-theme /question2answer/qa-theme/

FROM golang:1.11.4
WORKDIR /app
RUN apt -y update && apt -y install git
RUN git clone https://github.com/subfuzion/envtpl.git .
RUN CGO_ENABLED=0 GOOS=linux go build \
	-ldflags "-X main.AppVersionMetadata=$(date -u +%s)" \
	-a -installsuffix cgo -o /go/bin/envtpl ./cmd/envtpl/.
RUN ./test/test.sh

FROM php:5.6-apache
MAINTAINER BUTEAU Daniel <daniel.buteau@gmail.com>
LABEL q2a-plugins "qa-filter, qa-poll, qa-user-activity, qa-user-history, qa-log-tags, qa-email-notifications, qa-ldap-login, qa-mattermost"

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
    git libfreetype6-dev libpng-dev libjpeg-dev zlib1g unzip wget && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install mysqli pdo pdo_mysql mbstring && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ &&\
    docker-php-ext-install gd calendar

COPY --from=0 /question2answer/ /var/www/html/
COPY --from=1 /go/bin/envtpl /bin/envtpl
COPY .htaccess /var/www/html/.htaccess
COPY qa-config.php /tmp/qa-config.php.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]





