ARG BASE_IMAGE_TAG

FROM ubuntu:${BASE_IMAGE_TAG}

ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_INI_SCAN_DIR="/etc/php/7.3/apache2/conf.d:/var/www/src/docker/etc/php"

RUN \
      apt-get update && \
      apt-get install -y software-properties-common && \
      add-apt-repository ppa:ondrej/php && \
      apt-get install -o Dpkg::Options::=--force-confdef -y apache2  apache2-dev && \
      apt-get install -y imagemagick graphicsmagick && \
      apt-get install php7.3 -y && \
      apt-get install -y php7.3-cli php7.3-common php7.3-curl php7.3-gd php7.3-mysql php7.3-mbstring php7.3-zip php7.3-xml php7.3-xdebug libapache2-mod-php7.3 php7.3-bcmath php7.3-bz2 php7.3-dba php7.3-imap php7.3-intl php7.3-ldap php7.3-odbc php7.3-xmlrpc php7.3-xsl php-imagick

RUN update-alternatives --set php /usr/bin/php7.3 && \
    update-alternatives --set phar /usr/bin/phar7.3 && \
    update-alternatives --set phar.phar /usr/bin/phar.phar7.3

# Disable loading of xdebug.so
RUN rm -f /etc/php/7.3/cli/conf.d/20-xdebug.ini && \
    rm -f /etc/php/7.3/apache2/conf.d/20-xdebug.ini

# Apache module and site mnaagement.
RUN a2enmod rewrite && \
      a2enmod ssl && \
      a2ensite default-ssl

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

EXPOSE 80 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
