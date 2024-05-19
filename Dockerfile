FROM ubuntu:focal

LABEL MAINTAINER="Sajan Rajbhandari <sazanrjb@gmail.com>" \
      DESCRIPTION="Container with nginx and php8.2 on Ubuntu OS"

RUN useradd -u 1000 dockeruser

RUN apt-get update && apt-get -y install apt-utils curl wget nano ca-certificates software-properties-common supervisor

RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get install -y nginx php8.2 php8.2-fpm php8.2-opcache php8.2-cli php8.2-common \
    php8.2-curl php8.2-mbstring php8.2-intl php8.2-gd php8.2-mysql php8.2-bcmath \
    php8.2-xdebug php8.2-imap && echo "daemon off;" >> /etc/nginx/nginx.conf

RUN sed -i '/;daemonize /c \
daemonize = no' /etc/php/8.2/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/8.2/fpm/pool.d/www.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
CMD service php8.2-fpm start && nginx