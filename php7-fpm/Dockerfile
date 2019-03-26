FROM php:7.1-fpm
ARG TIMEZONE="UTC"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get update && apt-get install -y \
    openssl git unzip \
    libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev \
    zlib1g-dev libicu-dev libpq-dev libzip-dev libcurl4-gnutls-dev \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install -j$(nproc) iconv mcrypt exif mbstring curl bcmath \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache \
    && docker-php-ext-configure intl && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) pdo && docker-php-ext-configure pdo_pgsql \
    && docker-php-ext-install -j$(nproc) pdo_mysql pdo_pgsql mysqli \
    && pecl install zip && docker-php-ext-enable zip


RUN apt-get update && apt-get install -y libmagickwand-6.q16-dev --no-install-recommends \
    && ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin \
    && pecl install imagick \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration
COPY config/opcache.ini /usr/local/etc/php/conf.d/
COPY config/expose.ini /usr/local/etc/php/conf.d/


# install xdebug
#RUN pecl install xdebug
#RUN docker-php-ext-enable xdebug
#RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini
RUN mkdir -p /srv/application
WORKDIR "/srv/application"
#RUN usermod -u 1000 www-data

CMD ["php-fpm"]
