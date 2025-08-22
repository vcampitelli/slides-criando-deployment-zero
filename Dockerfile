FROM php:8.4-fpm-alpine

WORKDIR /var/www/html

# Instalando dependências do SO e configurando php-fpm
RUN apk --no-cache add fcgi && \
    echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    wget https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck -O /usr/local/bin/php-fpm-healthcheck && \
    chmod +x /usr/local/bin/php-fpm-healthcheck

# Copiando arquivos
COPY ./ ./

# Configurando healthcheck
HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --start-interval=2s \
    CMD /usr/local/bin/php-fpm-healthcheck || exit 1
