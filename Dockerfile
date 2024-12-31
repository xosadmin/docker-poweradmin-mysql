FROM debian:stable-slim

RUN apt update -y && \
    apt install -y \
    ca-certificates apt-transport-https software-properties-common wget curl lsb-release \
    php php-intl php-pear php-gettext php-tokenizer php-mysql apache2 libapache2-mod-php git && \
    pear install DB && pear install pear/MDB2#mysql && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN git clone https://github.com/poweradmin/poweradmin.git . && \
    git checkout master && \
    rm -rf .git

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
