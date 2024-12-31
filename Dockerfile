FROM debian:stable-slim

RUN apt update -y && \
    apt install -y \
    ca-certificates apt-transport-https software-properties-common wget curl lsb-release \
    php php-intl php-pear php-php-gettext php-tokenizer php-mysql apache2 libapache2-mod-php git vim && \
    pear install DB && pear install pear/MDB2#mysql && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN rm -rf /var/www/html/*

RUN git clone https://github.com/poweradmin/poweradmin.git . && \
    git checkout master && \
    rm -rf .git

RUN echo "ServerTokens Prod" >> /etc/apache2/apache2.conf && \
    echo "ServerSignature Off" >> /etc/apache2/apache2.conf

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
