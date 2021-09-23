ARG BASE_IMAGE_TAG

FROM ubuntu:${BASE_IMAGE_TAG}

ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_INI_SCAN_DIR="/etc/php/7.4/apache2/conf.d:/var/www/src/docker/etc/php"

RUN \
      apt-get update && \
      apt-get install -y software-properties-common && \
      add-apt-repository ppa:ondrej/php && \
      apt-get install -o Dpkg::Options::=--force-confdef -y apache2  apache2-dev && \
      apt-get install -y imagemagick graphicsmagick && \
      apt-get install php7.4 -y && \
      apt-get install -y php7.4-cli php7.4-common php7.4-curl php7.4-gd php7.4-mysql php7.4-mbstring php7.4-zip php7.4-xml php7.4-xdebug libapache2-mod-php7.4 php7.4-bcmath php7.4-bz2 php7.4-dba php7.4-imap php7.4-intl php7.4-ldap php7.4-odbc php7.4-xmlrpc php7.4-xsl php-imagick

RUN update-alternatives --set php /usr/bin/php7.4 && \
    update-alternatives --set phar /usr/bin/phar7.4 && \
    update-alternatives --set phar.phar /usr/bin/phar.phar7.4

# Disable loading of xdebug.so
RUN rm -f /etc/php/7.4/cli/conf.d/20-xdebug.ini && \
    rm -f /etc/php/7.4/apache2/conf.d/20-xdebug.ini

# Apache module and site mnaagement.
RUN a2enmod rewrite && \
      a2enmod ssl && \
      a2ensite default-ssl

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

EXPOSE 80 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
