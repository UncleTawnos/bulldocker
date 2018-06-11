FROM wordpress:4.9-php7.0-apache

ENV WORDPRESS_DB_HOST localhosts:3306
ENV WORDPRESS_DB_USER wordpress
ENV WORDPRESS_DB_PASSWORD wordpress
ENV WORDPRESS_DB_NAME wordpress

RUN addgroup wordpress && adduser --system --home /var/www/html --ingroup wordpress  --disabled-password wordpress

RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y vim wget unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY install-plugins.sh  .
COPY plugins.list .
RUN ./install-plugins.sh

RUN wget https://downloads.wordpress.org/translation/core/4.9.4/pl_PL.zip -O pl_PL.zip \
    && unzip pl_PL.zip -d /usr/src/wordpress/wp-content/languages/ \
    && rm pl_PL.zip

COPY --chown=wordpress:wordpress ["plugins/","/usr/src/wordpress/wp-content/plugins/"]
COPY --chown=wordpress:wordpress ["themes/","/usr/src/wordpress/wp-content/themes/"]



