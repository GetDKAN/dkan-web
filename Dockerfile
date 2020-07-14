ARG BASE_IMAGE_TAG

FROM drydockcloud/drupal-acquia-httpd:${BASE_IMAGE_TAG}

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
