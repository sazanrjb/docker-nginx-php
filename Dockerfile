FROM ubuntu:focal

LABEL MAINTAINER="Sajan Rajbhandari <sazanrjb@gmail.com>" \
      DESCRIPTION="Container with nginx and php8.1 on Ubuntu OS"

RUN useradd -u 1000 dockeruser

RUN apt-get update && apt-get -y install apt-utils curl wget nano ca-certificates software-properties-common supervisor

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get install -y nginx php8.1 php8.1-fpm php8.1-opcache php8.1-cli php8.1-common \
    php8.1-curl php8.1-mbstring php8.1-intl php8.1-gd php8.1-mysql php8.1-bcmath \
    php8.1-xdebug php8.1-imap && echo "daemon off;" >> /etc/nginx/nginx.conf

RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/8.1/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/8.1/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php8.1-fpm start && nginx