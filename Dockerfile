FROM php:7.4-cli

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update; \
    apt-get install -y libzip-dev zip; \
    docker-php-ext-install zip; \
    apt-get clean ; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
