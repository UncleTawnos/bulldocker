FROM php:7.4-fpm

ARG TIMEZONE="UTC"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git zip bzip2 libpng-dev libpng-dev libicu-dev \
    openssl libjpeg62-turbo-dev libfreetype6-dev libonig-dev libcurl4-gnutls-dev \
    libpq-dev libxpm-dev libvpx-dev libbz2-dev zlib1g-dev libzip-dev gnumeric \
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) iconv curl bcmath mbstring bz2 gd zip pgsql pdo_pgsql intl \
    && docker-php-ext-configure gd && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod 777 /tmp


RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini
# Copy configuration
COPY config/docker.ini /usr/local/etc/php/conf.d/zzz-docker.ini
COPY config/docker-fpm.conf /usr/local/etc/php-fpm.d/zzz-docker-fpm.conf
COPY config/opcache.ini /usr/local/etc/php/conf.d/
COPY config/expose.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www


EXPOSE 9000
CMD ["php-fpm"]