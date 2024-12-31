FROM debian:stable-slim

RUN apt update -y && \
    apt install -y \
    php php-intl php-php-gettext php-tokenizer php-fpm php-mysql nginx git && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /etc/start.sh

RUN chmod +x /etc/start.sh

ENTRYPOINT ["/etc/start.sh"]
