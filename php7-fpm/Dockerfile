ARG VERSION="7.4"

FROM php:${VERSION}-fpm as base

ARG TIMEZONE="UTC"
ENV DEBIAN_FRONTEND=noninteractive
ENV WORKDIR="/var/www"
ENV APP_USER www-data
ENV APP_UID 9000
ENV APP_GROUP www-data
ENV APP_GID 9000

RUN apt-get update && apt-get --no-install-recommends -y dist-upgrade \
    && apt-get install --no-install-recommends -y git zip bzip2 libpng-dev libpng-dev libicu-dev \
    openssl libjpeg62-turbo-dev libfreetype6-dev libonig-dev libcurl4-gnutls-dev \
    libpq-dev libxpm-dev libvpx-dev libbz2-dev zlib1g-dev libzip-dev gnumeric \
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) iconv curl bcmath mbstring bz2 gd zip pgsql pdo_pgsql intl \
    && docker-php-ext-configure gd && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache

# Composer
RUN php -r 'copy("https://getcomposer.org/installer", "composer-setup.php"); \
     	if (hash_file("sha384", "composer-setup.php") !== trim(file_get_contents("https://composer.github.io/installer.sig"))) { \
     		echo "ERROR: Invalid installer signature", PHP_EOL; \
     		return 1; \
     	}' \
     && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
     && rm composer-setup.php;

#RUN chmod 777 /tmp

RUN curl -sL -o/var/cache/apt/archives/apm-agent-php_1.4.2_all.deb https://github.com/elastic/apm-agent-php/releases/download/v1.4.2/apm-agent-php_1.4.2_all.deb \
    && dpkg -i /var/cache/apt/archives/apm-agent-php_1.4.2_all.deb \
    && rm /var/cache/apt/archives/apm-agent-php_1.4.2_all.deb

RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini
# Copy configuration
COPY config/docker.ini /usr/local/etc/php/conf.d/zzz-docker.ini
COPY config/opcache.ini /usr/local/etc/php/conf.d/
COPY config/www.conf /usr/local/etc/php-fpm.d

WORKDIR ${WORKDIR}


EXPOSE 9000
CMD ["php-fpm"]