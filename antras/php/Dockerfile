FROM php:8.2-fpm
WORKDIR /php
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    curl \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pecl install mongodb \
    && docker-php-ext-install pdo pdo_mysql \ 
    && docker-php-ext-enable mongodb pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN /usr/local/bin/composer require mongodb/mongodb