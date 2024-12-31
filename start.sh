#!/bin/bash
cd /var/www/html && rm -rf *
git clone https://github.com/poweradmin/poweradmin.git . || git pull
git checkout master
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
touch /etc/nginx/nginx.conf
cat>>/etc/nginx/nginx.conf<<EOF
events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    tcp_nopush      on;
    tcp_nodelay     on;
    keepalive_timeout  65;
    types_hash_max_size 2048;
    server_tokens off;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen 80 default_server;
        server_name _;

        root /var/www/html;
        index index.php index.html index.htm;

        location / {
            try_files $uri $uri/ /index.php?$args;
        }

        location ~ \.php$ {
            fastcgi_pass unix:/run/php/php8.2-fpm.sock;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include fastcgi_params;
        }

        location ~ /\.ht {
            deny all;
        }
    }
}
EOF
php-fpm8.2 -F &
nginx -g "daemon off;"
tail -f /dev/null