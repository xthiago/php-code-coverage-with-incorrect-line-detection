FROM php:7.4.0alpha2-cli-alpine3.10 AS base

MAINTAINER Thiago Rodrigues <me@xthiago.com>

ENV COMPOSER_ALLOW_SUPERUSER="1"
ENV PATH="/var/www/app/bin:/var/www/app/vendor/bin:${PATH}"

WORKDIR /var/www/app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

FROM base AS dev

RUN apk add --no-cache --update $PHPIZE_DEPS
RUN pecl install xdebug-2.8.0alpha1
RUN docker-php-ext-enable xdebug

COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

FROM base AS ci

COPY ./composer.json /var/www/app/composer.json
COPY ./composer.lock /var/www/app/composer.lock

RUN composer install \
    --optimize-autoloader \
    --no-ansi \
    --no-interaction \
    --no-progress \
    --no-suggest

COPY ./src /var/www/app/src
COPY ./tests /var/www/app/tests
COPY ./phpunit.xml /var/www/app/phpunit.xml
