FROM nextcloud:latest
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN cat /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/*
RUN apt-get update && apt-get -y install smbclient libsmbclient-dev && pecl install smbclient && docker-php-ext-enable smbclient
