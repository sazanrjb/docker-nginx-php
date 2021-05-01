FROM ubuntu:groovy

LABEL MAINTAINER="Sajan Rajbhandari <sazanrjb@gmail.com>" \
      DESCRIPTION="Container with nginx and php8.0 on Ubuntu OS"

RUN useradd -u 1000 dockeruser

RUN apt-get update && apt-get -y install apt-utils curl wget nano ca-certificates software-properties-common supervisor

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get install -y nginx php8.0 php8.0-fpm php8.0-opcache php8.0-cli php8.0-common \
    php8.0-curl php8.0-mbstring php8.0-intl php8.0-gd php8.0-mysql php8.0-bcmath \
    php8.0-xdebug php8.0-imap && echo "daemon off;" >> /etc/nginx/nginx.conf

RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/8.0/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/8.0/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php8.0-fpm start && nginx