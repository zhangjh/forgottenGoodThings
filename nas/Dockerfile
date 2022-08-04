FROM nextcloud:23.0

WORKDIR ./

RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN cat /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get -y install smbclient libsmbclient-dev && pecl install smbclient && docker-php-ext-enable smbclient
RUN apt-get -y install libmagickcore-6.q16-6-extra
