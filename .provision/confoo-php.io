server {
    listen 80;
    server_name confoo-php.io;
    root /vagrant/confoo-2016-php/public;

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log /var/log/nginx/access.log;
    error_log  /var/log/nginx/confoo-2016-php-error.log error;

    sendfile off;

    client_max_body_size 20m;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;

        fastcgi_param HTTP_X_REQUEST_START "t=${msec}";
    }

    location ~ /\.ht {
        deny all;
    }
}
