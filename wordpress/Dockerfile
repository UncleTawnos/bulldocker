FROM wordpress:4.9.4-php7.0-apache

ENV WORDPRESS_DB_HOST localhosts:3306
ENV WORDPRESS_DB_USER wordpress
ENV WORDPRESS_DB_PASSWORD wordpress

RUN addgroup wordpress && adduser --system --home /var/www/html --ingroup wordpress  --disabled-password wordpress

RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y vim wget unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://downloads.wordpress.org/plugin/windows-azure-storage.4.1.1.zip -O windows-azure-storage.4.1.1.zip \
    && unzip windows-azure-storage.4.1.1.zip -d /usr/src/wordpress/wp-content/plugins/ \
    && rm windows-azure-storage.4.1.1.zip

RUN wget https://downloads.wordpress.org/plugin/wp-mail-smtp.zip -O wp-mail-smtp.zip \
    && unzip wp-mail-smtp.zip -d /usr/src/wordpress/wp-content/plugins/ \
    && rm wp-mail-smtp.zip

RUN wget https://downloads.wordpress.org/plugin/contact-form-7.5.0.zip -O contact-form-7.5.0.zip \
    && unzip contact-form-7.5.0.zip -d /usr/src/wordpress/wp-content/plugins/ \
    && rm contact-form-7.5.0.zip

RUN wget https://downloads.wordpress.org/translation/core/4.9.4/pl_PL.zip -O pl_PL.zip \
    && unzip pl_PL.zip -d /usr/src/wordpress/wp-content/languages/ \
    && rm pl_PL.zip

COPY --chown=wordpress:wordpress ["plugins/","/usr/src/wordpress/wp-content/plugins/"]
COPY --chown=wordpress:wordpress ["themes/","/usr/src/wordpress/wp-content/themes/"]
