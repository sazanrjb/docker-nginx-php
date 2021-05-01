FROM ubuntu:groovy

LABEL MAINTAINER="Sajan Rajbhandari <sazanrjb@gmail.com>" \
      DESCRIPTION="Container with nginx and php8 on Ubuntu OS"

RUN useradd -u 1000 dockeruser

RUN apt install -y php8 php8-fpm php8-opcache php8-cli php8-json php8-common \
    php8-curl php8-mbstring php8-intl php8-session php8-gd php8-mysql php8-bcmath \
    php8-xdebug php8-imap curl supervisor nginx

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php/8/fpm/pool.d/www.conf

RUN apt -y autoremove && apt clean

WORKDIR /var/www

EXPOSE 80

CMD service php8-fpm start && nginx start